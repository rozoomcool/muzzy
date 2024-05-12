import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../screens/root/root_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: RootRoute.page,
    ),
  ];
}
