import 'package:flutter/material.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  const MainAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      // actions: <Widget>[
      //   Tooltip(
      //     message: "Logout",
      //     child: TextButton.icon(
      //       label: const Text("Logout"),
      //       style: TextButton.styleFrom(
      //         enableFeedback: false,
      //         primary: Colors.black,
      //         padding: const EdgeInsets.symmetric(horizontal: 15.0),
      //       ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      //       icon: const Icon(Icons.logout_outlined),
      //       onPressed: () => {},
      //     ),
      //   ),
      // ],
    );
  }
}