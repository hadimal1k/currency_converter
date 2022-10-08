import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class MyCurrenciesBottomSheet extends StatelessWidget {
  final Map<String, dynamic> currencies;
  final void Function(String code)? onSelectCurrency;

  const MyCurrenciesBottomSheet({super.key, required this.currencies, this.onSelectCurrency});

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
      child: Builder(builder: (context) {
        return Container(
          decoration: ShapeDecoration(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
            ),
            color: Colors.grey[800],
          ),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Select Currency",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              Expanded(
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
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: Text(
                          //textAlign: TextAlign.justify,
                          currencies[currencyCode],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
