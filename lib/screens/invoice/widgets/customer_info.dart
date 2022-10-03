import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../constants/controllers.dart';
import '../../../widgets/title.dart';
import 'textfield.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const PageTitleWidget(title: 'Enter details to generate new invoice'),
            const SizedBox(height: 30.0),
            InvoiceField(
              hintText: "Invoice number", 
              labelText: "Invoice number", 
              helperText: "Enter invoice number",
              icon: const Icon(Icons.numbers_outlined),
              controller: invoiceController.invoiceNoCtrl,
            ),
            const SizedBox(height: 30.0),
            InvoiceField(
              hintText: "Customer name", 
              labelText: "Customer name", 
              helperText: "Enter customer's name",
              icon: const Icon(Icons.person_outline),
              controller: invoiceController.customerNameCtrl,
            ),
            const SizedBox(height: 30.0),
            InvoiceField(
              hintText: "Customer address", 
              labelText: "Customer address", 
              helperText: "Enter customer's address",
              icon: const Icon(Icons.home_outlined),
              controller: invoiceController.customerAddCtrl,
            ),
            const SizedBox(height: 20.0),
            InvoiceField(
              hintText: "Number of products", 
              labelText: "Number of products", 
              helperText: "Enter number of products",
              icon: const Icon(Icons.numbers),
              controller: invoiceController.noOfProductsCtrl,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}