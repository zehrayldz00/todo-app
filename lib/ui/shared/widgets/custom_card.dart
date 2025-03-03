import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.cardColor});

  final String? title;
  final String? subtitle;

  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      elevation: 20,
      child: ListTile(
        //leading: Checkbox(value: aue, onChanged:),
        title: Text(
          title!,
          style: titleStyle,
        ),
        subtitle: Text(
          subtitle!,
          style: detailStyle,
        ),
      ),
    );
  }
}
