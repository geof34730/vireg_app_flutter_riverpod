import 'package:flutter/material.dart';

class ResponsiveContent{
  final BuildContext context;
  ResponsiveContent({
    required this.context
  });

  double widthBlockHome(){
    if(typeScreenBreakpoint()=="tablette"){
      return ((MediaQuery.of(context).size.width)/2)-30;
    }
    if(typeScreenBreakpoint()=="mobile"){
      return ((MediaQuery.of(context).size.width))-30;
    }
    return ((MediaQuery.of(context).size.width)/2)-30;
  }


  String typeScreenBreakpoint (){
    const kMobileBreakpoint = 576;
    const kTabletBreakpoint = 1024;

    if(MediaQuery.of(context).size.width<=kMobileBreakpoint){
      return "mobile";
    }
    else{
      return "tablette";
    }
  }


  dynamic choseSize({required dynamic mobileSize, required otherSize}){
    if(typeScreenBreakpoint()=="tablette"){
      return otherSize;
    }
    else{
      return mobileSize;
    }
  }
}