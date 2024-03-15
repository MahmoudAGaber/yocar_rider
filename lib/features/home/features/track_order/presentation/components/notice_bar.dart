import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_common/core/color_palette/color_palette.dart';
import 'package:flutter_common/core/enums/order_status.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';

import '../../../../presentation/blocs/home.dart';

class NoticeBar extends StatelessWidget {
  const NoticeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => const SizedBox(),
          rideInProgress: (value) {
            switch (value.order.status) {
              case OrderStatus.driverAccepted:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      // const Icon(
                      //   Ionicons.time,
                      //   color: ColorPalette.neutral70,
                      // ),
                      // const SizedBox(width: 8),
                      Expanded(
                        child: StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 1)),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            return Text(
                              value.order.expectedAt.isAfter(DateTime.now())
                                  ? context.translate.driverShouldAriveInNotice
                                  : context.translate.driverShouldHaveArrivedNotice,
                              style: context.titleSmall?.copyWith(
                                color: ColorPalette.neutral0,
                              ),
                            );
                          },
                        ),
                      ),
                      StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1)),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if (value.order.expectedAt.isBefore(DateTime.now())) return const SizedBox();
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: ColorPalette.neutralVariant99,
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                            ),
                            child: Text(
                              _timeFromNow(
                                context,
                                value.order.expectedAt,
                              ),
                              style: context.labelSmall,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );

              case OrderStatus.arrived:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      // const Icon(
                      //   Ionicons.time,
                      //   color: ColorPalette.error60,
                      // ),
                      // const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          context.translate.driverArrivedNotice,
                          style: context.titleSmall?.copyWith(
                            color: ColorPalette.neutral0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );

              case OrderStatus.started:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      // const Icon(
                      //   Ionicons.time,
                      //   color: ColorPalette.neutral70,
                      // ),
                      // const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          context.translate.headingToDestination,
                          style: context.titleSmall?.copyWith(
                            color: ColorPalette.neutral0,
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1)),
                        builder: (context, state) {
                          final arrivalTime = value.order.expectedAt.add(
                            Duration(
                              minutes: value.order.duration ~/ 60,
                            ),
                          );
                          if (arrivalTime.isBefore(DateTime.now())) return const SizedBox();
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: ColorPalette.neutralVariant99,
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                            ),
                            child: Text(
                              _timeFromNow(
                                context,
                                arrivalTime,
                              ),
                              style: context.labelSmall,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );

              default:
                return const SizedBox();
            }
          },
        );
      },
    );
  }

  String _timeFromNow(BuildContext context, DateTime dateTime) {
    final difference = dateTime.difference(DateTime.now());
    if (difference.inMinutes > 0) {
      return context.translate.minutesRange(difference.inMinutes.toString());
    } else {
      return context.translate.secondsRange(difference.inSeconds.toString());
    }
  }
}
