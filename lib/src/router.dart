
import 'package:Vireg/src/_widgets/Layout.dart';
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
        return Layout(child:Home());
      },
      routes: <RouteBase>[
        GoRoute(
          name:"LearnVerb",
          path: 'learnVerb/:personalListId',
          builder: (BuildContext context, GoRouterState state) {
             return Layout(child:LearnVerb(),bottomNavigationBar: true,indexbottomNavigationBar: 0);
          },
        ),
        GoRoute(
          name:"ListVerb",
          path: 'listVerb/:personalListId',
          builder: (BuildContext context, GoRouterState state) {
            return Layout(child:ListVerb(),bottomNavigationBar: true,indexbottomNavigationBar: 2);
          },
        ),
        GoRoute(
          name:"testVerb",
          path: 'testVerb/:personalListId',
          builder: (BuildContext context, GoRouterState state) {
            return Layout(child:TestVerb(),bottomNavigationBar: true,indexbottomNavigationBar: 1);
          },
        ),
        GoRoute(
          name: 'ListPersoStep1',
          path: 'ListPersoStep1',
          builder: (BuildContext context, GoRouterState state) {
            return Layout(child:ListPersoStep1());
          },
          routes: <RouteBase>[
            GoRoute(
                name: 'ListPersoStep2',
                path: 'ListPersoStep2',
                builder: (BuildContext context, GoRouterState state) {
                  return Layout(child:ListPersoStep2());
                })
          ],
        ),
      ],
    ),
  ],
);