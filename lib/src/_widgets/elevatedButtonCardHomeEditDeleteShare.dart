import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../_utils/front.dart';

Widget ElevatedButtonCardHomeEditDeleteShare({visibilityButton = true, bool disabledButton = true ,required Color colorIcon, required dynamic onClickButton, required IconData iconContent, required BuildContext context}) {
  return Visibility(
      visible:visibilityButton,
      child:Container(
          width: ResponsiveContent(context: context).choseSize(mobileSize: 30.00, otherSize: 30.00),
          height: ResponsiveContent(context: context).choseSize(mobileSize: 30.00, otherSize: 30.00),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(0.0),
          child:IconButton(
            key:UniqueKey(),
            padding: const EdgeInsets.all(0.0),
            color: colorIcon,
            alignment: Alignment.center,
            iconSize: ResponsiveContent(context: context).choseSize(mobileSize: 25.00, otherSize: 25.00),
            icon: Icon(iconContent),
            onPressed: (
                disabledButton
                    ?
                    () {
                      onClickButton();
                    }
                    :
                    null
            ),
          )
      )
  );
}