import 'package:flutter/material.dart';

import '../../../constants/controllers.dart';
import 'customer_info.dart';
import 'payment_info.dart';
import 'products_info.dart';
import 'summary_info.dart';

class TimelinePageViewWidget extends StatelessWidget {
  const TimelinePageViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: invoiceController.pageController,
        itemCount: invoiceController.processes.length,
        onPageChanged: invoiceController.selectedPageIndex,
        itemBuilder: (context, index){
          final widgets = <Widget>[
            const CustomerInfo(),
            const ProductsInfo(),
            const PaymentInfo(),
            const SummaryInfo(),
          ];
          return widgets[index];
        }
      ),
    );
  }
}