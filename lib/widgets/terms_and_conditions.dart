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
        padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 18.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: Color(0xFF2B1E67))),
              for (int i = 0; i < termAndConditionItems.length; i++)
                _TermsAndConditionListItemWidget(
                  termsAndConditionListItem: termAndConditionItems[i],
                )
            ],
          ),
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
            Icon(
              termsAndConditionListItem.icon,
              color: const Color.fromRGBO(43, 30, 103, 0.87),
            ),
            const SizedBox(
              width: 19.33,
            ),
            Expanded(
              child: Text(
                termsAndConditionListItem.message,
                style: const TextStyle(
                  letterSpacing: 0.5,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(43, 30, 103, 0.87),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
