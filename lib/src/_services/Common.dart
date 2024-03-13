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


class ServiceCommon {
  late BuildContext context;
  ServiceCommon({
    required this.context,
  });
  final dio = Dio();
  Future<String> GetVersion() async {
    final response = await dio.get(
      "$URL_API/version",
      options: Options(
        headers: {
          "Content-type": "application/json;charset=utf-8",
        },
      ),
    );
    //Logger.Blue.log(jsonDecode(response.toString())["lastVersionApp"]);
    return jsonDecode(response.toString())["lastVersionApp"];
  }
}