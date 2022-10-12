import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../constants/controllers.dart';
import 'textfield.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return Obx(() => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: const Text("Total products: ", style: TextStyle(color: Colors.black87)),
                ),
                Text(invoiceController.totalQuantity.value.toString(), style: const TextStyle(color: Colors.black87)),
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
            const SizedBox(height: 35.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                onTap: () => invoiceController.showIOSDatePicker(false),
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: "Due date", 
                  labelText: "Due date", 
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                  helperText: "Enter due date",
                  prefixIcon: Icon(Icons.date_range_rounded),
                ),
                keyboardType: TextInputType.datetime,
                controller: invoiceController.dueDateCtrl,
                style: TextStyle(color: Colors.grey[850]),
                validator: (value) => value!.isEmpty ? "Enter due date" : null,
                toolbarOptions: const ToolbarOptions(copy: true, paste: true, cut: true, selectAll: true),
              ),
            ),
            const SizedBox(height: 35.0),
            InvoiceField(
              hintText: "Payment terms", 
              labelText: "Payment terms", 
              helperText: "Enter payment terms",
              icon: const  Icon(Icons.payment_outlined),
              controller: invoiceController.paymentTermsCtrl,
            ),
            const SizedBox(height: 35.0),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Select payment type", 
                textAlign: TextAlign.left, 
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
              )
            ),
            const SizedBox(height: 10.0),
            Column(
              children: [
                CheckboxListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  value: invoiceController.paymentTypeFull.value, 
                  controlAffinity: ListTileControlAffinity.leading,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  title: const Text("Full Payment", style: TextStyle(color: Colors.black87)),
                  checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onChanged: (value) => invoiceController.paymentTypeFull.value = !(invoiceController.paymentTypeFull.value),
                ),
                CheckboxListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  value: !invoiceController.paymentTypeFull.value, 
                  controlAffinity: ListTileControlAffinity.leading,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  title: const Text("Partial Payment", style: TextStyle(color: Colors.black87)),
                  subtitle: const Text("Enter balance amount to be paid", style: TextStyle(color: Colors.black87, fontSize: 11)),
                  checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onChanged: (value) => invoiceController.paymentTypeFull.value = !(invoiceController.paymentTypeFull.value),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            invoiceController.paymentTypeFull.value ?
            const SizedBox.shrink()
            :
            Form(
              key: invoiceController.balPaymentFormKey,
              child: SizedBox(
                width: width * 2,
                child: TextFormField(
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: "Balance",
                    labelText: "Balance",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    helperText: "Enter balance payment",
                    prefixIcon: Icon(Icons.pending_outlined),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(color: Colors.grey[850]),
                  validator: (value) => value!.isEmpty ? "Enter balance payment" : null,
                  controller: invoiceController.balPaymentCtrl,
                  toolbarOptions: const ToolbarOptions(copy: true, paste: true, cut: true, selectAll: true),
                ),
              ),
            ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    ),);
  }
}