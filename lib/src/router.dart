import 'package:Vireg/src/pages/home.dart';
import 'package:Vireg/src/pages/learn.dart';
import 'package:Vireg/src/pages/list.dart';
import 'package:Vireg/src/pages/listPersoStep1.dart';
import 'package:Vireg/src/pages/listPersoStep2.dart';
import 'package:Vireg/src/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '_widgets/EasySearchBar.dart';

class viregrouter {
  getRouter() => GoRouter(
          routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return Scaffold(appBar: WidgetsEasySearchBar(), body:Home());
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'learn/:personalListId',
                builder: (BuildContext context, GoRouterState state) {
                  return Scaffold(appBar: WidgetsEasySearchBar(), body:Learn());
                },
            ),
            GoRoute(
              path: 'list/:personalListId',
              builder: (BuildContext context, GoRouterState state) {
                return Scaffold(appBar: WidgetsEasySearchBar(), body:List());
              },
            ),
            GoRoute(
              path: 'test/:personalListId',
              builder: (BuildContext context, GoRouterState state) {
                return Scaffold(appBar: WidgetsEasySearchBar(), body:Test());
              },
            ),
            GoRoute(
              path: 'ListPersoStep1',
              builder: (BuildContext context, GoRouterState state) {
                return Scaffold(appBar: WidgetsEasySearchBar(), body:ListPersoStep1());
              },
                routes: <RouteBase>[
                  GoRoute(
                  path: 'ListPersoStep2',
                  builder: (BuildContext context, GoRouterState state) {
                    return Scaffold(appBar: WidgetsEasySearchBar(), body:ListPersoStep2());
                  }
                )
              ],
          ),
        ],
      ),
    ],
  );
}
