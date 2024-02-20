import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:rider_flutter/config/router/app_router.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:flutter_common/core/presentation/buttons/app_primary_button.dart';
import 'package:rider_flutter/gen/assets.gen.dart';

class ScheduledRidesEmptyState extends StatelessWidget {
  const ScheduledRidesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.rideHistoryEmptyState.image(
            width: 300,
            height: 300,
          ),
          const SizedBox(height: 12),
          Text(
            context.translate.noRidesYet,
            style: context.titleMedium,
          ),
          const SizedBox(height: 24),
          AppPrimaryButton(
            onPressed: () {
              context.router.navigate(const HomeRoute());
            },
            child: Text(context.translate.orderARide),
          )
        ],
      ),
    );
  }
}
