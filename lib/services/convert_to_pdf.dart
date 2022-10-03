// import 'dart:io';

// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
// import 'package:pdf/widgets.dart' as pw;

// import 'pdf_api.dart';

// class TransferPdfInvoiceApi {

//   // Main Function
//   static Future<File> generate({
//     required String cusName,
//     required String cusAddress,
//     required String invoiceNo, 
//     required String invoiceDate, 
//     required String dueDate, 
//     required String paymentTerms, 
//   }) async {
//     final pdf = Document();
//     double totalAmount = double.parse(log.get('totalAmount'));
//     double pendingPayment = log.get('isPending') ? double.parse(log.get('pendingPayment')): 0.00;
//     double paid = totalAmount - pendingPayment;
//     double unitPrice = double.parse(log.get('totalAmount')) / log.get('totalProducts');
//     ImageProvider image = MemoryImage((await rootBundle.load('assets/pictures/Pionneers_Logo.png')).buffer.asUint8List());
//     pdf.addPage(MultiPage(
//       build: (context) => [
//         buildHeader(cusName, cusAddress, invoiceNo, paymentTerms, invoiceDate, dueDate, image),
//         SizedBox(height: 1 * PdfPageFormat.cm),
//         buildTitle(),
//         buildInvoice(log.get('products'), invoiceDate, unitPrice),
//         Divider(),
//         buildTotal(totalAmount, pendingPayment, paid, log.get('isPending')),
//       ],
//       footer: (context) => buildFooter(),
//     ));

//     return PdfApi.saveDocument(name: '$cusName-$invoiceDate.pdf', pdf: pdf);
//   }

//   static Widget buildHeader(
//     String cusName,
//     String cusAddress,
//     String invoiceNo, 
//     String paymentTerms,
//     String invoiceDate,
//     String dueDate,
//     ImageProvider image,
//   ) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           buildSupplierAddress(),
//           Container(
//             height: 70,
//             width: 70,
//             child: Image(image, fit: BoxFit.cover),
//           ),
//         ],
//       ),
//       SizedBox(height: 1 * PdfPageFormat.cm),
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           buildCustomerAddress(cusName, cusAddress),
//           buildInvoiceInfo(invoiceNo, invoiceDate, paymentTerms, dueDate),
//         ],
//       ),
//     ],
//   );

//   static Widget buildSupplierAddress() => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text("VR Pionneers Ventures", style: TextStyle(fontWeight: FontWeight.bold)),
//       SizedBox(height: 1 * PdfPageFormat.mm),
//       Text("NO. 5, LORONG POKOK SAKAT,\nOFF JALAN MASTIKA,\n41100 KLANG, SELANGOR"),
//     ],
//   );

//   static Widget buildCustomerAddress(String cusName, String cusAddress) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(cusName, style: TextStyle(fontWeight: FontWeight.bold)),
//       Text(cusAddress.replaceAll(', ', ',\n')),
//     ],
//   );

//   static Widget buildInvoiceInfo(String invoiceNo, String date, String paymentTerms, String dueDate) {
//     final titles = <String>[
//       'Invoice Number:',
//       'Invoice Date:',
//       'Payment Terms:',
//       'Due Date:'
//     ];
//     final data = <String>[
//       invoiceNo,
//       date,
//       paymentTerms,
//       dueDate,
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: List.generate(titles.length, (index) {
//         final title = titles[index];
//         final value = data[index];

//         return buildText(title: title, value: value, width: 200);
//       }),
//     );
//   }

//   static Widget buildTitle() => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         'INVOICE',
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//       SizedBox(height: 0.8 * PdfPageFormat.cm),
//     ],
//   );

//   static Widget buildInvoice(Map<String, dynamic> products, String date, double unitPrice) {
//     List<Product> list = [];
//     final headers = [
//       'Description',
//       'Date',
//       'Quantity',
//       'Unit Price',
//       'Total'
//     ];

//     products.forEach((key, value) => list.add(Product(name: key, amount: value)));
    
//     final data = list.map((item) {
//       double total = unitPrice * item.amount!;
//       return [
//         item.name,
//         date,
//         '${item.amount}',
//         'RM ${unitPrice.toStringAsFixed(2)}',
//         'RM ${total.toStringAsFixed(2)}',
//       ];
//     }).toList();

//     return Table.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: const BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerRight,
//         2: Alignment.centerRight,
//         3: Alignment.centerRight,
//         4: Alignment.centerRight,
//       },
//     );
//   }

//   static Widget buildTotal(double totalAmount, double pendingPayment, double paid, bool isPending) {
//     return Container(
//       alignment: Alignment.centerRight,
//       child: Row(
//         children: [
//           Spacer(flex: 6),
//           Expanded(
//             flex: 4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 isPending ?
//                 buildText(
//                   title: 'Total paid',
//                   value: "RM ${paid.toStringAsFixed(2)}",
//                   unite: true,
//                 )
//                 :
//                 buildText(
//                   title: 'Net total',
//                   value: "RM ${totalAmount.toStringAsFixed(2)}",
//                   unite: true,
//                 ),
//                 buildText(
//                   title: 'Pending payment',
//                   value: "RM ${pendingPayment.toStringAsFixed(2)}",
//                   unite: true,
//                 ),
//                 Divider(),
//                 buildText(
//                   title: 'Total amount due',
//                   titleStyle: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   value: "RM ${totalAmount.toStringAsFixed(2)}",
//                   unite: true,
//                 ),
//                 SizedBox(height: 2 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//                 SizedBox(height: 0.5 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget buildFooter() => Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Divider(),
//       SizedBox(height: 2 * PdfPageFormat.mm),
//       Text("This is a computer generated invoice no signature required"),
//       SizedBox(height: 1 * PdfPageFormat.mm),
//       buildSimpleText(title: 'Bank: ', value: "VR Pionneers Ventures (512455346201 - MAYBANK)"),
//     ],
//   );







//   // Helper functions
//   static buildSimpleText({
//     required String title,
//     required String value,
//   }) {
//     final style = TextStyle(fontWeight: FontWeight.bold);

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         Text(title, style: style),
//         SizedBox(width: 2 * PdfPageFormat.mm),
//         Text(value),
//       ],
//     );
//   }

//   static buildText({
//     required String title,
//     required String value,
//     double width = double.infinity,
//     TextStyle? titleStyle,
//     bool unite = false,
//   }) 
//   {
//     final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);
//     return Container(
//       width: width,
//       child: Row(
//         children: [
//           Expanded(child: Text(title, style: style)),
//           Text(value, style: unite ? style : null),
//         ],
//       ),
//     );
//   }
// }

// class Product {
//   String? name;
//   int? amount;
//   Product({required this.name, required this.amount});
// }