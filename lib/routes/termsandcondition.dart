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
      backgroundColor: const Color(0xFFE5E5E5),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                  height: 26 / 20,
                ),
              ),
              const SizedBox(height: 19.33),
              Column(
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
                    title: "Condividiamo i tuoi dati?",
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
                    title: "Come saranno gestiti i tuoi dati?",
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
                  Text(
                    "Ho letto l’informativa privacy",
                    style: GoogleFonts.dmSans(
                        fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ]),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Proseguendo, dichiaro di aver letto e accettato i Termini e condizioni",
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 18,
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
                    child: Text(
                      "AVANTI",
                      style: GoogleFonts.dmSans(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
