String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
String toTitleCase(value) => value.replaceAll(RegExp(' +'), ' ').split(' / ').map((str) => capitalize(str)).join(' / ');