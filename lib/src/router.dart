import 'package:Vireg/src/_widgets/Layout.dart';
import 'package:Vireg/src/pages/home.dart';
import 'package:Vireg/src/pages/learnVerb.dart';
import 'package:Vireg/src/pages/listPersoStep1.dart';
import 'package:Vireg/src/pages/listPersoStep2.dart';
import 'package:Vireg/src/pages/listVerb.dart';
import 'package:Vireg/src/pages/share.dart';
import 'package:Vireg/src/pages/testVerb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
var customRoutes = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name:"Home",
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          print("build route home");
          return Layout(child:Home(key: UniqueKey()),context: context);
        },
        routes: <RouteBase>[
          GoRoute(
            name:"Share",
            path: 'share/:personalListId',
            builder: (BuildContext context, GoRouterState state) {
              print("***************** share deep link");
              return Layout(child:Share(key: UniqueKey()),context: context,appBar: true);
            },
          ),
          GoRoute(
            name:"LearnVerb",
            path: 'learnVerb/:personalListId',
            builder: (BuildContext context, GoRouterState state) {
              return Layout(child:LearnVerb(key: UniqueKey()),bottomNavigationBar: true,indexBottomNavigationBar: 0,context: context);
            },
          ),
          GoRoute(
            name:"ListVerb",
            path: 'listVerb/:personalListId',
            builder: (BuildContext context, GoRouterState state) {
              return Layout(child:ListVerb(key: UniqueKey()),bottomNavigationBar: true,indexBottomNavigationBar: 2,context: context,paddinLeftRight: 0.0);
            },
          ),
          GoRoute(
            name:"testVerb",
            path: 'testVerb/:personalListId',
            builder: (BuildContext context, GoRouterState state) {
              return Layout(child:TestVerb(key: UniqueKey()),bottomNavigationBar: true,indexBottomNavigationBar: 1,context: context);
            },
          ),
          GoRoute(
            name: 'ListPersoStep1',
            path: 'ListPersoStep1',
            builder: (BuildContext context, GoRouterState state) {
              print("build route ListPersoStep1");
              return Layout(child:ListPersoStep1(key: UniqueKey()),context: context);
            },
            routes: <RouteBase>[
              GoRoute(
                  name: 'ListPersoStep2',
                  path: 'ListPersoStep2',
                  builder: (BuildContext context, GoRouterState state) {
                    print("build route ListPersoStep2");
                    return Layout(child:ListPersoStep2(key: UniqueKey()),context: context);
                  })
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      print("**************REDIRECT 404************");
      return Layout(child:Home(key: UniqueKey()),context: context);
    }
);