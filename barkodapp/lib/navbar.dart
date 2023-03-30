import 'package:barkodapp/homePage.dart';
import 'package:barkodapp/profilePage.dart';
import 'package:barkodapp/savePage.dart';
import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:barkodapp/qRcode.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ),
      ),
      home: Scaffold(
        body: Container(),
        bottomNavigationBar: MoltenBottomNavigationBar(
          selectedIndex: _selectedIndex,
          barHeight: 70,
          barColor: Color(0XFFFFDEB4),
          domeHeight: 20,
          onTabChange: (clickedIndex) {
            setState(() {
              _selectedIndex = clickedIndex;
              if (clickedIndex == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRViewExample(),
                  ),
                );
              } else if (clickedIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SavePage(),
                  ),
                );
              }
            });
          },
          tabs: [
            MoltenTab(
              icon: Icon(
                Icons.person,
              ),
            ),
            MoltenTab(
              icon: Icon(
                Icons.camera,
                color: Colors.black,
                size: 40,
              ),
              title: Text('Kamera'),
            ),
            MoltenTab(
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
