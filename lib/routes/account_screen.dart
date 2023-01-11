import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE5E5E5),
      child: Column(children: [
        const SizedBox(height: 51),
        Image.asset('assets/images/medory_logo.png'),
        Text(
          "Crea il tuo account Medory",
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ]),
    );
  }
}

class AccountScreenWidget extends StatelessWidget {
  const AccountScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("THis is Text Widget"),
      ],
    );
  }
}
