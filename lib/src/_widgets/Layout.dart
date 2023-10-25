import 'package:flutter/material.dart';

import '../pages/home.dart';
import 'EasySearchBar.dart';
import 'bottomNavigationBar.dart';

Widget Layout({required child,bottomNavigationBar=false,indexbottomNavigationBar=0}){
  return Scaffold(
    appBar: WidgetsEasySearchBar(),
    bottomNavigationBar: (bottomNavigationBar ? WidgetbottomNavigationBar(indexNav: indexbottomNavigationBar) : null),
    body: child,
    floatingActionButton: FloatingActionButton(
        elevation: 15,
        onPressed: (){print('debug');},
        child:Text(
          'DEBUG GEOF',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold
          ),
        )
    ),
  );
}