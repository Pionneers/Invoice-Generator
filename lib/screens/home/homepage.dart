import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constants/controllers.dart';
import 'widgets/appbar.dart';
import 'widgets/bottombar.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppbar(),
      body: Obx(() => homepageController.tabs[homepageController.currentIndex.value]),
      bottomNavigationBar: const MainBottomBar(),
    );
  }
}

