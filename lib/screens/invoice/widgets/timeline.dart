import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timelines/timelines.dart';

import '../../../../constants/timeline.dart';
import '../../../../widgets/bezier_painter.dart';
import '../../../constants/controllers.dart';

class InvoiceTimeline extends StatelessWidget {
  const InvoiceTimeline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Timeline.tileBuilder(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        theme: TimelineThemeData(
          direction: Axis.horizontal,
          connectorTheme: const ConnectorThemeData(
            space: 30.0,
            thickness: 5.0,
          ),
          nodePosition: 0.0,
          nodeItemOverlap: false,
        ),
        builder: TimelineTileBuilder.connected(
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          addSemanticIndexes: false,
          itemCount: invoiceController.processes.length,
          connectionDirection: ConnectionDirection.before,
          nodePositionBuilder: (context, index) => 0,
          itemExtentBuilder: (_, __) => MediaQuery.of(context).size.width / invoiceController.processes.length,
          contentsBuilder: (context, index) {
            return Obx(() => Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                invoiceController.processes[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: invoiceController.getColor(index),
                ),
              ),
            ),);
          },
          indicatorBuilder: (_, index) {
            var color;
            var child;
            return Obx(() {
              
              if (index == invoiceController.processIndex.value) {
                color = inProgressColor;
                child = const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              } 
              
              else if (index < invoiceController.processIndex.value) {
                color = completeColor;
                child = const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15.0,
                );
              } 
              
              else {
                color = todoColor;
              }
          
              return index <= invoiceController.processIndex.value ?
              Stack(
                children: [
                  CustomPaint(
                    size: const Size(30.0, 30.0),
                    painter: BezierPainter(
                      color: color,
                      drawStart: index > 0,
                      drawEnd: index < invoiceController.processIndex.value,
                    ),
                  ),
                  DotIndicator(
                    size: 30.0,
                    color: color,
                    child: child,
                  ),
                ],
              )
              :
              Stack(
                children: [
                  CustomPaint(
                    size: const Size(15.0, 15.0),
                    painter: BezierPainter(
                      color: color,
                      drawEnd: index < invoiceController.processes.length - 1,
                    ),
                  ),
                  OutlinedDotIndicator(
                    borderWidth: 4.0,
                    color: color,
                  ),
                ]
              );
            });
          },
          connectorBuilder: (_, index, type) {
            return Obx((){
              if (index > 0) {
                if (index == invoiceController.processIndex.value) {
                  final prevColor = invoiceController.getColor(index - 1);
                  final color = invoiceController.getColor(index);
                  List<Color> gradientColors;
                  if (type == ConnectorType.start) {
                    gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
                  } 
                  
                  else {
                    gradientColors = [
                      prevColor,
                      Color.lerp(prevColor, color, 0.5)!
                    ];
                  }
                  return DecoratedLineConnector(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                      ),
                    ),
                  );
                } 
                
                else {
                  return SolidLineConnector(
                    color: invoiceController.getColor(index),
                  );
                }
              } 
              
              else {
                return const SizedBox.shrink();
              }
            });
          },
        ),
      ),
    );
  }
}