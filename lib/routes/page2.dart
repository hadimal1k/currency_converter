import 'dart:convert';
import 'dart:io';

import 'package:currency_converter/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final usdController = TextEditingController(text: '0.0');
  final _pkrController = TextEditingController();
  Map<String, String> currencies = {};
  Map<String, dynamic> rates = {};
  String selectedCurrency = 'pkr';
  //String selectedCurrencyTo = 'USD';
  late Future<void> initialize;

  @override
  void initState() {
    super.initState();
    initialize = _loadData();
  }

  // void _convertToUsd() {
  //  setState(() {

  //  });
  //}

  Future<void> _loadData() async {
    Uri currencyUri = Uri.parse(currencyListUrl);
    Uri ratesUri = Uri.parse(exchageRatesUSDUrl);

    final responses =
        await Future.wait([http.get(currencyUri), http.get(ratesUri)]);
    if (responses[0].statusCode == HttpStatus.ok &&
        responses[1].statusCode == HttpStatus.ok) {
      String currenciesJson = responses[0].body;
      String ratesJson = responses[1].body;

      currencies = Map.from(jsonDecode(currenciesJson));
      rates = Map.from(jsonDecode(ratesJson));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PKR Currency Converter"),
        backgroundColor: const Color.fromARGB(255, 84, 2, 66),
      ),
      body: FutureBuilder(
          future: initialize,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final keys = currencies.keys.toList();
            //final rate = rates.values.toList();
            // final keysTo = currencies.keys.toList();
            return Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(10),
              decoration: ShapeDecoration(shape: Border.all()),
              child: ListView(
                children: [
                  const Text("From Currency :",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  DropdownButton<String>(
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
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white38),
                    controller: usdController,
                    onChanged: (text) {
                      double? usd = double.tryParse(text);
                      // double? rate =
                      //double.tryParse(rates["usd[selectedCurrency]"]);

                      if (usd != null) {
                        _pkrController.text =
                            "${(rates["usd[selectedCurrency]"] ?? 0 * usd)}";
                        //((rates["selectedCurrency"] ?? 0) / 237)}";
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp('([0-9])+.{0,1}([0-9]*)')),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Amount in ${selectedCurrency.toUpperCase()}',
                      prefixIcon:
                          const Icon(Icons.money_sharp, color: Colors.blue),
                      border: const OutlineInputBorder(),
                      labelStyle: const TextStyle(color: Colors.white38),
                    ),
                    keyboardType: TextInputType.text,
                  ),
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
                  const Text(
                    "Rupee (PKR) :",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white38,
                    ),
                    controller: _pkrController,
                    decoration: const InputDecoration(
                      labelText: 'Amount in PKR',
                      prefixIcon:
                          Icon(Icons.currency_rupee, color: Colors.green),
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.white38),
                    ),
                    /* inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp('([0-9])+.{0,1}([0-9]*)')),
                    ],*/
                  ),
                  const SizedBox(height: 10),
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
}
