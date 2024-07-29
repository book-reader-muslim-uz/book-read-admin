import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:read_pdf/firebase_options.dart';
import 'package:read_pdf/views/screens/add_book_screen.dart';
import 'package:read_pdf/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
