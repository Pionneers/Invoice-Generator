import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';

import '../constants/timeline.dart';

class InvoiceController extends GetxController with GetSingleTickerProviderStateMixin{
  static InvoiceController instance = Get.find();

  // Variables Initialization and Declaration
  final processes = [
    'Customer',
    'Products',
    'Payment',
    'Summary',
  ];
  RxBool paymentTypeFull = true.obs;
  bool get isLastPage => selectedPageIndex.value == processes.length - 1;

  // Observable Variables
  RxInt listLength = 0.obs;
  RxInt processIndex = 0.obs;
  RxInt totalQuantity = 0.obs;
  RxDouble totalAmount = 0.00.obs;
  RxInt selectedPageIndex = 0.obs;

  // Controllers
  late TextEditingController dueDateCtrl;
  late TextEditingController noOfProductsCtrl;
  late TextEditingController invoiceNoCtrl;
  late TextEditingController invoiceDateCtrl;
  late TextEditingController customerAddCtrl;
  late TextEditingController customerNameCtrl;
  late TextEditingController paymentTermsCtrl;
  late TextEditingController balPaymentCtrl;
  List<List<TextEditingController>> controllers = [];

  // Page Controller
  late PageController pageController;

  // Animation Controller
  late final AnimationController animationController;

  // Form Keys
  final pdfFormKey = GlobalKey<FormState>();
  final balPaymentFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    initializeVariables();
    super.onInit();
  }

  @override
  void onClose() {
    noOfProductsCtrl.dispose();
    dueDateCtrl.dispose();
    invoiceNoCtrl.dispose();
    pageController.dispose();
    invoiceDateCtrl.dispose();
    customerAddCtrl.dispose();
    customerNameCtrl.dispose();
    paymentTermsCtrl.dispose();
    balPaymentCtrl.dispose();
    // controllers.forEach((element) => element.dispose());
    super.onClose();
  }

  void initializeVariables(){
    try {
      pageController = PageController();
      animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
      noOfProductsCtrl = TextEditingController();
      dueDateCtrl = TextEditingController();
      invoiceNoCtrl = TextEditingController();
      invoiceDateCtrl = TextEditingController();
      customerAddCtrl = TextEditingController();
      customerNameCtrl = TextEditingController();
      paymentTermsCtrl = TextEditingController();
      balPaymentCtrl = TextEditingController();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Returns different colors based on timeline progress
  Color getColor(int index) {
    if (index == processIndex.value) {
      return inProgressColor;
    } else if (index < processIndex.value) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  void showIOSDatePicker(bool invoiceDate) {
    invoiceDate ? invoiceDateCtrl.text = DateFormat('yyyy-MM-dd').format(DateTime.now()) : dueDateCtrl.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (_) => Container(
        height: 190,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                dateOrder: DatePickerDateOrder.dmy,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: invoiceDate ? DateTime.parse(invoiceDateCtrl.text) : DateTime.parse(dueDateCtrl.text),
                onDateTimeChanged: (val) {
                  invoiceDate ? invoiceDateCtrl.text = DateFormat('yyyy-MM-dd').format(val) : dueDateCtrl.text = DateFormat('yyyy-MM-dd').format(val);
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  // Function to handle previous page view navigations
  previousPage(){
    if (selectedPageIndex.value == 1) {
      processIndex.value = (processIndex.value - 1) % processes.length;
      pageController.previousPage(duration: 200.milliseconds, curve: Curves.ease);
      pdfFormKey.currentState!.reset();
      controllers.clear();
    }
    else if (selectedPageIndex.value == 2) {
      totalAmount.value = 0.00;
      totalQuantity.value = 0;
      processIndex.value = (processIndex.value - 1) % processes.length;
      pageController.previousPage(duration: 200.milliseconds, curve: Curves.ease);
    }
    else if (isLastPage) {
      processIndex.value = (processIndex.value - 1) % processes.length;
      pageController.previousPage(duration: 200.milliseconds, curve: Curves.ease);
    }
  }

  // Function to handle forward page view navigations
  forward(){

    // Customer info page
    if (selectedPageIndex.value == 0){
      if (invoiceNoCtrl.text != '' && customerNameCtrl.text != '' && customerAddCtrl.text != '' && noOfProductsCtrl.text != '') {
        listLength.value = int.parse(noOfProductsCtrl.value.text);
        for (int i = 0; i < listLength.value; i++) {
          controllers.add([]);
          if (controllers[i].isEmpty) {
            for (int j = 0; j < 3; j++) {
              controllers[i].add(TextEditingController());
            }
          }
        }
        processIndex.value = (processIndex.value + 1) % processes.length;
        pageController.nextPage(duration: 200.milliseconds, curve: Curves.ease);
      } else {
        Get.snackbar("Error", "Please fill in all fields");
      }
    }

    // Products page
    else if(selectedPageIndex.value == 1){
      if(pdfFormKey.currentState!.validate()){
        for (int i = 0; i < controllers.length; i++) {
          if (controllers[i].isNotEmpty) {
            if (!controllers[i][1].value.text.toString().contains('.')) {
              double unitPrice = int.parse(controllers[i][1].value.text).toDouble();
              int quantity = int.parse(controllers[i][2].value.text);
              totalAmount.value += (unitPrice * quantity);
              totalQuantity.value += quantity;
            }
            else {
              double unitPrice = double.parse(controllers[i][1].value.text);
              int quantity = int.parse(controllers[i][2].value.text);
              totalAmount.value += (unitPrice * quantity);
              totalQuantity.value += quantity;
            }
          }
        }
        processIndex.value = (processIndex.value + 1) % processes.length;
        pageController.nextPage(duration: 200.milliseconds, curve: Curves.ease);
      }
    }

    // Payment page
    else if(selectedPageIndex.value == 2){
      if (!paymentTypeFull.value) {
        if (!balPaymentCtrl.text.contains('.')) {
          balPaymentCtrl.text = int.parse(balPaymentCtrl.text).toStringAsFixed(2);
        }
      }
      processIndex.value = (processIndex.value + 1) % processes.length;
      pageController.nextPage(duration: 200.milliseconds, curve: Curves.ease);
    }

    // Invoice summary page
    else if (isLastPage){
      // invoiceDateCtrl.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(invoiceDateCtrl.text));
      // dueDateCtrl.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(dueDateCtrl.text));
      // final pdfFile = await TransferPdfInvoiceApi.generate(
      //   log,
      //   customerAddCtrl.text.toUpperCase(),
      //   invoiceNoCtrl.text,
      //   paymentTermsCtrl.text,
      //   dueDateCtrl.text,
      // );
      // PdfApi.openFile(pdfFile);
    }
  }

}