import 'package:Vireg/src/_widgets/Layout.dart';
import 'package:Vireg/src/pages/home.dart';
import 'package:Vireg/src/pages/learnVerb.dart';
import 'package:Vireg/src/pages/listPersoStep1.dart';
import 'package:Vireg/src/pages/listPersoStep2.dart';
import 'package:Vireg/src/pages/listVerb.dart';
import 'package:Vireg/src/pages/testVerb.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


var customRoutes = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name:"home",
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return Layout(child:Home(),context: context);
      },
      routes: <RouteBase>[
        GoRoute(
          name:"LearnVerb",
          path: 'learnVerb/:personalListId',
          builder: (BuildContext context, GoRouterState state) {
             return Layout(child:LearnVerb(),bottomNavigationBar: true,indexBottomNavigationBar: 0,context: context);
          },
        ),
        GoRoute(
          name:"ListVerb",
          path: 'listVerb/:personalListId',
          builder: (BuildContext context, GoRouterState state) {
            return Layout(child:ListVerb(),bottomNavigationBar: true,indexBottomNavigationBar: 2,context: context);
          },
        ),
        GoRoute(
          name:"testVerb",
          path: 'testVerb/:personalListId',
          builder: (BuildContext context, GoRouterState state) {
            return Layout(child:TestVerb(),bottomNavigationBar: true,indexBottomNavigationBar: 1,context: context);
          },
        ),
        GoRoute(
          name: 'ListPersoStep1',
          path: 'ListPersoStep1',
          builder: (BuildContext context, GoRouterState state) {
            return Layout(child:ListPersoStep1(),context: context);
          },
          routes: <RouteBase>[
            GoRoute(
                name: 'ListPersoStep2',
                path: 'ListPersoStep2',
                builder: (BuildContext context, GoRouterState state) {
                  return Layout(child:ListPersoStep2(),context: context);
                })
          ],
        ),
        GoRoute(
          name:"Share",
          path: 'share/:personalListId',
          builder: (BuildContext context, GoRouterState state) {
            print("***************** share deep link");
            var personalListId = state.pathParameters['personalListId']!;
            return Layout(child:Text('SHARE $personalListId'),bottomNavigationBar: false,indexBottomNavigationBar: 0,context: context);
          },
        ),
      ],
    ),
  ],
);