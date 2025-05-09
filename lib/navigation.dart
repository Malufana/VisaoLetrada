import 'package:flutter/material.dart';
import 'package:visaoletrada/home.dart';
import 'package:visaoletrada/listaLivro.dart';

class NavApp extends StatefulWidget {
  const NavApp({super.key});

  @override
  State<NavApp> createState() => _NavAppState();
}


class _NavAppState extends State<NavApp> {

  int selectIndex = 0;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    TelaHome(),
    ListaLivro()
  ];

  void showItemTrap(int index){
    setState(() {
      selectIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5de0e6), Color(0xFF004aad)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              border: Border(top: BorderSide(color: Colors.black, width: 2))
            ),
          ),
          Center(
            child: _widgetOptions.elementAt(selectIndex),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5de0e6), Color(0xFF004aad)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: selectIndex,
          onTap: showItemTrap,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          selectedIconTheme: IconThemeData(size: 35),
          unselectedIconTheme: IconThemeData(size: 25),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Leituras"
            )
          ],
        ),
      ),
    );
  }
}