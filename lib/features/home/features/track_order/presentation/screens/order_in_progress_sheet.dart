import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_common/core/presentation/buttons/app_bordered_button.dart';
import 'package:flutter_common/core/presentation/buttons/app_list_button.dart';
import 'package:flutter_common/core/presentation/buttons/app_primary_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_common/core/color_palette/color_palette.dart';
import 'package:rider_flutter/config/locator/locator.dart';
import 'package:rider_flutter/core/entities/order.dart';
import 'package:flutter_common/core/enums/order_status.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:flutter_common/core/presentation/app_card_sheet.dart';
import 'package:flutter_common/core/presentation/buttons/app_icon_button.dart';
import 'package:flutter_common/core/presentation/buttons/app_text_button.dart';
import 'package:flutter_common/core/presentation/card_handle.dart';
import 'package:rider_flutter/core/presentation/driver_rating.dart';
import 'package:rider_flutter/core/presentation/payment_method_select_field.dart';
import 'package:rider_flutter/core/presentation/vehicle_info/vehicle_info.dart';
import 'package:flutter_common/core/presentation/waypoints_view/waypoints_view.dart';
import 'package:flutter_common/core/presentation/avatars/driver_avatar.dart';
import 'package:rider_flutter/features/home/features/track_order/presentation/blocs/track_order.dart';
import 'package:rider_flutter/features/home/features/track_order/presentation/components/notice_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../dialogs/cancel_ride_dialog.dart';
import '../dialogs/ride_options_dialog.dart';
import '../dialogs/ride_safety_dialog.dart';

class OrderInProgressSheet extends StatelessWidget {
  final OrderEntity order;

  const OrderInProgressSheet({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppCardSheet(
        height: order.status.viewMode.name == "inProgress"? 455 : 675,
        minSize: order.status.viewMode.name == "inProgress"? .37 : .26,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            const CardHandle(),
            context.responsive(const NoticeBar(), xl: const SizedBox()),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text("${order.driver!.vehicleModel!}, ${order.driver!.vehicleColor!}",style: context.bodySmall!.copyWith(color: Colors.black,fontWeight: FontWeight.w600),),
                  SizedBox(width: 8,),
                  Container(
                    decoration: BoxDecoration(
                      color: context.primary.withOpacity(.3),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Text("${order.driver!.vehiclePlateNumber!}",style: context.bodySmall!.copyWith(color: Colors.black,fontWeight: FontWeight.w600),),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        DriverAvatar(imageUrl: order.driver?.imageUrl),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.driver?.fullName ?? '',
                                style: context.labelLarge,
                              ),
                              DriverRating(
                                rating: order.driver?.rating,
                                textSuffix: "(${order.serviceName})",
                              ),
                            ],
                          ),
                        ),
                        // AppIconButton(
                        //   icon: Ionicons.chatbubble,
                        //   onPressed: () {
                        //     locator<TrackOrderBloc>().showChat();
                        //   },
                        // ),
                        // const SizedBox(width: 8),
                        // AppIconButton(
                        //   icon: Ionicons.call,
                        //   onPressed: () {
                        //     launchUrlString("tel://${order.driver?.mobileNumber}");
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  const Divider(),
                  // VehicleInfo(
                  //   imageUrl: order.serviceImageUrl,
                  //   vehicleModel: order.driver?.vehicleModel,
                  //   vehicleColor: order.driver?.vehicleColor,
                  //   vehiclePlateNumber: order.driver?.vehiclePlateNumber,
                  //   sizeMode: context.responsive(
                  //     order.status == OrderStatus.arrived ? VehicleInfoSizeMode.large : VehicleInfoSizeMode.compact,
                  //     xl: VehicleInfoSizeMode.extraLarge,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(context.translate.paymentMethods,style: context.titleSmall,),
                          ],
                        ),
                        SizedBox(height: 6,),
                        PaymentMethodSelectField(
                          paymentMethod: order.paymentMethod,
                          onPressed: () {
                            locator<TrackOrderBloc>().showPayment();
                          },
                        ),
                      ],
                    ),
                  ),

                  if (order.status == OrderStatus.driverAccepted) ...[
                    const Divider(),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(context.translate.tripDetails,style: context.titleSmall,),
                          ],
                        ),
                        SizedBox(height: 6,),
                        SizedBox(
                          height: 150,
                          child: SingleChildScrollView(
                            child: WayPointsView(
                              waypoints: order.waypoints,
                            ),
                          ),
                        ),
                      ],
                    )

                  ],
                ],
              ),
            ),
            // Container(
            //   height: 16,
            //   decoration: BoxDecoration(
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.02),
            //         blurRadius: 10,
            //         offset: const Offset(0, -5),
            //       )
            //     ],
            //     color: ColorPalette.neutralVariant99,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  // PaymentMethodSelectField(
                  //   paymentMethod: order.paymentMethod,
                  //   onPressed: () {
                  //     locator<TrackOrderBloc>().showPayment();
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 9,
                  // ),
                  const Divider(
                    height: 16,
                  ),
                  InkWell(
                    onTap: (){
                      showDialog(
                        context: context,
                        useSafeArea: false,
                        builder: (context) {
                          return const CancelRideDialog();
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.close),
                            Text(context.translate.cancelTrip,style: context.bodyMedium!.copyWith(color: Colors.red),),

                          ],
                        ),
                        Text(context.translate.cancelRideMessage.substring(0,15),style: context.bodySmall!.copyWith(color: Colors.black54),)


                        // AppTextButton(
                        //   iconData: Ionicons.shield,
                        //   text: context.translate.rideSafety,
                        //   onPressed: () {
                        //     showDialog(
                        //       context: context,
                        //       useSafeArea: false,
                        //       builder: (context) => RideSafetyDialog(
                        //         order: order,
                        //       ),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ),
              SizedBox(height: 6,),
              Row(
                children: [
                  Expanded(
                    child: AppBorderedButton(
                      title: context.translate.call,
                      isPrimary: true,
                      onPressed: () {
                        launchUrlString("tel://${order.driver?.mobileNumber}");
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppPrimaryButton(
                      onPressed: () {
                        locator<TrackOrderBloc>().showChat();
                      },
                      child: Text(context.translate.message),
                    ),
                  ),
                ],
              )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
