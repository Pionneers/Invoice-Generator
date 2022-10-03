import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';

import '../screens/home/widgets/dashboard.dart';
import '../screens/invoice/invoice.dart';

class HomepageController extends GetxController {
  static HomepageController instance = Get.find();

  // Variables Declaration
  final tabs = [
    const Dashboard(),
    const Invoice()
  ];

  // Observable Variables
  RxInt currentIndex = 0.obs;
}