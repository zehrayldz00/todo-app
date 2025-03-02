import 'package:flutter/material.dart';
import 'package:todo_application/ui/shared/styles/colors.dart';

import '../styles/text_styles.dart';


class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.title, required this.subtitle});

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: nightNavy,
      elevation: 20,
      child: ListTile(
        title: Text(title!, style: titleStyle,),
        subtitle: Text(subtitle!, style: detailStyle,),
      ),
    );
  }
}
