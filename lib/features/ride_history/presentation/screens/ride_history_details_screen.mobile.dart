import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_map/generic_map.dart';
import 'package:rider_flutter/core/blocs/settings.dart';
import 'package:rider_flutter/core/entities/order_compact.dart';
import 'package:flutter_common/core/entities/place.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:flutter_common/core/presentation/responsive_dialog/app_top_bar.dart';
import 'package:rider_flutter/features/ride_history/presentation/components/details_sheet.dart';

class RideHistoryDetailsScreenMobile extends StatelessWidget {
  final OrderCompactEntity entity;

  const RideHistoryDetailsScreenMobile({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTopBar(title: context.translate.rideDetails),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BlocBuilder<SettingsCubit, SettingsState>(
                          buildWhen: (previous, current) => previous.mapProvider != current.mapProvider,
                          builder: (context, settingsState) {
                            return GenericMap(
                              mode: MapViewMode.static,
                              initialLocation: entity.waypoints.first.toGenericMapPlace,
                              provider: settingsState.provider,
                              padding: const EdgeInsets.symmetric(
                                vertical: 80,
                                horizontal: 150,
                              ),
                              markers: entity.waypoints.markers,
                              onControllerReady: (controller) {
                                controller.fitBounds(
                                  entity.waypoints.latLngs,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RideHistoryDetailsSheet(entity: entity),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
