
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
}