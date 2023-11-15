import 'dart:developer';

import 'package:flutter/material.dart';

BottomNavigationBar bottomNavigationBar(BuildContext context) {
  int currentIndex = 0; // Initialize the current index
  final currentRoute = ModalRoute.of(context)!.settings.name;
  return BottomNavigationBar(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    elevation: 0,
    backgroundColor: Colors.black,
    type: BottomNavigationBarType.fixed,
    currentIndex: currentIndex, // Set the current index
    onTap: (index) {
      currentIndex = index; // Update the current index
      switch (index) {
        case 0:
          if (currentRoute != "/") {
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          }
          break;
        case 1:
          log("Hello");
          break;
        case 2:
          if (currentRoute != "/add-post") {
            Navigator.pushNamed(
                context, "/add-post");
          }
          break;
        case 3:
          () {
            log("Hello");
          };
          break;
        case 4:
          if (currentRoute != "/profile") {
            Navigator.pushNamedAndRemoveUntil(
                context, "/profile", (route) => false);
          }
          break;
      }
    },
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.house, color: Colors.white, size: 28),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search, color: Colors.white, size: 28),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_box_outlined, color: Colors.white, size: 28),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.video_call, color: Colors.white, size: 28),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.verified_user, color: Colors.white, size: 28),
        label: '',
      ),
    ],
  );
}
