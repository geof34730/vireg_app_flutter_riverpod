import 'package:Vireg/src/_class/localLang.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:colored_json/colored_json.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../_class/Localstore.dart';


class drawerWidget extends ConsumerWidget {
  drawerWidget({super.key});






  @override
  Widget build(BuildContext context, WidgetRef ref) {

      print(Localstorelocal(context: context,ref: ref).getJsonAllLocalStore());


    return Material(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 75,
              child: Container(
                height: 75.00,
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                      ),
                      const Text(
                        'DEBUG TOOLS GEOFFREY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ]),
              ),
            ),


        SingleChildScrollView(
          child:Container(
              color: Colors.yellow,
              child:Column(
                mainAxisSize: MainAxisSize.max,
               children: [
                  Text("Localstore",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                          color: Colors.blue,
                          padding: const EdgeInsets.all(5.00),
                          child:
                          FutureBuilder<dynamic>(
                            future: Localstorelocal(ref: ref, context: context).getJsonAllLocalStore(),
                            builder: (
                                BuildContext context,
                                AsyncSnapshot<dynamic> snapshot,
                                ) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.connectionState == ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return const Text('Error');
                                } else if (!snapshot.hasData) {
                                  return Text(snapshot.data);
                                } else {
                                  return ColoredJson(
                                    data:snapshot.data,
                                    indentLength: 3,
                                    keyColor: Colors.green,
                                    backgroundColor: Colors.black,
                                    boolColor: Colors.white,
                                    nullColor: Colors.redAccent,
                                    stringColor: Colors.cyan,
                                    curlyBracketColor: Colors.yellow,
                                    doubleColor: Colors.deepOrange,
                                    squareBracketColor: Colors.amber,
                                    commaColor: Colors.yellow,
                                    colonColor: Colors.purple,
                                    intColor: Colors.lime,
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      letterSpacing: 2,
                                    ),
                                  );
                                }
                              } else {
                                return Text('State: ${snapshot.connectionState}');
                              }
                            },
                          )
                        ),
                 Text("Riverpod Provider",
                   style: TextStyle(
                       fontWeight: FontWeight.bold,
                       backgroundColor: Colors.amberAccent
                   ),
                 ),
                 Container(
                   width: double.infinity,
                   color: Colors.black,
                   padding: const EdgeInsets.all(5.00),
                   child: Text('localLangProvider => ${ref.watch(localLangProvider)}',
                     style: TextStyle(
                       color: Colors.yellow
                     ),

                   )
                 )
                 ],
              )
              )
            ),
          ],
        ));
  }
}