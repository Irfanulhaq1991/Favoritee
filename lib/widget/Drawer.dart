import 'package:favoritee/screens/dogs_screen.dart';
import 'package:favoritee/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'Toast.dart';


class AppNavigationDrawer extends StatefulWidget {
  const AppNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<AppNavigationDrawer> createState() => _AppNavigationDrawerState();
}

class _AppNavigationDrawerState extends State<AppNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                hoverColor: Colors.amber,
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                leading: const Icon(
                  Icons.adb_rounded,
                  color: Colors.amber,
                ),
                title: Text(
                  "Dogs",
                  style: TextStyle(
                    color: Colors.grey[610],
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DogsScreen()));
                },
              ),
              const Divider(
                color: Colors.amber,
              ),
              ListTile(
                hoverColor: Colors.amber,
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                leading: const Icon(
                  Icons.movie,
                  color: Colors.amber,
                ),
                title: Text(
                  "Movies",
                  style: TextStyle(
                    color: Colors.grey[610],
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  showToast(context, "Movies");
                  Navigator.pop(context);
                  showToast(context, "Not implemented yet");
                },
              ),
              const Divider(
                color: Colors.amber,
              ),
              ListTile(
                hoverColor: Colors.amber,
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                leading: const Icon(
                  Icons.gite,
                  color: Colors.amber,
                ),
                title: Text(
                  "Github repos",
                  style: TextStyle(
                    color: Colors.grey[610],
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  showToast(context, "Not implemented yet");
                  Navigator.pop(context);
                },
              ),
              const Divider(
                color: Colors.amber,
              ), ListTile(
                hoverColor: Colors.amber,
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                leading: const Icon(
                  Icons.gite,
                  color: Colors.amber,
                ),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.grey[610],
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));

                },
              ),
              const Divider(
                color: Colors.amber,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Design & Develop @Irfan",
                        style: TextStyle(
                          color: Colors.grey[610],
                          letterSpacing: 2.0,
                          fontSize: 11
                        ),
                      )))
            ],
          )),
    ));
  }
}
