import 'package:flutter/material.dart';

class PageTitleWidget extends StatelessWidget {
  final String title; 

  const PageTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Roboto',
          letterSpacing: 1.2,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        )
      ),
    );
  }
}