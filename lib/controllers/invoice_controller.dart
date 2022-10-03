import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';

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
  RxInt selectedPageIndex = 0.obs;

  // Controllers
  late TextEditingController dueDateCtrl;
  late TextEditingController noOfProductsCtrl;
  late TextEditingController invoiceNoCtrl;
  late TextEditingController invoiceDateCtrl;
  late TextEditingController customerAddCtrl;
  late TextEditingController customerNameCtrl;
  late TextEditingController paymentTermsCtrl;
  List<List<TextEditingController>> controllers = List.generate(30, (index) => []);

  // Page Controller
  late PageController pageController;

  // Animation Controller
  late final AnimationController animationController;

  // Form Keys
  final pdfFormKey = GlobalKey<FormState>();


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

  // Function to handle previous page view navigations
  previousPage(){
    if (selectedPageIndex.value == 1) {
      processIndex.value = (processIndex.value - 1) % processes.length;
      pageController.previousPage(duration: 200.milliseconds, curve: Curves.ease);
    }
    else if (selectedPageIndex.value == 2) {
      
    }
    else if (isLastPage) {
      
    }
  }

  // Function to handle forward page view navigations
  forward(){

    // Customer info page
    if (selectedPageIndex.value == 0){
      if (invoiceNoCtrl.text != '' && customerNameCtrl.text != '' && customerAddCtrl.text != '' && noOfProductsCtrl.text != '') {
        listLength.value = int.parse(noOfProductsCtrl.text);
        for (int i = 0; i < listLength.value; i++) {
          for (int j = 0; j < 3; j++) {
            controllers[i].add(TextEditingController());
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
        processIndex.value = (processIndex.value + 1) % processes.length;
        pageController.nextPage(duration: 200.milliseconds, curve: Curves.ease);
      }
    }

    // Payment page
    else if(selectedPageIndex.value == 2){
    }

    // Invoice summary page
    else if (isLastPage){
    }
  
  }

  
}