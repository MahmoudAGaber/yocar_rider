import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common/config/constants.dart';
import 'package:flutter_common/core/entities/place.dart';
import 'package:flutter_common/core/presentation/app_card_sheet.dart';
import 'package:flutter_common/core/presentation/buttons/app_primary_button.dart';
import 'package:flutter_common/core/presentation/markers/app_marker_address.dart';
import 'package:flutter_common/core/presentation/my_location_button.dart';
import 'package:generic_map/generic_map.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rider_flutter/config/locator/locator.dart';
import 'package:rider_flutter/core/blocs/location.dart';
import 'package:rider_flutter/core/blocs/place_lookup.dart';
import 'package:rider_flutter/core/blocs/settings.dart';
import 'package:rider_flutter/core/datasources/geo_datasource.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:rider_flutter/core/presentation/place_lookup_state_view.dart';

import 'locate_screen_layout_delegate.dart';

class LocateFavoriteLocationScreenMobile extends StatefulWidget {
  final PlaceEntity? initialLocation;

  const LocateFavoriteLocationScreenMobile({
    super.key,
    this.initialLocation,
  });

  @override
  State<LocateFavoriteLocationScreenMobile> createState() => _LocateFavoriteLocationScreenMobileState();
}

class _LocateFavoriteLocationScreenMobileState extends State<LocateFavoriteLocationScreenMobile> {
  PlaceEntity? selectedPlace;
  MapViewController? mapController;

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: LocateLocationLayoutDelegate(),
      children: [
        LayoutId(
          id: LocateLocationLayoutDelegate.mapLayoutId,
          child: BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (previous, current) => previous.mapProvider != current.mapProvider,
            builder: (context, state) {
              return GenericMap(
                mode: MapViewMode.picker,
                onControllerReady: (p0) => mapController = p0,
                provider: state.provider,
                interactive: true,
                padding: const EdgeInsets.all(148),
                centerMarkerBuilder: (context, key, address) => AppMarkerAddresss(
                  key: key,
                  title: context.translate.dragToSelect,
                  address: selectedPlace?.address ?? "",
                ).centerMarker,
                initialLocation:
                    (widget.initialLocation ?? locator<LocationCubit>().state.place ?? Constants.defaultLocation)
                        .toGenericMapPlace,
                addressResolver: (provider, latlng) async {
                  final result = await locator<GeoDatasource>().getAddressForLocation(latLng: latlng);
                  return result.fold(
                    (l) => PlaceEntity(coordinates: latlng.toLatLngEntity, address: "").toGenericMapPlace,
                    (r) => r.toGenericMapPlace,
                  );
                },
                onMapMoved: (newLocation) {
                  setState(() {
                    selectedPlace = newLocation?.toPlaceEntity;
                  });
                },
              );
            },
          ),
        ),
        LayoutId(
          id: LocateLocationLayoutDelegate.cardLayoutId,
          child: BlocBuilder<PlaceLookupBloc, PlaceLookupState>(
            builder: (context, state) {
              final isInitial = state.maybeMap(
                orElse: () => false,
                initial: (_) => true,
              );
              return AppCardSheet(
                isFullScreen: !isInitial,
                child: Padding(
                  padding: const EdgeInsets.all(16).copyWith(top: isInitial ? 0 : 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                      if (!isInitial)
                        Expanded(
                          child: PlaceLookupStateView(
                            state: state,
                            onItemSelected: (place) {
                              setState(() {
                                selectedPlace = place;
                              });
                              mapController?.moveCamera(
                                place.latLng2,
                                16,
                              );
                              locator<PlaceLookupBloc>().onStarted();
                            },
                          ),
                        ),
                      SizedBox(
                        width: double.infinity,
                        child: AppPrimaryButton(
                          onPressed: () {
                            context.router.pop(selectedPlace);
                          },
                          child: Text(context.translate.confirm),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        LayoutId(
          id: LocateLocationLayoutDelegate.actionButtonId,
          child: FloatingActionButton.small(
            onPressed: () => context.router.pop(),
            child: const Icon(Ionicons.arrow_back),
          ),
        ),
        LayoutId(
          id: LocateLocationLayoutDelegate.myLocationButtonId,
          child: MyLocationButton(
            onPressed: () => mapController?.moveCamera(
              locator<LocationCubit>().state.place?.latLng2 ?? Constants.defaultLocation.toGenericMapPlace.latLng,
              16,
            ),
          ),
        ),
      ],
    );
  }
}
