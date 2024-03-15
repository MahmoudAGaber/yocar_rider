import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common/features/select_language_dialog/select_language_dialog.dart';
import 'package:rider_flutter/config/locator/locator.dart';
import 'package:rider_flutter/core/blocs/settings.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:rider_flutter/features/auth/domain/entities/onboarding.dart';

class OnboardingFormBuilder {
  final int onboardingItemIndex;

  const OnboardingFormBuilder({
    required this.onboardingItemIndex,
  });

  Widget buildHeader(BuildContext context) {
    if (onboardingItemIndex == 0) {
      return SizedBox();
    }
    else{
      return Padding(
          padding: const EdgeInsets.all(32),
          child: onBoardingItem(context).image.image(height: 200)
      );
    }

  }

  Widget buildFooter(BuildContext context) {
    if (onboardingItemIndex == 0) {
      return buildLanguageSelectionFooter(context);

    } else {
      return buildInformationFooter(context);
    }
  }

  Widget buildInformationFooter(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*.35,
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Text(
            onBoardingItem(context).title,
            style: context.headlineSmall?.copyWith(
              color: context.theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*.7,
            child: Text(
              onBoardingItem(context).description,
              style: context.bodyMedium?.copyWith(
                color: context.theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget buildLanguageSelectionFooter(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          onBoardingItem(context).title,
          style: context.titleLarge,
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*.6,
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return LanguageList(
                selectedLanguageCode: state.locale,
                onPressed: (Language language) => locator<SettingsCubit>().changeLanguage(language.code),
              );
            },
          ),
        )
      ],
    );
  }

  OnBoardingItem onBoardingItem(BuildContext context) => onboardingItems(context)[onboardingItemIndex];
}
