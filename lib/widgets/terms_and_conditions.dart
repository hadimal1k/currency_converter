// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TermsAndConditionListItem {
  final IconData icon;
  final String message;

  TermsAndConditionListItem({
    required this.icon,
    required this.message,
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
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
    return Row(
      children: [],
    );
  }
}
