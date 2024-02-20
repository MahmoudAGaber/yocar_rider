import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rider_flutter/config/locator/locator.dart';
import 'package:rider_flutter/config/router/app_router.dart';
import 'package:rider_flutter/core/blocs/auth_bloc.dart';
import 'package:rider_flutter/core/extensions/extensions.dart';

enum NavItem {
  home,
  profile,
  announcements,
  wallet,
  favoriteLocations,
  reservedRides,
  rideHistory,
  signIn,
  settings,
  logout,
}

const signedInNavItems = [
  NavItem.profile,
  NavItem.announcements,
  NavItem.wallet,
  NavItem.favoriteLocations,
  NavItem.reservedRides,
  NavItem.rideHistory,
  NavItem.settings,
];

const signedOutNavItems = [
  NavItem.signIn,
];

extension NavItemX on NavItem {
  String name(BuildContext context) {
    switch (this) {
      case NavItem.home:
        return context.translate.home;
      case NavItem.profile:
        return context.translate.profile;
      case NavItem.announcements:
        return context.translate.announcements;
      case NavItem.wallet:
        return context.translate.wallet;
      case NavItem.favoriteLocations:
        return context.translate.favoriteLocations;
      case NavItem.reservedRides:
        return context.translate.scheduledRides;
      case NavItem.rideHistory:
        return context.translate.rideHistory;
      case NavItem.signIn:
        return context.translate.signInSignUp;
      case NavItem.settings:
        return context.translate.settings;
      case NavItem.logout:
        return context.translate.logout;
    }
  }

  IconData get icon {
    switch (this) {
      case NavItem.home:
        return Ionicons.home;
      case NavItem.profile:
        return Ionicons.person;
      case NavItem.announcements:
        return Ionicons.megaphone;
      case NavItem.wallet:
        return Ionicons.wallet;
      case NavItem.favoriteLocations:
        return Ionicons.heart;
      case NavItem.reservedRides:
        return Ionicons.calendar;
      case NavItem.rideHistory:
        return Ionicons.time;
      case NavItem.signIn:
        return Ionicons.log_in;
      case NavItem.settings:
        return Ionicons.settings;
      case NavItem.logout:
        return Ionicons.log_out;
    }
  }

  PageRouteInfo get route {
    switch (this) {
      case NavItem.signIn:
        return const AuthRoute();

      case NavItem.profile:
        return const ProfileParentRoute();

      case NavItem.announcements:
        return const AnnouncementsRoute();

      case NavItem.wallet:
        return const WalletParentRoute();

      case NavItem.favoriteLocations:
        return const FavoriteLocationsRoute();

      case NavItem.reservedRides:
        return const ScheduledRidesRoute();

      case NavItem.rideHistory:
        return const RideHistoryRoute();

      case NavItem.settings:
        return const SettingsParentRoute();

      default:
        return const HomeRoute();
    }
  }

  onPressed(BuildContext context) {
    switch (this) {
      case NavItem.signIn:
        context.router.push(route);
        break;
      case NavItem.logout:
        locator<AuthBloc>().onLoggedOut();
        context.router.replaceAll([const AuthRoute()]);
        break;
      default:
        context.router.push(route);
    }
  }
}
