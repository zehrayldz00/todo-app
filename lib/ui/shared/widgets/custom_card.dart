import 'package:flutter/material.dart';
import 'package:todo_application/ui/shared/styles/colors.dart';

import '../styles/text_styles.dart';

class CustomCard extends StatefulWidget {
  CustomCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.cardColor});

  final String? title;
  final String? subtitle;
  final Color? cardColor;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.cardColor,
      elevation: 20,
      child: ListTile(
        leading: Checkbox(
            checkColor: widget.cardColor,
            activeColor: white,
            side: BorderSide(color: white),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            }),
        title: Text(widget.title!,
            style: titleStyle.copyWith(
                decoration: isChecked ? TextDecoration.lineThrough : null,
                decorationColor: widget.cardColor)),
        subtitle: Text(
          widget.subtitle!,
          style: detailStyle.copyWith(
              decoration: isChecked ? TextDecoration.lineThrough : null,
              decorationColor: widget.cardColor),
        ),
      ),
    );
  }
}
