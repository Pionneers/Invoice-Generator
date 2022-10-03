import 'package:flutter/material.dart';

import '../../../widgets/title.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: const [
            PageTitleWidget(title: "Welcome to Pionneers Invoice Generator"),
            SizedBox(height: 30.0),
          ],
        ),
      )
    );
  }
}