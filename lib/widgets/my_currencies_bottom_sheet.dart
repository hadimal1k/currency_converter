import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyCurrenciesBottomSheet extends StatelessWidget {
  final Map<String, dynamic> currencies;
  final void Function(String code)? onSelectCurrency;

  const MyCurrenciesBottomSheet(
      {super.key, required this.currencies, this.onSelectCurrency});

  @override
  Widget build(BuildContext context) {
    final currenciesKeys = currencies.keys.toList();

    /**
     * {
     *  "usd": "United States Dollar",
     *  "pkr": "Pakistani Ruppee"
     * }
     * currenciesKeys -> ["usd", "pkr"]
     * usd => currenciesKeys[index]
     * currencies[usd] => United states dollar
     */

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          title: const Text("Select Currency"),
          backgroundColor: const Color.fromARGB(96, 123, 118, 118),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: Colors.black38,
          child: ListView.builder(
            padding: const EdgeInsets.all(15.0),
            itemCount: currenciesKeys.length,
            itemBuilder: (context, index) {
              final currencyCode = currenciesKeys[index];
              return InkWell(
                //GestureDetector
                onTap: () {
                  if (onSelectCurrency != null) {
                    onSelectCurrency!(currencyCode);
                  }
                },
                child: Text(
                  //textAlign: TextAlign.justify,
                  currencies[currencyCode],
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
