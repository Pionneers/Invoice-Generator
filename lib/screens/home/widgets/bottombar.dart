import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../constants/controllers.dart';

class MainBottomBar extends StatelessWidget {
  const MainBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => 
      BottomNavigationBar(
        elevation: 0.0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: const Color.fromRGBO(239, 91, 91, 1),
        backgroundColor: Colors.white,
        unselectedItemColor: const Color.fromRGBO(239, 91, 91, 0.5),
        unselectedLabelStyle: const TextStyle(color: Colors.red),
        currentIndex: homepageController.currentIndex.value,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.fact_check_outlined),
            label: "Home"
          ),

          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.receipt_outlined),
            label: "Invoice"
          ),
        ],
        onTap: (index) => homepageController.currentIndex.value = index,
      ),
    );
  }
}