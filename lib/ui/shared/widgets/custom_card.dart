// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_application/ui/shared/styles/colors.dart';

import '../styles/text_styles.dart';

class CustomCard extends StatefulWidget {
  CustomCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.complete,
      required this.cardColor,
      required this.onCheckboxChanged,
      required this.onEditPressed});

  final String? title;
  final String? subtitle;
  late bool complete;
  final Color? cardColor;
  final Function(bool) onCheckboxChanged;
  final VoidCallback onEditPressed;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.cardColor,
      elevation: 20,
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        leading: Checkbox(
            checkColor: widget.cardColor,
            activeColor: white,
            side: BorderSide(color: white),
            value: widget.complete,
            onChanged: (bool? value) {
              setState(() {
                widget.complete = value!;
              });
              widget.onCheckboxChanged(value!);
            }),
        trailing: IconButton(
            onPressed: widget.onEditPressed,
            icon: Icon(
              Icons.edit,
              color: white,
            )),
        title: Text(widget.title!,
            style: titleStyle.copyWith(
                decoration: widget.complete ? TextDecoration.lineThrough : null,
                decorationColor: widget.cardColor)),
        subtitle: Text(
          widget.subtitle!,
          style: detailStyle.copyWith(
              decoration: widget.complete ? TextDecoration.lineThrough : null,
              decorationColor: widget.cardColor),
        ),
      ),
    );
  }
}
