import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:invoicegenerator/constants/controllers.dart';

class SummaryInfo extends StatelessWidget {
  const SummaryInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return Obx(() => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: const Text("Invoice No: ", style: TextStyle(color: Colors.black87)),
                ),
                Text(invoiceController.invoiceNoCtrl.text, style: const TextStyle(color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: const Text("Invoice Date: ", style: TextStyle(color: Colors.black87)),
                ),
                Text(invoiceController.invoiceDateCtrl.text, style: const TextStyle(color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: const Text("Customer name: ", style: TextStyle(color: Colors.black87)),
                ),
                Expanded(
                  child: Text(
                    invoiceController.customerNameCtrl.text, 
                    textAlign: TextAlign.right,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      color: Colors.black87
                    )
                  )
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: const Text("Customer address: ", style: TextStyle(color: Colors.black87)),
                ),
                Expanded(
                  child: Text(
                    invoiceController.customerAddCtrl.text, 
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.black87
                    ), 
                    overflow: TextOverflow.clip,
                    softWrap: true,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: const Text("Due date: ", style: TextStyle(color: Colors.black87)),
                ),
                Text(invoiceController.dueDateCtrl.text, style: const TextStyle(color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: const Text("Total products: ", style: TextStyle(color: Colors.black87)),
                ),
                Text(invoiceController.totalQuantity.toString(), style: const TextStyle(color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: const Text("Total amount: ", style: TextStyle(color: Colors.black87)),
                ),
                Text("RM ${invoiceController.totalAmount.value.toStringAsFixed(2)}", style: const TextStyle(color: Colors.black87)),
              ],
            ),
            invoiceController.paymentTypeFull.value ? 
            const SizedBox.shrink()
            :
            Column(
              children: [
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width,
                      alignment: Alignment.centerLeft,
                      child: const Text("Pending payment: ", style: TextStyle(color: Colors.black87)),
                    ),
                    Text("RM ${invoiceController.balPaymentCtrl.text}", style: const TextStyle(color: Colors.black87)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: const Text("Payment Terms: ", style: TextStyle(color: Colors.black87)),
                ),
                Expanded(
                  child: Text(
                    invoiceController.paymentTermsCtrl.text, 
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.black87),
                    overflow: TextOverflow.clip,
                    softWrap: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Products", 
                textAlign: TextAlign.left, 
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
              )
            ),
            const SizedBox(height: 10.0),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: invoiceController.listLength.value,
              separatorBuilder: (_, __) => const SizedBox(height: 5.0),
              itemBuilder: (context, index){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width,
                      alignment: Alignment.centerLeft,
                      child: Text(invoiceController.controllers[index][0].value.text, style: const TextStyle(color: Colors.black87)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("RM ${invoiceController.controllers[index][1].value.text}", style: const TextStyle(color: Colors.black87)),
                    ),
                    Text(invoiceController.controllers[index][2].value.text, style: const TextStyle(color: Colors.black87)),
                  ],
                );
              },
            ),
            const SizedBox(height: 30.0),
            Container(
              width: 450,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0)
              ),
              clipBehavior: Clip.antiAlias,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow[800],
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                onPressed: () => invoiceController.forward(),
                child: const Text("Generate Invoice"),
              ),
            ),
            const SizedBox(height: 80.0),
          ],
        ),
      ),
    ),);
  }
}