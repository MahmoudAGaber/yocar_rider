import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_flutter/config/locator/locator.dart';
import 'package:rider_flutter/core/blocs/auth_bloc.dart';
import 'package:rider_flutter/core/blocs/location.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';
import 'package:rider_flutter/features/home/presentation/blocs/home.dart';
import 'package:rider_flutter/features/home/presentation/blocs/place_confirm.dart';

import '../blocs/destination_suggestions.dart';
import 'home_screen.desktop.dart';
import 'home_screen.mobile.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
    locator<AuthBloc>().requestUserInfo();
    locator<LocationCubit>().fetchCurrentLocation();
    locator<AuthBloc>().state.mapOrNull(
      authenticated: (authenticated) {
        locator<HomeCubit>().onStarted(true);
        locator<DestinationSuggestionsCubit>().onStarted();
      },
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        locator<HomeCubit>().onStarted(locator<AuthBloc>().state.isAuthenticated);
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: locator<LocationCubit>(),
        ),
        BlocProvider.value(
          value: locator<HomeCubit>(),
        ),
        BlocProvider.value(
          value: locator<PlaceConfirmCubit>(),
        )
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              locator<HomeCubit>().onStarted(state.isAuthenticated);
              locator<DestinationSuggestionsCubit>().onStarted();
            },
          ),
          BlocListener<LocationCubit, LocationState>(
            listener: (context, state) {
              if (locator<HomeCubit>().state.waypoints.firstOrNull == null) {
                locator<HomeCubit>().initializeWelcome(
                  pickupPoint: state.place,
                );
              }
            },
          ),
        ],
        child: context.responsive(
          const HomeScreenMobile(),
          xl: const HomeScreenDesktop(),
        ),
      ),
    );
  }
}
