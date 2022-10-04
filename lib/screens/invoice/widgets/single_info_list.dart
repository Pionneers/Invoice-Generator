import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleInfoListWidget extends StatelessWidget {
  final int index;
  final List<TextEditingController> txtCtrl;
  const SingleInfoListWidget({Key? key, required this.index, required this.txtCtrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 1.0,
        color: Colors.white,
        type: MaterialType.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: Colors.primaries[index], width: 4.0)),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      isDense: true,
                      // hintText: "Description",
                      // labelText: "Description",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      helperText: "Product name",
                      prefixIcon: Icon(Icons.shopping_bag_outlined),
                    ),
                    keyboardType: TextInputType.text,
                    controller: txtCtrl[0],
                    style: TextStyle(color: Colors.grey[850]),
                    validator: (value) => value!.isEmpty ? "Enter product name" : null,
                    toolbarOptions: const ToolbarOptions(copy: true, paste: true, cut: true, selectAll: true),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      isDense: true,
                      // hintText: "Unit Price",
                      // labelText: "Unit Price",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      helperText: "Unit Price",
                      prefixIcon: Icon(Icons.price_change_outlined),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    controller: txtCtrl[1],
                    style: TextStyle(color: Colors.grey[850]),
                    validator: (value) => value!.isEmpty ? "Enter unit price" : null,
                    toolbarOptions: const ToolbarOptions(copy: true, paste: true, cut: true, selectAll: true),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      isDense: true,
                      // hintText: "Quantity",
                      // labelText: "Quantity",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      helperText: "Quantity",
                      prefixIcon: Icon(Icons.format_list_numbered_outlined),
                    ),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
                    keyboardType: const TextInputType.numberWithOptions(),
                    controller: txtCtrl[2],
                    style: TextStyle(color: Colors.grey[850]),
                    validator: (value) => value!.isEmpty ? "Enter quantity" : null,
                    toolbarOptions: const ToolbarOptions(copy: true, paste: true, cut: true, selectAll: true),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}