import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';

class InvoiceController extends GetxController{
  static InvoiceController instance = Get.find();

  // Controllers
  late TextEditingController dueDateCtrl;
  late TextEditingController invoiceNoCtrl;
  late TextEditingController invoiceDateCtrl;
  late TextEditingController customerAddCtrl;
  late TextEditingController customerNameCtrl;
  late TextEditingController paymentTermsCtrl;

  // Form Keys
  final pdfFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    dueDateCtrl = TextEditingController();
    invoiceNoCtrl = TextEditingController();
    invoiceDateCtrl = TextEditingController();
    customerAddCtrl = TextEditingController();
    customerNameCtrl = TextEditingController();
    paymentTermsCtrl = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    dueDateCtrl.dispose();
    invoiceNoCtrl.dispose();
    invoiceDateCtrl.dispose();
    customerAddCtrl.dispose();
    customerNameCtrl.dispose();
    paymentTermsCtrl.dispose();
    super.onClose();
  }

  
}