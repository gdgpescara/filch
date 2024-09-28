part of '../app_page.dart';

BlocWidgetListener<BootstrapState> get _stateListener => (context, state) {
      switch (state) {
        case UserLoggedOut():
          Routefly.navigate(routePaths.signIn);
          break;
        case StaffUserLoggedIn():
          Routefly.navigate(routePaths.staff.path);
          break;
        case AppCanRun():
          Routefly.navigate(routePaths.user.home);
          break;
        case UserNeedSortingCeremony():
        case BootstrapProcessing():
          break;
      }
    };
