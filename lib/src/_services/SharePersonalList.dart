import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../_Utils/string.dart';
import '../_class/FormatData.dart';
import '../_models/ListVerbsModel.dart';
import '../_models/PersonalListModel.dart';

class SharePersonalList {
  late BuildContext context;
  SharePersonalList({
    required this.context,
  });

  Future<PersonalListModel> GetList({required String idListPerso}) async {
    String urlEnv= "${dotenv.get("URL_API")}/personalList/$idListPerso";
    print(urlEnv);
    final url = Uri.parse(urlEnv);
    final headers = {
      "Content-type": "application/json;charset=utf-8",
    };
    final response = await get(url, headers: headers);
    return FormatData().responseFormatForPersonalListModel(dataReponse: response.body);
  }

  Future<dynamic> Share({required String idListPerso, required PersonalListModel? ListePerso }) async {
    String urlEnv= "${dotenv.get("URL_API")}/personalList";
    final url = Uri.parse(urlEnv);
    print(url);
    String stringDataListPerso  = jsonEncode(ListePerso);
    final headers = {
      "Content-type": "application/json;charset=utf-8",
    };
    final json = '{'
        '"uuid": "$idListPerso",'
        '"data":$stringDataListPerso'
        '}';
    final response = await post(url, headers: headers, body: json);
    return jsonDecode(response.body);
  }

  Future<dynamic> UpdateOrDeleteLoadListeShare({required List listIdListShare}) async {
    String urlEnv= "${dotenv.get("URL_API")}/checklistshare";
    final url = Uri.parse(urlEnv);
    final headers = {
      "Content-type": "application/json;charset=utf-8",
    };
    final json = '{'
        '"listIdListShare":"$listIdListShare"'
        '}';
    final response = await post(url, headers: headers, body: jsonEncode(listIdListShare));
    print(response);
    print(response.body);
    return jsonDecode(response.body);
  }

  Future<dynamic> DeleteList({required String idListPerso, bool }) async {
    String urlEnv= "${dotenv.get("URL_API")}/personalList/$idListPerso";
    print(urlEnv);
    final url = Uri.parse(urlEnv);
    final headers = {
      "Content-type": "application/json;charset=utf-8",
    };
    final response = await delete(url, headers: headers);
    return jsonDecode(response.body);
  }

  Future<dynamic> sendShareByEMail({required String pseudo, required String email, required String urlLinkShareFirebase, required String listName }) async {
    String urlEnv = "${dotenv.get("URL_API")}/personalList/sendshare";
    final url = Uri.parse(urlEnv);
    print(url);
    final headers = {
      "Content-type": "application/json;charset=utf-8",
    };
    final json = '{'
        '"email": "$email",'
        '"urlLinkShareFirebase": "$urlLinkShareFirebase",'
        '"pseudo":"${capitalize(pseudo)}",'
        '"listName":"${capitalize(listName)}"'
        '}';
    print(json);
    final response = await post(url, headers: headers, body: json);
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

}