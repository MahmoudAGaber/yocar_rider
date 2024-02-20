import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rider_flutter/config/locator/locator.dart';
import 'package:rider_flutter/core/blocs/place_lookup.dart';
import 'package:flutter_common/core/entities/place.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:flutter_common/core/presentation/buttons/app_primary_button.dart';
import 'package:flutter_common/core/presentation/responsive_dialog/app_top_bar.dart';
import 'package:rider_flutter/core/presentation/place_lookup_state_view.dart';
import 'package:rider_flutter/features/favorite_locations/presentation/blocs/desktop_map.dart';

class LocateFavoriteLocationScreenDesktop extends StatefulWidget {
  final PlaceEntity? centerLocation;

  const LocateFavoriteLocationScreenDesktop({
    super.key,
    this.centerLocation,
  });

  @override
  State<LocateFavoriteLocationScreenDesktop> createState() => _LocateFavoriteLocationScreenDesktopState();
}

class _LocateFavoriteLocationScreenDesktopState extends State<LocateFavoriteLocationScreenDesktop> {
  @override
  void initState() {
    locator<FavoriteLocationsDesktopMapCubit>().locate(
      centerLocation: widget.centerLocation,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: context.theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTopBar(
            title: context.translate.whereIsYourNewFavoriteLocation,
            subtitle: context.translate.locateFavoriteLocationDescription,
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            onChanged: (value) => locator<PlaceLookupBloc>().onQueryChanged(value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Ionicons.search),
              hintText: context.translate.searchLocation,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: BlocBuilder<PlaceLookupBloc, PlaceLookupState>(
              builder: (context, state) {
                return PlaceLookupStateView(
                  state: state,
                  onItemSelected: (place) {
                    locator<FavoriteLocationsDesktopMapCubit>().locate(
                      centerLocation: place,
                    );
                  },
                );
              },
            ),
          ),
          BlocBuilder<FavoriteLocationsDesktopMapCubit, FavoriteLocationsDesktopMapState>(
            builder: (context, state) {
              return AppPrimaryButton(
                isDisabled: state.maybeMap(
                  orElse: () => true,
                  locate: (locate) => locate.centerLocation == null,
                ),
                onPressed: () {
                  final centerlocation = state.maybeMap(
                    orElse: () => throw Exception('Invalid map state'),
                    locate: (locate) => locate.centerLocation!,
                  );
                  context.router.pop(centerlocation);
                },
                child: Text(
                  context.translate.confirm,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
