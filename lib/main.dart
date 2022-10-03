import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';

import '/screens/home/homepage.dart';
import 'controllers/homepage_controller.dart';
import 'controllers/invoice_controller.dart';

void main() {
  Get.put<HomepageController>(HomepageController());
  Get.put<InvoiceController>(InvoiceController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invoice Generator',
      home: Homepage(),
    );
  }
}
