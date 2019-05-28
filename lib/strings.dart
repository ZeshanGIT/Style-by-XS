import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Language> getLang() async {
  switch ((await SharedPreferences.getInstance()).getString("lang")) {
    case "en":
      return English();
    case "ta":
      return Tamil();
    default:
      return English();
  }
}

void setLang(String lang) async {
  (await SharedPreferences.getInstance()).setString("lang", "en");
}

class Language {
  String appBarTitle, goodMorning, goodEvening, hello;
  Language({
    @required this.appBarTitle,
    @required this.goodMorning,
    @required this.goodEvening,
    @required this.hello,
  });
}

class English extends Language {
  English()
      : super(
          appBarTitle: "Style",
          goodMorning: "Good Morning",
          goodEvening: "Good Evening",
          hello: "Hello",
        );
}

class Tamil extends Language {
  Tamil()
      : super(
          appBarTitle: "ஸ்டைல்",
          goodMorning: "காலை வணக்கம்",
          goodEvening: "மாலை வணக்கம்",
          hello: "வணக்கம்",
        );
}
