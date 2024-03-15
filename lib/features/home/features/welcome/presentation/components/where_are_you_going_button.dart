import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:rider_flutter/gen/assets.gen.dart';

class WhereAreYouGoingButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const WhereAreYouGoingButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      minSize: 0,
      padding: const EdgeInsets.all(0),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(
          //   color: context.theme.inputDecorationTheme.enabledBorder!.borderSide.color,
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              // Transform.translate(
              //   offset: const Offset(-20, 0),
              //   child: Assets.images.car.image(width: 53, height: 53, filterQuality: FilterQuality.high),
              // ),
              Expanded(
                  child: Text(
                context.translate.whereAreYouGoing,
                style: context.bodyLarge?.copyWith(color: context.theme.primaryColor),
              )),
              CircleAvatar(
                radius: 15,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.search,color: Colors.white,),
              )
             // Assets.images.blueArrow.image(width: 28, height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
