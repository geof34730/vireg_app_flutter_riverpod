import 'package:flutter/material.dart';


import '../_class/Localstore.dart';
import 'EasySearchBar.dart';
import 'bottomNavigationBar.dart';
import 'drawerDevTools.dart';

Widget Layout({required BuildContext context,required child,bottomNavigationBar=false,double paddinLeftRight=15.0,appBar=true,indexBottomNavigationBar=0}) {
  return Scaffold(


    appBar:  (appBar ? WidgetsEasySearchBar() : null),
    bottomNavigationBar: (bottomNavigationBar ? WidgetbottomNavigationBar(indexNav: indexBottomNavigationBar) : null),
    body: SingleChildScrollView(
        child:Padding(
         padding: EdgeInsets.only(left: paddinLeftRight,right: paddinLeftRight),
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