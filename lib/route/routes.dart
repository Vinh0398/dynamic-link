import 'package:dynamic_link/main.dart';
import 'package:dynamic_link/ui/account_page.dart';
import 'package:dynamic_link/ui/news_detail_page.dart';
import 'package:dynamic_link/ui/news_page.dart';
import 'package:dynamic_link/ui/nofications_detail_page.dart';
import 'package:dynamic_link/ui/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoutePath {
  RoutePath._();

  static const splash = '/';
  static const homePath = '/home';
  static const newsPath = '/news';
  static const newsDetailPath = 'newsDetail';
  static const notificationsPath = '/notifications';
  static const notificationsDetailPath = 'notificationsDetail';
  static const accountPath = '/account';
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
// GoRouter configuration
GoRouter get router => GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: RoutePath.newsPath,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomePage(child: child);
      },
      routes: [
        _newsRoute(),
        _notificationRoute(),
        _accountRoute(),
      ],
    ),
  ],
);

GoRoute _newsRoute() {
  return GoRoute(
    path: RoutePath.newsPath,
    pageBuilder: (context, state) {
      return const NoTransitionPage(child: NewsPage());
    },
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: "${RoutePath.newsDetailPath}/:newsId",
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: NewsDetailPage(
              newsId: state.params['newsId'],
            ),
          );
        },
      ),
    ],
  );
}

GoRoute _notificationRoute() {
  return GoRoute(
      path: RoutePath.notificationsPath,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: NotiPage());
      },
      routes: [
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: "${RoutePath.notificationsDetailPath}/:notificationsId",
          builder: (context, state) {
            return NotiDetailPage(
              notificationsId: state.params['notificationsId'],
            );
          },
        ),
      ]);
}

GoRoute _accountRoute() {
  return GoRoute(
    path: RoutePath.accountPath,
    pageBuilder: (context, state) {
      return const NoTransitionPage(child: AccountPage());
    },
  );
}