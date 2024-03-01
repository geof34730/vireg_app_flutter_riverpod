import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../router.dart';


class ViregBottomNavigationBar {
  ViregBottomNavigationBar({required this.ref,required BuildContext this.context, required int this.indexNav});
  final WidgetRef ref;
  final BuildContext context;
  final int indexNav;

   String getParamList(){
      return "${GoRouterState.of(context).pathParameters["idList"].toString()}/${GoRouterState.of(context).pathParameters["perso"]}";
    }

   int getItemSelect(){
      return this.indexNav;
   }

    void goItemNav({required int index}){
      switch (index) {
        case 0:
          customRoutesVireg.go('/learnVerb/${this.getParamList()}');
          break;
        case 1:
          customRoutesVireg.go('/testVerb/${this.getParamList()}');
          break;
        case 2:
          customRoutesVireg.go('/listVerb/${this.getParamList()}');
          break;
        default:
          customRoutesVireg.go('/');
      }
    }

}
