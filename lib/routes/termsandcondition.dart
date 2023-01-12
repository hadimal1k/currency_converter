import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medory/routes/account_screen.dart';
import 'package:medory/widgets/terms_and_conditions.dart';

class TermsAndConditionRoute extends StatelessWidget {
  const TermsAndConditionRoute({super.key});

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 51),
            Image.asset("assets/images/medory_logo.png"),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "La tua privacy è importante per noi",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.18,
                  height: 26.04 / 20,
                  color: Color(0xFF2B1E67)),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TermsAndConditions(
                      title: "QUALI DATI RACCOGLIAMO?",
                      termAndConditionItems: [
                        TermsAndConditionListItem(
                          icon: Icons.person,
                          message:
                              "Medory raccoglie il tuo nome, cognome, data di nascita, indirizzo, numero di telefono, email e codice fiscale.",
                        ),
                        TermsAndConditionListItem(
                          icon: Icons.health_and_safety,
                          message:
                              "Medory salva i tuoi dati sanitari come gruppo sanguigno, vaccinazioni, malattie, allergie, dipendenze, altezza, peso, terapie, esami, referti, vedi tutti",
                        ),
                      ],
                    ),
                    TermsAndConditions(
                      title: "CONDIVIDIAMO I TUOI DATI?",
                      termAndConditionItems: [
                        TermsAndConditionListItem(
                          icon: Icons.open_in_browser,
                          message:
                              "I tuoi dati verranno resi anonimi e aggregati in dataset per essere condivisi per aiutare la ricerca medica.",
                        ),
                        TermsAndConditionListItem(
                          icon: Icons.block,
                          message:
                              "I tuoi dati non verranno usati per mostrarti pubblicità e fare profilazione.",
                        ),
                      ],
                    ),
                    TermsAndConditions(
                      title: "COME SARANNO GESTITI I TUOI DATI?",
                      termAndConditionItems: [
                        TermsAndConditionListItem(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          icon: Icons.flag,
                          message:
                              "I tuoi dati saranno salvati su server in Europa.",
                        ),
                        TermsAndConditionListItem(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          icon: Icons.delete,
                          message:
                              "Potrai richiedere la cancellazione dei tuoi dati saranno eliminati una volta rimosso il proprio account.",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Card(
                      child: Row(children: [
                        StatefulBuilder(builder: (context, setState) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                              child: Icon(
                                isChecked == true
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                              ));
                        }),
                        const SizedBox(
                          width: 19.33,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            // textAlign: TextAlign.center,
                            "Ho letto l’informativa privacy",
                            style: TextStyle(
                                letterSpacing: 0.1,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 24 / 14,
                                color: Color(0xFF2B1E67)),
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      children: const [
                        Text(
                          textAlign: TextAlign.center,
                          "Proseguendo, dichiaro di aver letto e accettato i",
                          style: TextStyle(
                              height: 18 / 12,
                              fontFamily: "DMSans",
                              letterSpacing: 0.5,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(43, 30, 103, 0.60)),
                        ),
                        Text(
                          " Termini e condizioni",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 18 / 12,
                              fontFamily: "DMSans",
                              letterSpacing: 0.5,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(43, 30, 103, 0.87)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 335,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF684EF4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const AccountScreen();
                    }));
                  },
                  child: const Text(
                    "AVANTI",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
