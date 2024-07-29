import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_pdf/views/screens/add_book_screen.dart';
import 'package:read_pdf/views/screens/home_screen.dart';
import 'package:read_pdf/controllers/bottom_nav_controller.dart'; 

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());

    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: const [
            HomeScreen(),
            AddBookScreen(),
            Placeholder(), 
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add book',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.changeIndex(index);
          },
        );
      }),
    );
  }
}
