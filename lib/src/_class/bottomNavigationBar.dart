import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../router.dart';


class viregBottomNavigationBar {
  viregBottomNavigationBar({required this.ref,required BuildContext this.context, required int this.indexNav});
  final WidgetRef ref;
  final BuildContext context;
  final int indexNav;

   String getParamList(){
      return GoRouterState.of(context).pathParameters["personalListId"].toString();
    }

    int getItemSelect(){
      return this.indexNav;
    }

    void goItemNav({required int index}){
      switch (index) {
        case 0:
          customRoutes.go('/learnVerb/${this.getParamList()}');
          break;
        case 1:
          customRoutes.go('/testVerb/${this.getParamList()}');
          break;
        case 2:
          customRoutes.go('/listVerb/${this.getParamList()}');
          break;
        default:
          customRoutes.go('/');
      }
    }

}
