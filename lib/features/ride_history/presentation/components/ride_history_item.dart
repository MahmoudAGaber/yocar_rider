import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_common/core/color_palette/color_palette.dart';
import 'package:rider_flutter/core/entities/order_compact.dart';
import 'package:flutter_common/core/entities/payment_method_union.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:flutter_common/core/presentation/avatars/driver_avatar_secondary.dart';
import 'package:rider_flutter/core/presentation/driver_rating.dart';
import 'package:rider_flutter/core/presentation/vehicle_info/vehicle_plate_view.dart';
import 'package:flutter_common/core/presentation/waypoints_view/waypoints_view.dart';
import 'package:rider_flutter/gen/assets.gen.dart';

class RideHistoryItem extends StatelessWidget {
  final OrderCompactEntity entity;
  final VoidCallback onPressed;

  const RideHistoryItem({
    super.key,
    required this.entity,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).primaryColor
          )
          // image: DecorationImage(
          //   image: Assets.images.historyRidesHeaderBackground.provider(),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          entity.createdAt.formatDateTime,
                          style: context.bodyMedium?.copyWith(
                            // color: ColorPalette.neutralVariant90,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      entity.fee.formatCurrency(entity.currency).contains("0.00") ?
                      Text(
                        entity.paymentMethodUnion.paymentMode.name,
                        style: context.labelLarge?.copyWith(
                          // color: ColorPalette.neutral99,
                        ),
                      ) :Text(
                        entity.fee.formatCurrency(entity.currency),
                        style: context.labelLarge?.copyWith(
                          // color: ColorPalette.neutral99,
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12,right: 12,bottom: 8),
              child: Row(
                children: [
                  Column(
                    children: [
                      Icon(Icons.location_on_rounded),
                      SizedBox(height: 6,),
                      Text(context.translate.distanceInKilometers(entity.distanceBest / 1000),style: context.bodyMedium,),

                    ],
                  ),
                  SizedBox(width: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*.68,
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(child: Text(entity.waypoints[0].address,style: context.bodyMedium!.copyWith(fontSize: 15),overflow: TextOverflow.clip)),
                        SizedBox(height: 4,),
                        Flexible(child: Text(entity.waypoints[1].address,style: context.bodyMedium!.copyWith(color: Colors.grey,overflow: TextOverflow.clip),))
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     color: ColorPalette.neutral99,
            //     border: Border.all(
            //       color: ColorPalette.primary95,
            //     ),
            //   ),
            //   child: Column(
            //     children: [
            //       WayPointsView(
            //         waypoints: entity.waypoints,
            //         startedAt: entity.startedAt,
            //         finishedAt: entity.endedAt,
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
