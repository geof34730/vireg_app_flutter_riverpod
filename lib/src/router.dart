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
final customRoutesVireg = GoRouter(
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
            path: 'share/:idList',
            builder: (BuildContext context, GoRouterState state) {
              print("***************** share deep link");
              return Layout(child:Share(key: UniqueKey(),idList:state.pathParameters["idList"]),context: context,appBar: true);
            },
          ),
          GoRoute(
            name:"LearnVerb",
            path: 'learnVerb/:idList/:perso',
            builder: (BuildContext context, GoRouterState state) {
              return Layout(child:LearnVerb(key: UniqueKey(),idList:state.pathParameters["idList"],personalList:state.pathParameters["perso"]),bottomNavigationBar: true,indexBottomNavigationBar: 0,context: context);
            },
          ),
          GoRoute(
            name:"ListVerb",
            path: 'listVerb/:idList/:perso',
            builder: (BuildContext context, GoRouterState state) {
              return Layout(child:ListVerb(key: UniqueKey(),idList:state.pathParameters["idList"],personalList:state.pathParameters["perso"]),bottomNavigationBar: true,indexBottomNavigationBar: 2,context: context,paddinLeftRight: 0.0);
            },
          ),
          GoRoute(
            name:"testVerb",
            path: 'testVerb/:idList/:perso',
            builder: (BuildContext context, GoRouterState state) {
              return Layout(child:TestVerb(key: UniqueKey(),idList:state.pathParameters["idList"],personalList:state.pathParameters["perso"]),bottomNavigationBar: true,indexBottomNavigationBar: 1,context: context);
            },
          ),
          GoRoute(
            name: 'addListPersoStep1',
            path: 'add/ListPersoStep1',
            builder: (BuildContext context, GoRouterState state) {
              print("build route Add ListPersoStep1");
              return Layout(child:ListPersoStep1(key: UniqueKey()),context: context);
            },
            routes: <RouteBase>[
              GoRoute(
                  name: 'addListPersoStep2',
                  path: 'addListPersoStep2/:idList',
                  builder: (BuildContext context, GoRouterState state) {
                    print("build route Edit ListPersoStep2");
                    return Layout(child:ListPersoStep2(key: UniqueKey(),idList:state.pathParameters["idList"]),context: context,paddinLeftRight: 0.0);
                  })
            ],
          ),
          GoRoute(
            name: 'editListPersoStep1',
            path: 'edit/ListPersoStep1/:idList',
            builder: (BuildContext context, GoRouterState state) {
              print("build route Edit ListPersoStep1");
              return Layout(child:ListPersoStep1(key: UniqueKey(),idList:state.pathParameters["idList"]),context: context);
            },
            routes: <RouteBase>[
              GoRoute(
                  name: 'editListPersoStep2',
                  path: 'editListPersoStep2',
                  builder: (BuildContext context, GoRouterState state) {
                    print("build route Edit ListPersoStep2");
                    return Layout(child:ListPersoStep2(key: UniqueKey(),idList:state.pathParameters["idList"]),context: context,paddinLeftRight: 0.0);
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