import 'package:flutter/material.dart';
import 'package:invoicegenerator/constants/controllers.dart';

import '../../services/convert_to_pdf.dart';
import '../../services/pdf_api.dart';
import '../../widgets/title.dart';
import 'widgets/textfield.dart';

class Invoice extends StatelessWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
        child: Form(
          key: invoiceController.pdfFormKey,
          child: Column(
            children: [
              const PageTitleWidget(title: 'Enter details to generate new invoice'),
              const SizedBox(height: 30.0),
              InvoiceField(
                hintText: "Customer name", 
                labelText: "Customer name", 
                helperText: "Enter customer's name",
                icon: const  Icon(Icons.person_outline),
                controller: invoiceController.customerNameCtrl,
              ),
              const SizedBox(height: 30.0),
              InvoiceField(
                hintText: "Customer address", 
                labelText: "Customer address", 
                helperText: "Enter customer's address",
                icon: const  Icon(Icons.home_outlined),
                controller: invoiceController.customerAddCtrl,
              ),
              const SizedBox(height: 20.0),
              InvoiceField(
                hintText: "Invoice number", 
                labelText: "Invoice number", 
                helperText: "Enter invoice number",
                icon: const  Icon(Icons.numbers_outlined),
                controller: invoiceController.invoiceNoCtrl,
              ),
              const SizedBox(height: 20.0),
              InvoiceField(
                hintText: "Invoice date", 
                labelText: "Invoice date", 
                helperText: "Enter invoice date",
                icon: const  Icon(Icons.date_range),
                controller: invoiceController.invoiceDateCtrl,
              ),
              const SizedBox(height: 20.0),
              InvoiceField(
                hintText: "Due date", 
                labelText: "Due date", 
                helperText: "Enter due date",
                icon: const  Icon(Icons.date_range_rounded),
                controller: invoiceController.dueDateCtrl,
              ),
              const SizedBox(height: 30.0),
              InvoiceField(
                hintText: "Payment terms", 
                labelText: "Payment terms", 
                helperText: "Enter payment terms",
                icon: const  Icon(Icons.payment_outlined),
                controller: invoiceController.paymentTermsCtrl,
              ),
              const SizedBox(height: 20.0),
              Container(
                width: 450,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)
                ),
                clipBehavior: Clip.antiAlias,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange[400],
                  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  onPressed: () async {
                    // if (invoiceController.pdfFormKey.currentState!.validate()) {
                    //   invoiceController.pdfFormKey.currentState!.save();
                    //   final pdfFile = await TransferPdfInvoiceApi.generate(
                    //     cusName: invoiceController.customerNameCtrl.text,
                    //     cusAddress: invoiceController.customerAddCtrl.text.toUpperCase(),
                    //     invoiceNo: invoiceController.invoiceNoCtrl.text,
                    //     invoiceDate: invoiceController.invoiceDateCtrl.text,
                    //     dueDate: invoiceController.dueDateCtrl.text,
                    //     paymentTerms: invoiceController.paymentTermsCtrl.text,
                    //   );
                    //   PdfApi.openFile(pdfFile);
                    // }
                  }, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.picture_as_pdf_outlined),
                      SizedBox(width: 10.0),
                      Text("Generate Invoice"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

