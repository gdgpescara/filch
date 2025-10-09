part of '../app_page.dart';

BlocWidgetListener<BootstrapState> get _stateListener => (context, state) {
  switch (state) {
    case UserLoggedOut():
      Routefly.navigate(routePaths.signIn, arguments: routePaths.path);
      break;
    case AppCanRun():
      Routefly.navigate(routePaths.home);
      break;
    case BeforeDevFest():
      Routefly.navigate(routePaths.countdown);
    case AfterDevFest():
      Routefly.navigate(routePaths.thanks);
      break;
    case UserNeedSortingCeremony():
      Routefly.navigate(routePaths.sortingCeremony);
      break;
    case BootstrapProcessing():
      break;
  }
};
