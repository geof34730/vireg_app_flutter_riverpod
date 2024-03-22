import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../_class/Connectivity.dart';
import 'EasySearchBar.dart';
import 'bottomNavigationBar.dart';
import 'drawerDevTools.dart';
import '../../global.dart' as globals;

Widget Layout({required BuildContext context,String versionApp="",required child,bottomNavigationBar=false,double paddinLeftRight=15.0,appBar=true,indexBottomNavigationBar=0, String? backButton }) {

  return Scaffold(
    appBar:  (appBar ? PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),child:WidgetsEasySearchBar(backButton:backButton)) : null),
    bottomNavigationBar: (bottomNavigationBar
          ?
        WidgetbottomNavigationBar(indexNav: indexBottomNavigationBar)
          :
        Text(
          "Vireg ${globals.versionApp}",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12.00
          ),
          textAlign: TextAlign.center,
        )
    ),
    body: LoaderOverlay(
          overlayColor: Colors.black.withOpacity(0.6),
          useDefaultLoading: false,
          overlayWidget: const Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 150.0,
            ),
          ),
          child: SingleChildScrollView(
                child:Padding(
                 padding: EdgeInsets.only(left: paddinLeftRight,right: paddinLeftRight),
                 child:Center(
                     child:Container(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child:child
                     )
                  )
                )
            )
    ),
/*
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
    ),*/

  );
}