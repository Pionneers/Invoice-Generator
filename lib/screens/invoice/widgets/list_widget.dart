import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../constants/controllers.dart';
import '../../../controllers/invoice_controller.dart';
import '../../../widgets/animation_builder.dart';
import 'single_info_list.dart';

class ProductsInfoListWidget extends GetView<InvoiceController> {
  const ProductsInfoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.animationController.forward();
    return Form(
      key: controller.pdfFormKey,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: controller.listLength.value,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(height: 20.0,),
        itemBuilder: (BuildContext context, int index) {
          final int count = controller.listLength.value > 10 ? 10 : controller.listLength.value;
          final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: invoiceController.animationController,
              curve: Interval(
                (1 / count) * index, 1.0,
                curve: Curves.fastOutSlowIn
              ),
            ),
          );
          return AnimationBuilderWidget(
            animation: animation,
            widget: SingleInfoListWidget(index: index, txtCtrl: controller.controllers[index],),
          );
        }
      ),
    );
  }
}