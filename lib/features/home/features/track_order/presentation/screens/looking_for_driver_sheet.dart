import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common/core/color_palette/color_palette.dart';
import 'package:flutter_common/core/presentation/buttons/app_primary_button.dart';
import 'package:flutter_common/core/presentation/card_handle.dart';
import 'package:flutter_common/core/presentation/responsive_dialog/app_dialog_header.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rider_flutter/config/locator/locator.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:flutter_common/core/presentation/app_card_sheet.dart';
import 'package:rider_flutter/gen/assets.gen.dart';

import '../blocs/track_order.dart';

class LookingForDriverSheet extends StatelessWidget {
  const LookingForDriverSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardSheet(
      height: 300,
      minSize: .25,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // AppDialogHeader(
            //   icon: Ionicons.car_sport,
            //   title: context.translate.rideRequested,
            //   subtitle: context.translate.searchingForAnOnlineDriver,
            // ),
            SizedBox(height: 8,),
            CardHandle(),
            SizedBox(height: 12,),
            Text(context.translate.searchingForAnOnlineDriver,style: context.labelLarge,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: CircularProgressIndicator(strokeWidth: 5,color: ColorPalette.primary70,backgroundColor: Theme.of(context).primaryColor,),
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width*.9,
              child: AppPrimaryButton(
                color: PrimaryButtonColor.error,
                onPressed: () {
                  locator<TrackOrderBloc>().cancelRide(cancelReasonId: null, cancelReasonNote: null);
                },
                child: Text(context.translate.cancel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
