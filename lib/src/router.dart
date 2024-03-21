import 'package:Vireg/src/_models/PersonalListModel.dart';
import 'package:Vireg/src/_widgets/Layout.dart';
import 'package:Vireg/src/screens/home.dart';
import 'package:Vireg/src/screens/learnVerb.dart';
import 'package:Vireg/src/screens/listPersoStep1.dart';
import 'package:Vireg/src/screens/listPersoStep2.dart';
import 'package:Vireg/src/screens/listVerb.dart';
import 'package:Vireg/src/screens/share.dart';
import 'package:Vireg/src/screens/testVerb.dart';
import 'package:Vireg/src/screens/update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '_class/Connectivity.dart';
import '_utils/logger.dart';
final _navKey = GlobalKey<NavigatorState>();

final customRoutesVireg = GoRouter(
    navigatorKey: _navKey,
    debugLogDiagnostics: true,
    routes:[
      GoRoute(
        name:"Home",
        path: '/',
        pageBuilder: (context, state) {
          return transitionRouter(state: state, context: context, child: Layout(backButton:null,child: Home(key: UniqueKey()), context: context));
        },
      ),
      GoRoute(
        name:"Update",
        path: '/update',
        pageBuilder: (context, state) {
          return transitionRouter(state: state, context: context, child:Layout(backButton:null,child:Update(key: UniqueKey()),context: context));
        },
      ),
      GoRoute(
        name:"LearnVerb",
        path: '/learnVerb/:idList/:perso',
        pageBuilder: (context, state) {

          return transitionRouter(state: state, context: context, child: Layout(backButton:"/",child:LearnVerb(key: UniqueKey(),idList:state.pathParameters["idList"],personalList:state.pathParameters["perso"]),bottomNavigationBar: true,indexBottomNavigationBar: 0,context: context));
        },
      ),
      GoRoute(
        name:"Share",
        path: '/share/:idList',
        builder: (BuildContext context, GoRouterState state) {
          print("***************** share deep link");
          Logger.Blue.log("Go router capte Share");
          return Layout(child:Share(key: UniqueKey(),idList:state.pathParameters["idList"]),context: context,appBar: true);
        },
      ),

      GoRoute(
        name:"ListVerb",
        path: '/listVerb/:idList/:perso',
        pageBuilder: (context, state) {
          return transitionRouter(state: state, context: context, child: Layout(backButton:"/",child:ListVerb(key: UniqueKey(),idList:state.pathParameters["idList"],personalList:state.pathParameters["perso"]),bottomNavigationBar: true,indexBottomNavigationBar: 2,context: context,paddinLeftRight: 0.0));
        },
      ),
      GoRoute(
        name:"testVerb",
        path: '/testVerb/:idList/:perso',
        pageBuilder: (context, state) {
          return transitionRouter(state: state, context: context, child: Layout(backButton:"/",child:TestVerb(key: UniqueKey(),idList:state.pathParameters["idList"],personalList:state.pathParameters["perso"]),bottomNavigationBar: true,indexBottomNavigationBar: 1,context: context));
        },
      ),
      GoRoute(
        name: 'addListPersoStep1',
        path: '/add/ListPersoStep1',
        pageBuilder: (context, state) {
          return transitionRouter(state: state, context: context, child: Layout(backButton:"/",child:ListPersoStep1(key: UniqueKey()),context: context));
        },
      ),
      GoRoute(
          name: 'addListPersoStep2',
          path: '/addListPersoStep2/:idList',
          pageBuilder: (context, state) {
            PersonalListModel extraPersonalistUpdate = state.extra as PersonalListModel;
            return transitionRouter(state: state, context: context, child: Layout(backButton:"/",child:ListPersoStep2(key: UniqueKey(),extraPersonalistUpdate:extraPersonalistUpdate,idList:state.pathParameters["idList"]),context: context,paddinLeftRight: 0.0));
          },
      ),
      GoRoute(
        name: 'editListPersoStep1',
        path: '/edit/ListPersoStep1/:idList',
        pageBuilder: (context, state) {
          return transitionRouter(state: state, context: context, child: Layout(backButton:"/",child:ListPersoStep1(key: UniqueKey(),idList:state.pathParameters["idList"]),context: context));
        },
      ),
      GoRoute(
          name: 'editListPersoStep2',
          path: '/editListPersoStep2/:idList',
          pageBuilder: (context, state) {
            PersonalListModel extraPersonalistUpdate = state.extra as PersonalListModel;
            return transitionRouter(state: state, context: context, child: Layout(backButton:"/edit/ListPersoStep1/${state.pathParameters["idList"]}",child:ListPersoStep2(key: UniqueKey(),extraPersonalistUpdate:extraPersonalistUpdate,idList:state.pathParameters["idList"]),context: context,paddinLeftRight: 0.0));
          },
      ),

    ],
    errorBuilder: (context, state) {
      Logger.Red.log("**************REDIRECT 404************");
      Logger.Red.log("path ${state.path}");
      return Layout(child:Home(key: UniqueKey()),context: context);
    },
);


  transitionRouter({required GoRouterState state, required BuildContext context, required Widget child}){
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      barrierDismissible: true,
      barrierColor: Colors.black38,
      opaque: false,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }





