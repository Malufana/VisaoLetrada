import 'package:flutter/material.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5de0e6), Color(0xFF004aad)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/TrechosLivros.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}