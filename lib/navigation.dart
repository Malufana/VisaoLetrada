// import 'package:flutter/material.dart';

// class NavApp extends StatefulWidget {
//   const NavApp({super.key});

//   @override
//   State<NavApp> createState() => _NavAppState();
// }


// class _NavAppState extends State<NavApp> {

//   int selectIndex = 0;

//   static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

//   static List<Widget> WidgetOptions = <Widget>[];

//   void showItemTrap(int index){
//     setState(() {
//       selectIndex = index;
//     });
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(selectIndex),
//       ),

//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black,
//               blurRadius: 10,
//               offset: Offset(0, -1),
//             )
//           ]
//         ),
//         child: BottomNavigationBar(items: items),
//       ),
//     );
//   }
// }