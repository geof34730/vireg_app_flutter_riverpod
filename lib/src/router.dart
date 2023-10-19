import 'package:Vireg/src/pages/home.dart';
import 'package:Vireg/src/pages/learn.dart';
import 'package:Vireg/src/pages/list.dart';
import 'package:Vireg/src/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class viregrouter {
  getRouter() => GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return Home();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'learn::personalListId',
            builder: (BuildContext context, GoRouterState state) {
              return Learn();
            },
          ),
          GoRoute(
            path: 'list::personalListId',
            builder: (BuildContext context, GoRouterState state) {
              return List();
            },
          ),
          GoRoute(
            path: 'test::personalListId',
            builder: (BuildContext context, GoRouterState state) {
              return Test();
            },
          ),
        ],
      ),
    ],
  );
}
