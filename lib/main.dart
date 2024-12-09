import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/controller/cat_info_controller.dart';
import 'package:provider_project/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CatInfoController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
