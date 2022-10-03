import 'package:flutter/material.dart';

class InvoiceField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String helperText;
  final TextEditingController controller;
  final Icon icon;

  const InvoiceField({
    Key? key,
    required this.hintText, 
    required this.labelText, 
    required this.helperText, 
    required this.controller, 
    required this.icon, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          labelText: labelText,
          alignLabelWithHint: true,
          border: const OutlineInputBorder(),
          helperText: helperText,
          prefixIcon: icon,
        ),
        keyboardType: TextInputType.streetAddress,
        controller: controller,
        style: TextStyle(color: Colors.grey[850]),
        validator: (value) => value!.isEmpty ? helperText : null,
        toolbarOptions: const ToolbarOptions(copy: true, paste: true, cut: true, selectAll: true),
      ),
    );
  }
}