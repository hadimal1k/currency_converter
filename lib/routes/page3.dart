import 'dart:convert';
import 'dart:io';

import 'package:currency_converter/constants/globals.dart';
import 'package:currency_converter/widgets/my_currencies_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:numeric_keyboard/numeric_keyboard.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  // final usdController = TextEditingController(text: "");
  // final _pkrController = TextEditingController(text: "");
  Map<String, String> currencies = {};
  Map<String, dynamic> rates = {};
  String selectedCurrency = 'usd';
  String selectedCurrencyTo = 'pkr';
  String usdValue = '1';
  String pkrValue = '1';
  int selectedField = 0;

  late Future<void> initialize;

  @override
  void initState() {
    super.initState();
    initialize = _loadData();
  }

  Future<void> _loadData() async {
    Uri currencyUri = Uri.parse(currencyListUrl);
    Uri ratesUri = Uri.parse(exchageRatesUSDUrl);

    final responses = await Future.wait([http.get(currencyUri), http.get(ratesUri)]);
    if (responses[0].statusCode == HttpStatus.ok && responses[1].statusCode == HttpStatus.ok) {
      String currenciesJson = responses[0].body;
      String ratesJson = responses[1].body;

      currencies = Map.from(jsonDecode(currenciesJson));
      rates = Map.from(jsonDecode(ratesJson));
    }
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
            }
            final fromRate = rates['usd'][selectedCurrency];
            final toRate = rates['usd'][selectedCurrencyTo];
            if (selectedField == 0) {
              pkrValue = ((toRate / fromRate) * double.parse(usdValue)).toString();
            } else if (selectedField == 1) {
              usdValue = ((fromRate / toRate) * double.parse(pkrValue)).toString();
            }
            // final keys = currencies.keys.toList();
            //final rate = rates.values.toList();
            // final keysTo = currencies.keys.toList();
            return Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(10),
              decoration: ShapeDecoration(shape: Border.all()),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  /* const Text(
                    "From",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),*/
                  /*
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(25.0)),
                    onPressed: () {
                      showBottomSheet(
                          elevation: 50.0,
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          context: context,
                          builder: (context) {
                            return MyCurrenciesBottomSheet(
                              currencies: currencies,
                              onSelectCurrency: (String code) {
                                setState(() {
                                  selectedCurrency = code;
                                });
                                Navigator.pop(context);
                              },
                            );
                          });
                    },
                    child: const Text(
                      "Select Currency",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),*/

                  /* DropdownButton<String>(
                    iconSize: 50.0,
                    iconEnabledColor: Colors.blue,
                    //icon: Icons(Icons.currency_bitcoin),
                    style: const TextStyle(color: Colors.blueAccent),
                    //backgroundColor: Colors.purpleAccent),
                    value: selectedCurrency,
                    selectedItemBuilder: (context) {
                      return [
                        for (int i = 0; i < keys.length; i++)
                          Center(child: Text(keys[i].toString().toUpperCase()))
                      ];
                    },
                    //hint: const Text("Select Currency"),
                    items: [
                      for (int i = 0; i < keys.length; i++)
                        DropdownMenuItem<String>(
                          value: keys[i],
                          child: Text(currencies[keys[i]] ?? ""),
                        )
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedCurrency = value ?? 'pkr';
                      });
                    },
                  ),*/
                  const SizedBox(
                    height: 30.0,
                  ),
                  MyCurrecyRow(
                    currencyCode: selectedCurrency,
                    currencyName: currencies[selectedCurrency] ?? "",
                    isSelected: selectedField == 0,
                    value: usdValue,
                    onSelectCurrency: () => showCurreciesBottomSheet(context, 0),
                    onSelectText: () {
                      if (selectedField != 0) {
                        usdValue = '1';
                        selectedField = 0;
                        setState(() {});
                      }
                    },
                  ),
                  // TextField(
                  //   style: const TextStyle(color: Colors.white38),
                  //   controller: usdController,
                  //   onChanged: (text) {
                  //     if (text == "") {
                  //       _pkrController.text = text;
                  //     }
                  //     double? usd = double.tryParse(text);
                  //     if (usd != null) {
                  //       _pkrController.text =
                  //           "${((rates["usd"][selectedCurrencyTo] ?? 0) / (rates["usd"][selectedCurrency] ?? 0)) * usd}";
                  //     }
                  //   },
                  //   inputFormatters: [
                  //     FilteringTextInputFormatter.allow(
                  //         RegExp('([0-9])+.{0,1}([0-9]*)')),
                  //   ],
                  //   decoration: InputDecoration(
                  //     suffixIcon: Align(
                  //       widthFactor: 1.0,
                  //       heightFactor: 1.0,
                  //       child: OutlinedButton(
                  //         style: OutlinedButton.styleFrom(
                  //           padding: EdgeInsets.all(22.0),
                  //           fixedSize: Size(80.0, 50.0),
                  //           side: const BorderSide(
                  //               style: BorderStyle.solid,
                  //               color: Colors.white,
                  //               width: 1),
                  //           foregroundColor: Colors.white,
                  //           backgroundColor: Colors.black38,
                  //         ),
                  //         child: Text(selectedCurrency),
                  //         onPressed: () {
                  //           showBottomSheet(
                  //               elevation: 50.0,
                  //               backgroundColor:
                  //                   const Color.fromARGB(247, 7, 7, 7),
                  //               shape: const RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.vertical(
                  //                       top: Radius.circular(20))),
                  //               context: context,
                  //               builder: (context) {
                  //                 return MyCurrenciesBottomSheet(
                  //                   currencies: currencies,
                  //                   onSelectCurrency: (String code) {
                  //                     setState(() {
                  //                       selectedCurrency = code;
                  //                     });
                  //                     Navigator.pop(context);
                  //                   },
                  //                 );
                  //               });
                  //         },
                  //       ),
                  //     ),
                  //     labelText: '${currencies[selectedCurrency]}',
                  //     prefixIcon:
                  //         const Icon(Icons.money_sharp, color: Colors.blue),
                  //     border: const OutlineInputBorder(),
                  //     labelStyle: const TextStyle(color: Colors.white38),
                  //   ),
                  //   keyboardType: TextInputType.text,
                  // ),

                  const SizedBox(height: 10),
                  /*const Text(
                    "To Currency :",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton(
                    iconSize: 50.0,
                    iconEnabledColor: Colors.greenAccent,
                    style: const TextStyle(color: Colors.greenAccent),
                    value: selectedCurrencyTo,
                    selectedItemBuilder: (context) {
                      return [
                        for (int i = 0; i < keysTo.length; i++)
                          Center(
                            child: Text(keysTo[i].toString().toUpperCase()),
                          )
                      ];
                    },
                    items: [
                      for (int i = 0; i < keysTo.length; i++)
                        DropdownMenuItem<String>(
                            value: keysTo[i],
                            child: Text(currencies[keysTo[i]] ?? "")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedCurrencyTo = value ?? 'USD';
                      });
                    },
                  ),*/
                  /*const Text(
                    "To :",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),*/
                  const SizedBox(height: 10.0),
                  MyCurrecyRow(
                    currencyCode: selectedCurrencyTo,
                    currencyName: currencies[selectedCurrencyTo] ?? "",
                    isSelected: selectedField == 1,
                    value: pkrValue,
                    onSelectCurrency: () => showCurreciesBottomSheet(context, 1),
                    onSelectText: () {
                      if (selectedField != 1) {
                        pkrValue = '1';
                        selectedField = 1;
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

                  const SizedBox(height: 10),
                  NumericKeyboard(
                      onKeyboardTap: (text) {
                        if (selectedField == 0) {
                          if (usdValue == '1') {
                            usdValue = text;
                          } else {
                            usdValue += text;
                          }
                        } else if (selectedField == 1) {
                          if (pkrValue == '1') {
                            pkrValue = text;
                          } else {
                            pkrValue += text;
                          }
                        }
                        setState(() {});
                      },
                      textColor: Colors.red,
                      rightButtonFn: () {},
                      rightIcon: const Icon(
                        Icons.backspace,
                        color: Colors.red,
                      ),
                      leftButtonFn: () {
                        
                      },
                      leftIcon: const Icon(
                        Icons.circle,
                        color: Colors.red,
                        size: 8,
                      ),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly)
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

  PersistentBottomSheetController<T> showCurreciesBottomSheet<T>(BuildContext context, int sheetForText) {
    return showBottomSheet<T>(
        elevation: 50.0,
        backgroundColor: const Color.fromARGB(252, 14, 14, 14),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Scaffold(
            body: MyCurrenciesBottomSheet(
              currencies: currencies,
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
            ),
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
            // () {
            //   if (selectedText != 1) {
            //     pkrValue = 1;
            //     selectedText = 1;
            //     setState(() {});
            //   }
            // },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  value.toString(),
                  textAlign: TextAlign.right,
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
