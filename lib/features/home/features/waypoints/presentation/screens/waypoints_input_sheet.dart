import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common/config/constants.dart';
import 'package:flutter_common/core/color_palette/color_palette.dart';
import 'package:rider_flutter/config/locator/locator.dart';
import 'package:rider_flutter/config/router/app_router.dart';
import 'package:rider_flutter/core/blocs/auth_bloc.dart';
import 'package:rider_flutter/core/blocs/location.dart';
import 'package:rider_flutter/core/blocs/place_lookup.dart';
import 'package:flutter_common/core/entities/place.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:flutter_common/core/presentation/buttons/app_close_button.dart';
import 'package:flutter_common/core/presentation/buttons/app_primary_button.dart';
import 'package:rider_flutter/core/presentation/place_lookup_state_view.dart';
import 'package:rider_flutter/core/presentation/place_result_item.dart';
import 'package:flutter_common/core/presentation/waypoints_view/icon_destination.dart';
import 'package:flutter_common/core/presentation/waypoints_view/line_connect_destinations.dart';
import 'package:rider_flutter/features/home/presentation/blocs/destination_suggestions.dart';
import 'package:rider_flutter/features/home/presentation/blocs/home.dart';
import 'package:rider_flutter/features/home/presentation/blocs/place_confirm.dart';

import '../blocs/selected_location_field.dart';
import '../components/add_stop_button.dart';
import '../components/location_textfield.dart';

class WaypointsInputSheet extends StatelessWidget {
  final List<PlaceEntity?> waypoints;

  const WaypointsInputSheet({
    super.key,
    required this.waypoints,
  });

  @override
  Widget build(BuildContext context) {
    final placeLookupBloc = locator<PlaceLookupBloc>();
    final homeBloc = locator<HomeCubit>();
    final selectedFieldCubit = locator<SelectedLocationFieldCubit>();

    return Container(
      color: ColorPalette.neutralVariant99,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: placeLookupBloc,
          ),
          BlocProvider.value(
            value: selectedFieldCubit,
          ),
          BlocProvider.value(
            value: locator<DestinationSuggestionsCubit>(),
          )
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    AppCloseButton(
                      onPressed: () {
                        homeBloc.closeWaypointsInput(waypoints: waypoints);
                        locator<SelectedLocationFieldCubit>().onLocationFieldSelected(null);
                      },
                    ),
                    Center(
                      child: Text(
                        context.translate.selectDestinations,
                        style: context.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: waypoints
                            .mapIndexed(
                              (index, e) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: LocationTextfield(
                                  key: UniqueKey(),
                                  onRemoveStop: () => homeBloc.onRemoveStop(index),
                                  index: index,
                                  totalCount: waypoints.length,
                                  initialValue: e,
                                  onFocused: () {
                                    placeLookupBloc.onStarted();
                                    selectedFieldCubit.onLocationFieldSelected(index);
                                  },
                                  onChanged: (value) {
                                    placeLookupBloc.onQueryChanged(value);
                                  },
                                  onMapPressed: (value) {
                                    selectedFieldCubit.onLocationFieldSelected(index);
                                    showConfirmLocation(
                                      waypoints[index] ??
                                          locator<LocationCubit>().state.place ??
                                          Constants.defaultLocation,
                                    );
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ...waypoints.mapIndexed((index, e) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 6,
                              ),
                              IconDestination(
                                isPickupPoint: index == 0,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              if (index != waypoints.length - 1) const LineConnectDestinations(),
                            ],
                          );
                        }),
                        if (waypoints.length < 5) ...[
                          const DottedLine(
                            direction: Axis.vertical,
                            dashColor: ColorPalette.neutral90,
                            lineThickness: 3,
                            lineLength: 24,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          AddSpotButton(onPressed: () => homeBloc.onAddStop())
                        ]
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<SelectedLocationFieldCubit, int?>(
                    builder: (context, state) {
                      if (state == null) return const SizedBox();
                      return BlocBuilder<PlaceLookupBloc, PlaceLookupState>(
                        builder: (context, state) => PlaceLookupStateView(
                          state: state,
                          initialStateView: BlocBuilder<DestinationSuggestionsCubit, DestinationSuggestionsState>(
                            builder: (context, state) => state.maybeMap(
                              orElse: () => const SizedBox(),
                              loaded: (loaded) => ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: loaded.recents.length,
                                separatorBuilder: (context, index) => const Divider(
                                  thickness: 0.3,
                                  indent: 48,
                                  height: 16,
                                ),
                                itemBuilder: (context, index) {
                                  final place = loaded.recents[index];
                                  return PlaceResultItem(
                                    onPressed: () => showConfirmLocation(place),
                                    title: place.address,
                                    isRecent: true,
                                  );
                                },
                              ),
                            ),
                          ),
                          onItemSelected: showConfirmLocation,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                AppPrimaryButton(
                  isDisabled: waypoints.nonNulls.length != waypoints.length,
                  onPressed: () {
                    final isAuthenticated = locator<AuthBloc>().state.isAuthenticated;
                    if (isAuthenticated) {
                      homeBloc.showPreview(
                        waypoints: waypoints.whereNotNull().toList(),
                        directions: [],
                      );
                    } else {
                      context.router.push(const AuthRoute());
                    }
                  },
                  child: Text(context.translate.confirm),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showConfirmLocation(PlaceEntity place) {
    final index = locator<SelectedLocationFieldCubit>().state!;
    locator<HomeCubit>().showConfirmLocation(
      waypoints: waypoints,
      selectedLocation: place,
      index: index,
    );
    locator<PlaceConfirmCubit>().onLoaded(place: place);
    locator<SelectedLocationFieldCubit>().onLocationFieldSelected(null);
  }
}
