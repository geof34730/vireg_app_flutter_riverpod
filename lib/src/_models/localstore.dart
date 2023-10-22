class localstoreModel {
  String lang;
  localstoreModel({required this.lang});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();
    m['lang'] = lang;
    return m;
  }
}