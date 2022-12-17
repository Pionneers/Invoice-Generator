import 'package:flutter/material.dart';
import '/constants/drawer.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String accountName = "VR Pionneers Ventures";

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            margin: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            accountName: Row(
              children: const [
                Text(accountName),
                SizedBox(width: 5.0,),
                Icon(Icons.verified_user, size: 15.0, color: Colors.blue,)
              ],
            ),
            accountEmail: const Text("pionneers.dev@gmail.com"),
            currentAccountPicture: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text(
                accountName.substring(0,1).toUpperCase(),
                style: const TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 5),
              shrinkWrap: true,
              separatorBuilder: (_, __) => const Divider(height: 1.0), 
              itemCount: drawerTitles.length,
              itemBuilder: (context, index) => ListTile(
                dense: true,
                leading: drawerIcons[index],
                title: Text(drawerTitles[index]),
                onTap: drawerActions[index],
              ), 
            ),
          ),
        ]
      ),
    );
  }
}