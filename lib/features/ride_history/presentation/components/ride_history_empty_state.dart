import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:rider_flutter/config/router/app_router.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:flutter_common/core/presentation/buttons/app_primary_button.dart';
import 'package:rider_flutter/gen/assets.gen.dart';

class RideHistoryEmptyState extends StatelessWidget {
  const RideHistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.rideHistoryEmptyState.image(
            width: double.infinity,
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
