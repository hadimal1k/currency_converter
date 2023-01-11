// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionListItem {
  final IconData icon;
  final String message;
  final CrossAxisAlignment crossAxisAlignment;

  TermsAndConditionListItem({
    required this.icon,
    required this.message,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });
}

void loadData() {
  //TermsAndConditionListItem(icon: icon, message: message)
}

class TermsAndConditions extends StatelessWidget {
  final String title;
  final List<TermsAndConditionListItem> termAndConditionItems;

  const TermsAndConditions({
    Key? key,
    required this.title,
    required this.termAndConditionItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(title,
                style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1)),
            for (int i = 0; i < termAndConditionItems.length; i++)
              _TermsAndConditionListItemWidget(
                termsAndConditionListItem: termAndConditionItems[i],
              )
          ],
        ),
      ),
    );
  }
}

class _TermsAndConditionListItemWidget extends StatelessWidget {
  final TermsAndConditionListItem termsAndConditionListItem;

  const _TermsAndConditionListItemWidget(
      {super.key, required this.termsAndConditionListItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: termsAndConditionListItem.crossAxisAlignment,
          children: [
            Icon(termsAndConditionListItem.icon),
            const SizedBox(
              width: 19.33,
            ),
            Expanded(
              child: Text(
                termsAndConditionListItem.message,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
