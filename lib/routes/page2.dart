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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black45,
        title: const Text("Unit Converter"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(10.0),
        decoration: ShapeDecoration(
            shape: Border.all(color: Colors.white, style: BorderStyle.solid),
            color: Colors.black),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*const SizedBox(
              width: 20,
              height: 100,
            ),*/
            GestureDetector(
              onTap: () => {},
              child: const Text(
                "cm",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
