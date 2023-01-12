import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medory/routes/otpscreen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          const SizedBox(height: 51),
          Center(
            child: Image.asset(
              'assets/images/medory_logo.png',
            ),
          ),
          const SizedBox(
            height: 43,
          ),
          const Text(
            textAlign: TextAlign.start,
            "Crea il tuo account Medory",
            style: TextStyle(
              color: Color(0xFF2B1E67),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.18,
              height: 24 / 20,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          AccountScreenWidget(
              title: "Raccogli i tuoi dati sanitari in un solo luogo"),
          AccountScreenWidget(
              title: "Condividi i tuoi dati con gli specialisti"),
          AccountScreenWidget(title: "Monitora il tuo stato di salute"),
          const SizedBox(
            height: 24,
          ),
          const SizedBox(
              height: 56,
              width: 335,
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(0, 0, 0, 0.05),
                  labelStyle: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.15,
                      height: 24 / 14),
                  hoverColor: Color(0xFF684EF4),
                  labelText: 'Numero di telefono',
                ),
              )),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            height: 40,
            width: 335,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF684EF4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const OtpScreen();
                  }));
                },
                child: const Text(
                  "CREA ACCOUNT",
                  style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    height: 16 / 14,
                  ),
                )),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Hai già un account?",
                style: TextStyle(
                    color: Color(0xFF555874),
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.18,
                    height: 24 / 14),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "ACCEDI",
                style: TextStyle(
                    color: Color(0xFF684EF4),
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 24 / 14,
                    letterSpacing: 0.75),
              )
            ],
          )
        ]),
      ),
    );
  }
}

class AccountScreenWidget extends StatelessWidget {
  String title;
  AccountScreenWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF555874),
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF555874),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                  height: 24 / 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }
}
