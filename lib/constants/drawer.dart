import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

const String invoices = "Invoices";
const String customers = "Customers";
const String address = "Address";

const List<String> drawerTitles = <String> [
  invoices, 
  customers, 
  address,
];

const List<Icon> drawerIcons = <Icon> [
  Icon(Icons.receipt_long_outlined, size: 20.0, color: Colors.redAccent,),
  Icon(Icons.person_outline_outlined, size: 20.0, color: Colors.redAccent,),
  Icon(Icons.home_outlined, size: 20.0, color: Colors.redAccent,),
];

final List drawerActions = [
  () => {},
  (){},
  () => {},
];
