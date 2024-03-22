import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../../global.dart';
import '../_Utils/string.dart';
import '../_models/PersonalListModel.dart';
import 'dart:convert';

import '../_utils/logger.dart';


class SharePersonalList {
  late BuildContext context;
  SharePersonalList({
    required this.context,
  });
  final dio = Dio();
  Future<PersonalListModel> GetList({required String? idListPerso}) async {



    final response = await dio.get(
        "$URL_API/personalList/$idListPerso",
        options: Options(
          headers: {
            "Content-type": "application/json;charset=utf-8",
          },
        ),
    );
    Logger.Blue.log(personalListModelFromResponseDio(response));
    return personalListModelFromResponseDio(response);

  }

  Future<PersonalListModel> Share({ required PersonalListModel personalList }) async {
/*
    String urlEnv= "$URL_API/personalList";
    final url = Uri.parse(urlEnv);
    final headers = {
      "Content-type": "application/json;charset=utf-8",
    };
    final json = '{'
        '"uuid":"${personalList.id}",'
        '"data":"${personalListModelToJson(personalList)}",'

        '}';
    final response = await post(url, headers: headers, body: jsonEncode(json));
    return jsonDecode(response.body);
*/


    final response = await dio.post(
      "$URL_API/personalList",
      data: {
        "uuid": personalList.id,
        "data":personalListModelToJson(personalList)
      },
      options: Options(
        headers: {
          "Content-type": "application/json;charset=utf-8",
        },
      ),
    );
    Logger.Blue.log(personalListModelFromResponseDio(response));
   // return personalListModelFromResponseDio(response);
    //Logger.Blue.log(PersonalListModel.fromResponseDio(response));
    return personalListModelFromResponseDio(response);
  }

  Future<dynamic> UpdateOrDeleteLoadListeShare({required List listIdListShare}) async {
    String urlEnv= "$URL_API/checklistshare";
    final url = Uri.parse(urlEnv);
    final headers = {
      "Content-type": "application/json;charset=utf-8",
    };
    final json = '{'
        '"listIdListShare":"$listIdListShare"'
        '}';
    final response = await post(url, headers: headers, body: jsonEncode(listIdListShare));
    return jsonDecode(response.body);
  }

  Future<void> DeleteList({required PersonalListModel personalList}) async {
    Logger.Green.log("deletelist");
    final response = await dio.delete(
      "$URL_API/personalList/${personalList.id}",
      options: Options(
        headers: {
          "Content-type": "application/json;charset=utf-8",
        },
      ),
    );
  }

  Future<dynamic> sendShareByEMail({required String pseudo, required String email, required String urlLinkShareFirebase, required String listName }) async {
    String urlEnv = "$URL_API/personalList/sendshare";
    final url = Uri.parse(urlEnv);
    Logger.Blue.log(url);
    final headers = {
      "Content-type": "application/json;charset=utf-8",
    };
    final json = '{'
        '"email": "$email",'
        '"urlLinkShareFirebase": "$urlLinkShareFirebase",'
        '"pseudo":"${capitalize(pseudo)}",'
        '"listName":"${capitalize(listName)}"'
        '}';
    Logger.Green.log(json);
    final response = await post(url, headers: headers, body: json);
    return jsonDecode(response.body);
  }

}