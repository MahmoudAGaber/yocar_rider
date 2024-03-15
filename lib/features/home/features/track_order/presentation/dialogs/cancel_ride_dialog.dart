import 'package:flutter/material.dart';
import 'package:flutter_common/core/presentation/buttons/app_primary_button.dart';
import 'package:flutter_common/gen/assets.gen.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_common/core/color_palette/color_palette.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:flutter_common/core/presentation/buttons/app_bordered_button.dart';
import 'package:flutter_common/core/presentation/responsive_dialog/app_responsive_dialog.dart';
import 'package:flutter_common/core/presentation/buttons/app_text_button.dart';
import 'package:rider_flutter/features/home/features/track_order/presentation/dialogs/cancel_ride_reason.dart';

class CancelRideDialog extends StatelessWidget {
  const CancelRideDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      type: context.responsive(
        DialogType.bottomSheet,
        xl: DialogType.dialog,
      ),
      // primaryButton: AppPrimaryButton(onPressed: () {

      // }, child: Text(context.translate.findAnotherRide)),
      primaryButton: AppPrimaryButton(
        onPressed: () {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            useSafeArea: false,
            builder: (context) => const CancelRideReasonDialog(),
          );
        },
        //textColor: ColorPalette.error40,
        child: Text(context.translate.cancelMyRide,style: context.titleSmall!.copyWith(color: Colors.white),),
        color: PrimaryButtonColor.error,
      ),
      secondaryButton: AppTextButton(
        onPressed: () => Navigator.of(context).pop(),
        text: context.translate.waitMyRide,
        isPrimary: true,
        color: Colors.black,
        backgroundColor: Colors.grey[300],
      ),
      iconColor: ColorPalette.error40,
      header: (
      SizedBox(height: 60,child:Image.asset("assets/images/sign-in-otp.png"),),
        context.translate.rideCancellation,
        context.translate.cancelRideMessage,
      ),
      child: const SizedBox.shrink(),
    );
  }
}
