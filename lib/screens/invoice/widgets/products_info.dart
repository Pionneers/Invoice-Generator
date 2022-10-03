import 'package:flutter/material.dart';

import 'list_widget.dart';

class ProductsInfo extends StatelessWidget {
  const ProductsInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          ProductsInfoListWidget(),
          SizedBox(height: 70.0),
        ],
      ),
    );
  }
}