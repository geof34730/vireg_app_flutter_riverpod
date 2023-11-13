import 'dart:convert';
import '../_models/PersonalListModel.dart';

class FormatData {

  PersonalListModel responseFormatForPersonalListModel({required String dataReponse}){
    var dataReturn = jsonDecode(jsonDecode(dataReponse)["data"]);
    List<dynamic> formatListVerbForModels=[];
    for (var dataFormat in dataReturn["ListIdVerbs"]) {
      formatListVerbForModels.add(dataFormat);
    }
    dataReturn["listIdVerbs"] = formatListVerbForModels;
    return PersonalListModel.fromJson(dataReturn);
  }

}