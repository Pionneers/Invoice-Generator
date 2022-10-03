import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constants/controllers.dart';
import '../../constants/timeline.dart';
import '../../widgets/title.dart';
import 'widgets/timeline.dart';
import 'widgets/timeline_pageview.dart';

class Invoice extends StatelessWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: PageTitleWidget(title: 'Generate new invoice'),
              ),
              SizedBox(height: 20.0),
              InvoiceTimeline(),
              SizedBox(height: 20.0),
              TimelinePageViewWidget(),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 20,
            child: Row(
              children: List.generate(
                invoiceController.processes.length, 
                (index) => Obx(() => Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: invoiceController.selectedPageIndex.value == index ? inProgressColor : todoColor,
                    shape: BoxShape.circle
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          invoiceController.selectedPageIndex.value == 0 ?
          const SizedBox.shrink()
          :
          FloatingActionButton(
            heroTag: null,
            onPressed: () => invoiceController.previousPage(),
            backgroundColor: completeColor,
            child: const Icon(FontAwesomeIcons.chevronLeft),
          ),
          const SizedBox(width: 10.0),
          invoiceController.isLastPage ?
          const SizedBox.shrink()
          :
          Row(
            children: [
              const SizedBox(width: 10.0),
              FloatingActionButton(
                heroTag: null,
                onPressed: () => invoiceController.forward(),
                backgroundColor: inProgressColor,
                child: const Icon(FontAwesomeIcons.chevronRight),
              ),
            ],
          ),
        ],
      ),),


      
      // body: SingleChildScrollView(
      //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
      //   child: Form(
      //     key: invoiceController.pdfFormKey,
      //     child: Column(
      //       children: [
      //         const PageTitleWidget(title: 'Enter details to generate new invoice'),
      //         const SizedBox(height: 30.0),
      //         InvoiceField(
      //           hintText: "Customer name", 
      //           labelText: "Customer name", 
      //           helperText: "Enter customer's name",
      //           icon: const  Icon(Icons.person_outline),
      //           controller: invoiceController.customerNameCtrl,
      //         ),
      //         const SizedBox(height: 30.0),
      //         InvoiceField(
      //           hintText: "Customer address", 
      //           labelText: "Customer address", 
      //           helperText: "Enter customer's address",
      //           icon: const  Icon(Icons.home_outlined),
      //           controller: invoiceController.customerAddCtrl,
      //         ),
      //         const SizedBox(height: 20.0),
      //         InvoiceField(
      //           hintText: "Invoice number", 
      //           labelText: "Invoice number", 
      //           helperText: "Enter invoice number",
      //           icon: const  Icon(Icons.numbers_outlined),
      //           controller: invoiceController.invoiceNoCtrl,
      //         ),
      //         const SizedBox(height: 20.0),
      //         InvoiceField(
      //           hintText: "Invoice date", 
      //           labelText: "Invoice date", 
      //           helperText: "Enter invoice date",
      //           icon: const  Icon(Icons.date_range),
      //           controller: invoiceController.invoiceDateCtrl,
      //         ),
      //         const SizedBox(height: 20.0),
      //         InvoiceField(
      //           hintText: "Due date", 
      //           labelText: "Due date", 
      //           helperText: "Enter due date",
      //           icon: const  Icon(Icons.date_range_rounded),
      //           controller: invoiceController.dueDateCtrl,
      //         ),
      //         const SizedBox(height: 30.0),
      //         InvoiceField(
      //           hintText: "Payment terms", 
      //           labelText: "Payment terms", 
      //           helperText: "Enter payment terms",
      //           icon: const  Icon(Icons.payment_outlined),
      //           controller: invoiceController.paymentTermsCtrl,
      //         ),
      //         const SizedBox(height: 20.0),
      //         Container(
      //           width: 450,
      //           height: 50.0,
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(8.0)
      //           ),
      //           clipBehavior: Clip.antiAlias,
      //           child: ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               primary: Colors.orange[400],
      //             ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      //             onPressed: () async {
      //               // if (invoiceController.pdfFormKey.currentState!.validate()) {
      //               //   invoiceController.pdfFormKey.currentState!.save();
      //               //   final pdfFile = await TransferPdfInvoiceApi.generate(
      //               //     cusName: invoiceController.customerNameCtrl.text,
      //               //     cusAddress: invoiceController.customerAddCtrl.text.toUpperCase(),
      //               //     invoiceNo: invoiceController.invoiceNoCtrl.text,
      //               //     invoiceDate: invoiceController.invoiceDateCtrl.text,
      //               //     dueDate: invoiceController.dueDateCtrl.text,
      //               //     paymentTerms: invoiceController.paymentTermsCtrl.text,
      //               //   );
      //               //   PdfApi.openFile(pdfFile);
      //               // }
      //             }, 
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: const [
      //                 Icon(Icons.picture_as_pdf_outlined),
      //                 SizedBox(width: 10.0),
      //                 Text("Generate Invoice"),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

