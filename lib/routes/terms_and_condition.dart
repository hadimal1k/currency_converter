import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medory/widgets/terms_and_conditions.dart';

class TermsAndConditionRoute extends StatelessWidget {
  const TermsAndConditionRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 51),
            Image.asset("", height: 34),
            TermsAndConditions(
              title: "title",
              termAndConditionItems: [
                TermsAndConditionListItem(icon: Icons.abc, message: "This is item 1"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
