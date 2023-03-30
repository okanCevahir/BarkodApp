import 'package:barkodapp/homePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barkod App',
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}


navega(context, page) {
  String actualProgram = page.toString();
  print(actualProgram);
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return page;
  }));
}

