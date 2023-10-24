import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_widgets/EasySearchBar.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../_widgets/bottomNavigationBar.dart';



class viregBottomNavigationBar {
  viregBottomNavigationBar({required this.ref,required BuildContext this.context});
  final WidgetRef ref;
  final BuildContext context;



  String getParamList(){
      print(GoRouterState.of(context).pathParameters["personalListId"].toString());
      return GoRouterState.of(context).pathParameters["personalListId"].toString();
    }

    int getItemSelect(){
     /* if(this.ref.watch(routerProvider).indexOf("learn")>=0) {
        return 0;
      }
      if(this.ref.watch(routerProvider).indexOf("test")>=0) {
        return 1;
      }
      if(this.ref.watch(routerProvider).indexOf("list")>=0) {
        return 2;
      }*/
      return 0;
    }

    void goItemNav({required int index}){
      switch (index) {
        case 0:
          context.go('/learn/$getParamList()');
          context.goNamed("learn",pathParameters: {"personalListId":getParamList()});
          break;
        case 1:
          context.goNamed("test",pathParameters: {"personalListId":getParamList()});
          break;
        case 2:
          context.goNamed("list",pathParameters: {"personalListId":getParamList()});
          break;
        default:
          context.go('home');
      }
    }


}
