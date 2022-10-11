import 'package:shared_preferences/shared_preferences.dart';

String currencyListUrl =
    "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies.json";

String exchageRatesUSDUrl =
    "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/usd.json";

late SharedPreferences prefs;