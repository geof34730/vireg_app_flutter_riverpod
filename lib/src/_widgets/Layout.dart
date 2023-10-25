import 'package:flutter/material.dart';


import 'EasySearchBar.dart';
import 'bottomNavigationBar.dart';
import 'drawerDevTools.dart';

Widget Layout({required BuildContext context,required child,bottomNavigationBar=false,indexBottomNavigationBar=0}){
  return Scaffold(
    appBar: WidgetsEasySearchBar(),
    bottomNavigationBar: (bottomNavigationBar ? WidgetbottomNavigationBar(indexNav: indexBottomNavigationBar) : null),
    body: SingleChildScrollView(
        child:child
    ),
    floatingActionButton: FloatingActionButton(
        elevation: 15,
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context)
              {
                return drawerWidget(context: context);
              }
          );
        },
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