import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rider_flutter/config/locator/locator.dart';
import 'package:flutter_common/core/theme/theme.dart';
import 'package:rider_flutter/config/theme/fonts.dart';
import 'package:rider_flutter/core/blocs/settings.dart';
import 'package:rider_flutter/features/auth/presentation/blocs/onboarding_cubit.dart';
import 'package:rider_flutter/features/auth/presentation/screens/onboarding_screen.mobile.dart';
import 'package:rider_flutter/firebase_options.dart';
import 'package:rider_flutter/l10n/messages.dart';
import 'package:flutter_common/l10n/messages.dart' as common_messages;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/router/app_router.dart';
import 'config/router/router_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );
  // await HydratedBloc.storage.clear();
  configureDependencies();
  await Hive.initFlutter();
  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<SettingsCubit>(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: dotenv.maybeGet('APP_NAME') ?? 'YoCar',
            themeMode: ThemeMode.light,
            theme: AppTheme.light(Fonts.primary, Fonts.secondary),
            darkTheme: AppTheme.dark(Fonts.primary, Fonts.secondary),
            locale: Locale(state.locale),
            localizationsDelegates: const [
              ...S.localizationsDelegates,
              common_messages.S.delegate,
            ],
            supportedLocales: S.supportedLocales,
            routerDelegate: locator<AppRouter>().delegate(),
            routeInformationParser: locator<AppRouter>().defaultRouteParser(),
          );
        },
      ),
    );
  }
}
