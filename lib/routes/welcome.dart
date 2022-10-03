import 'dart:ui';

import 'package:currency_converter/routes/page2.dart';
import 'package:currency_converter/routes/page3.dart';
import 'package:flutter/material.dart';

class WelcomeRoute extends StatelessWidget {
  const WelcomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.currency_bitcoin),
          title: const Text("Currency Converter"),
          elevation: 10,
          // centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 84, 2, 66)),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(20.0),
        decoration: ShapeDecoration(
          shape: Border.all(),
          color: const Color.fromARGB(172, 72, 4, 74),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Select Converter",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(25.0),
                  foregroundColor: Colors.white70,
                  backgroundColor: const Color.fromARGB(255, 42, 97, 44)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Page3();
                    },
                  ),
                );
              },
              child: const Text(
                "Currency Converter",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )

            //[DropdownButton(items: items, onChanged: onChanged)],
          ],
        ),
      ),
      /*
      Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          shape: Border.all(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "Select Currency",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70
                      //backgroundColor: Colors.green,
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const Page2();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    primary: Colors.greenAccent,
                    onPrimary: Colors.black87,
                  ),
                  child: const Text("USD Converter")),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    primary: Colors.greenAccent,
                    onPrimary: Colors.black87),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const Page2();
                  }));
                },
                child: const Text("Euro Converter")),
            //const SizedBox(height: 10),
          ],
        ),
      ),*/
    );
  }
}
/*
class _CenterText extends StatelessWidget {
  final String text;
  const _CenterText(this.text);
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}*/
