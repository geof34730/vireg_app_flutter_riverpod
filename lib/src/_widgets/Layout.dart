import 'package:flutter/material.dart';


import '../_class/Localstore.dart';
import 'EasySearchBar.dart';
import 'bottomNavigationBar.dart';
import 'drawerDevTools.dart';

Widget Layout({required BuildContext context,required child,bottomNavigationBar=false,appBar=true,indexBottomNavigationBar=0}) {
  return Scaffold(


    appBar:  (appBar ? WidgetsEasySearchBar() : null),
    bottomNavigationBar: (bottomNavigationBar ? WidgetbottomNavigationBar(indexNav: indexBottomNavigationBar) : null),
    body: SingleChildScrollView(
        child:Padding(
         padding: EdgeInsets.only(left: 15.0,right: 15.0),
         child:Center(
             child:Container(
                constraints: const BoxConstraints(maxWidth: 700),
                child:child
             )
          )
        )
    ),

    floatingActionButton: FloatingActionButton(
        elevation: 15,
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context)
              {
                return drawerWidget();
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