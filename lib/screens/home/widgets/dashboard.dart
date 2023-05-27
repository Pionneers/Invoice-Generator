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
            DetailsWidget()
          ],
        ),
      )
    );
  }
}

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height / 2;

    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Amount: ")
        ],
      ),
    );
  }
}