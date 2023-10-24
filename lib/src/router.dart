
import 'package:Vireg/src/pages/home.dart';
import 'package:Vireg/src/pages/learnVerb.dart';
import 'package:Vireg/src/pages/listPersoStep1.dart';
import 'package:Vireg/src/pages/listPersoStep2.dart';
import 'package:Vireg/src/pages/listVerb.dart';
import 'package:Vireg/src/pages/testVerb.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '_widgets/EasySearchBar.dart';
import '_widgets/bottomNavigationBar.dart';

var customRoutes = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name:"home",
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return Scaffold(
            appBar: WidgetsEasySearchBar(),
            body: Home());
      },
      routes: <RouteBase>[
        GoRoute(
          name:"LearnVerb",
          path: 'learnVerb/:personalListId',
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(
                appBar: WidgetsEasySearchBar(),
                bottomNavigationBar: WidgetbottomNavigationBar(indexNav: 0),
                body: LearnVerb());
          },
        ),
        GoRoute(
          name:"ListVerb",
          path: 'listVerb/:personalListId',
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(
                appBar: WidgetsEasySearchBar(),
                bottomNavigationBar: WidgetbottomNavigationBar(indexNav: 2),
                body: ListVerb());
          },
        ),
        GoRoute(
          name:"testVerb",
          path: 'testVerb/:personalListId',
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(
                appBar: WidgetsEasySearchBar(),
                bottomNavigationBar: WidgetbottomNavigationBar(indexNav: 1),
                body: TestVerb());
          },
        ),
        GoRoute(
          name: 'ListPersoStep1',
          path: 'ListPersoStep1',
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(
                appBar: WidgetsEasySearchBar(),
                body: ListPersoStep1());
          },
          routes: <RouteBase>[
            GoRoute(
                name: 'ListPersoStep2',
                path: 'ListPersoStep2',
                builder: (BuildContext context, GoRouterState state) {
                  return Scaffold(
                      appBar: WidgetsEasySearchBar(),
                      body: ListPersoStep2());
                })
          ],
        ),
      ],
    ),
  ],
);