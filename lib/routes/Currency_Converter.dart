import 'dart:convert';
import 'dart:ui';
import 'dart:ffi';
import 'dart:io';

import 'package:currency_converter/constants/globals.dart';
import 'package:currency_converter/widgets/my_currencies_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  Map<String, String>? currencies;
  Map<String, dynamic>? rates;
  String selectedCurrency = 'usd';
  String selectedCurrencyTo = 'pkr';
  String usdValue = '1';
  String pkrValue = '1';
  int selectedField = 0;
  int inputCounter = 0;
  DateTime? date;

  late Future<void> initialize;

  @override
  void initState() {
    super.initState();
    initialize = _loadData();
  }

  Future<void> _loadData() async {
    //if (rates == null || currencies == null) {
    dynamic currenciesstr = prefs.getString('currstr');
    currencies = Map.from(jsonDecode(currenciesstr));
    dynamic ratesstr = prefs.getString('ratstr');
    rates = Map.from(jsonDecode(ratesstr));
    int? dateTime = prefs.getInt('myTimeStamp');
    date = DateTime.fromMillisecondsSinceEpoch(dateTime!);
    //console.log('date');
    //int? dateTime = (prefs.getInt('date'));
    //date1 = DateTime.fromMillisecondsSinceEpoch(dateTime!);

    // }
    //ratesstr == null ? null : jsonDecode(ratesstr);

    // if(currencies.isNotEmpty && rates.isNotEmpty) {

    // }
    //}
    if (currencies == null && rates == null) {
      Uri currencyUri = Uri.parse(currencyListUrl);
      Uri ratesUri = Uri.parse(exchageRatesUSDUrl);

      Future.wait([http.get(currencyUri), http.get(ratesUri)])
          .then((responses) {
        if (responses[0].statusCode == HttpStatus.ok &&
            responses[1].statusCode == HttpStatus.ok) {
          String currenciesJson = responses[0].body;
          String ratesJson = responses[1].body;

          currencies = Map.from(jsonDecode(currenciesJson));
          rates = Map.from(jsonDecode(ratesJson));
          //add to shared prefs
          prefs.setString('currstr', currenciesJson);
          prefs.setString('ratstr', ratesJson);
          int timestamp = DateTime.now().millisecondsSinceEpoch;
          prefs.setInt('myTimeStamp', timestamp);

          //var date = DateTime.now().millisecondsSinceEpoch;
          //prefs.setInt('date', date);
        }
        setState(() {});
      });
    }
  }

  void reload() {
    currencies = null;
    rates = null;
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Currency Converter"),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
          future: initialize,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (rates == null || currencies == null) {
              return Column(
                children: [
                  const Text(
                    "Something went wrong, please check you connection",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: reload,
                    child: const Text("Reload"),
                  ),
                ],
              );
            }
            final fromRate = rates!['usd'][selectedCurrency];
            final toRate = rates!['usd'][selectedCurrencyTo];
            if (selectedField == 0) {
              pkrValue =
                  ((toRate / fromRate) * double.parse(usdValue)).toString();
            } else if (selectedField == 1) {
              usdValue =
                  ((fromRate / toRate) * double.parse(pkrValue)).toString();
            }
            // final keys = currencies.keys.toList();
            //final rate = rates.values.toList();
            // final keysTo = currencies.keys.toList();
            return Container(
              padding: const EdgeInsets.all(20.0),
              decoration: ShapeDecoration(shape: Border.all()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10.0),
                  MyCurrecyRow(
                    currencyCode: selectedCurrency,
                    currencyName: currencies![selectedCurrency] ?? "",
                    isSelected: selectedField == 0,
                    value: usdValue,
                    onSelectCurrency: () =>
                        showCurreciesBottomSheet(context, 0),
                    onSelectText: () {
                      if (selectedField != 0) {
                        usdValue = '1';
                        selectedField = 0;
                        inputCounter = 0;
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  MyCurrecyRow(
                    currencyCode: selectedCurrencyTo,
                    currencyName: currencies![selectedCurrencyTo] ?? "",
                    isSelected: selectedField == 1,
                    value: pkrValue,
                    onSelectCurrency: () =>
                        showCurreciesBottomSheet(context, 1),
                    onSelectText: () {
                      if (selectedField != 1) {
                        pkrValue = '1';
                        selectedField = 1;
                        inputCounter = 0;
                        setState(() {});
                      }
                    },
                  ),

                  // TextField(
                  //   style: const TextStyle(
                  //     color: Colors.white38,
                  //   ),
                  //   controller: _pkrController,
                  //   onChanged: (text) {
                  //     if (text == "") {
                  //       usdController.text = text;
                  //     }
                  //     double? usd1 = double.tryParse(text);
                  //     if (usd1 != null) {
                  //       usdController.text = "${((rates["usd"][selectedCurrency] ?? 0) / (rates["usd"][selectedCurrencyTo] ?? 0)) * usd1}";
                  //     }
                  //   },
                  //   decoration: InputDecoration(
                  //     suffixIcon: Align(
                  //         widthFactor: 1.0,
                  //         heightFactor: 1.0,
                  //         //alignment: Alignment.topRight,
                  //         child: OutlinedButton(
                  //           style: OutlinedButton.styleFrom(fixedSize: const Size(80.0, 50.0), side: const BorderSide(style: BorderStyle.solid, color: Colors.white, width: 1), padding: const EdgeInsets.all(22.0), foregroundColor: Colors.white, backgroundColor: Colors.black26),
                  //           child: Text(selectedCurrencyTo),
                  //           onPressed: () {
                  //             showBottomSheet(
                  //                 elevation: 50.0,
                  //                 backgroundColor: const Color.fromARGB(252, 14, 14, 14),
                  //                 shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  //                 context: context,
                  //                 builder: (context) {
                  //                   return MyCurrenciesBottomSheet(
                  //                     currencies: currencies,
                  //                     onSelectCurrency: (String code) {
                  //                       setState(() {
                  //                         selectedCurrencyTo = code;
                  //                       });
                  //                       Navigator.pop(context);
                  //                     },
                  //                   );
                  //                 });
                  //           },
                  //         )),
                  //     labelText: '${currencies[selectedCurrencyTo]}',
                  //     prefixIcon: const Icon(Icons.currency_bitcoin, color: Colors.green),
                  //     border: const OutlineInputBorder(),
                  //     labelStyle: const TextStyle(color: Colors.white38),
                  //   ),
                  //   inputFormatters: [
                  //     FilteringTextInputFormatter.allow(RegExp('([0-9])+.{0,1}([0-9]*)')),
                  //   ],
                  // ),

                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        "Exchange rates according to date $date",
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white38,
                            decoration: TextDecoration.underline),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          _loadData();
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),

                  Row(
                    children: [
                      NumericKeyboard(
                        onKeyboardTap: (text) {
                          if (selectedField == 0) {
                            if (usdValue == '1' && inputCounter == 0) {
                              inputCounter = 1;
                              usdValue = text;
                            } else {
                              inputCounter = 0;
                              if (text.length < 11) {
                                usdValue += text;
                              }
                            }
                          } else if (selectedField == 1) {
                            if (pkrValue == '1' && inputCounter == 0) {
                              inputCounter = 1;
                              pkrValue = text;
                            } else {
                              inputCounter = 0;
                              if (text.length < 11) {
                                pkrValue += text;
                              }
                            }
                          }
                          setState(() {});
                        },
                        textColor: Colors.red,
                        rightButtonFn: () {
                          if (selectedField == 0) {
                            if (usdValue.contains('.')) {
                              usdValue = usdValue;
                            } else {
                              usdValue += '.';
                            }
                            setState(() {});
                          } else {
                            if (pkrValue.contains('.')) {
                              pkrValue = pkrValue;
                            } else {
                              pkrValue += '.';
                            }
                            setState(() {});
                          }
                        },
                        rightIcon: const Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 8,
                        ),
                        leftButtonFn: () {},
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      Column(children: [
                        OutlinedButton(
                            // style: ButtonStyle(fixedSize: Size(5, 20)),
                            onPressed: () {
                              if (selectedField == 0) {
                                usdValue = '1';
                              } else {
                                pkrValue = '1';
                              }
                              setState(() {});
                            },
                            child: const Text(
                              "AC",
                              style: TextStyle(color: Colors.deepOrange),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              if (selectedField == 0) {
                                if (usdValue.length == 1) {
                                  usdValue = '1';
                                } else {
                                  List<String> temp = List<String>.generate(
                                      usdValue.length,
                                      (index) => (usdValue[index]));
                                  for (int i = 0; i < (temp.length) - 1; i++) {
                                    if (i == 0) {
                                      usdValue = temp[i].toString();
                                    } else {
                                      usdValue += temp[i].toString();
                                    }
                                  }
                                }
                              } else {
                                if (pkrValue.length == 1) {
                                  pkrValue = '1';
                                } else {
                                  List<String> temp = List<String>.generate(
                                      pkrValue.length,
                                      (index) => (pkrValue[index]));
                                  for (int i = 0; i < (temp.length) - 1; i++) {
                                    if (i == 0) {
                                      pkrValue = temp[i].toString();
                                    } else {
                                      pkrValue += temp[i].toString();
                                    }
                                  }
                                }
                              }
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.backspace,
                              color: Colors.deepOrange,
                            ))
                      ])
                    ],
                  )
                  /* ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(5.0, 50.0),
                        foregroundColor: Colors.white38,
                        backgroundColor: Colors.lightGreen,
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Convert",
                        style: TextStyle(color: Colors.white38),
                      ),
                    )*/
                ],
              ),
            );
          }),
    );
  }

  Future<T?> showCurreciesBottomSheet<T>(
      BuildContext context, int sheetForText) {
    return showModalBottomSheet<T>(
        elevation: 50.0,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return MyCurrenciesBottomSheet(
            currencies: currencies!,
            onSelectCurrency: (String code) {
              setState(() {
                if (sheetForText == 0) {
                  selectedCurrency = code;
                } else if (sheetForText == 1) {
                  selectedCurrencyTo = code;
                }
              });
              Navigator.pop(context);
            },
          );
        });
  }
}

class MyCurrecyRow extends StatelessWidget {
  final String currencyCode;
  final String currencyName;
  final bool isSelected;
  final String value;
  final Function() onSelectText;
  final Function() onSelectCurrency;

  const MyCurrecyRow({
    super.key,
    required this.currencyCode,
    required this.currencyName,
    required this.isSelected,
    required this.value,
    required this.onSelectText,
    required this.onSelectCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onSelectCurrency,
          child: Text(
            currencyCode.toUpperCase(),
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: GestureDetector(
            onTap: onSelectText,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  value.substring(0, value.length > 11 ? 11 : value.length),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 32,
                    color: isSelected ? Colors.blue : Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    currencyName,
                    style: TextStyle(
                      fontSize: 10,
                      color: isSelected ? Colors.blue : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
