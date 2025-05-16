import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sobre extends StatefulWidget {
  const Sobre({super.key});

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {

  final String github = 'https://github.com/Malufana';

  Future<void> abrir() async{
    final Uri url = Uri.parse(github);
    if(await canLaunchUrl(url)){
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }else{
      throw "Não foi possível abrir";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: const [
            Icon(Icons.account_box_rounded, color: Colors.black),
            SizedBox(width: 8),
            Text(
              "Sobre o App",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5de0e6), Color(0xFF004aad)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.book, size: 80, color: Colors.white),
                const SizedBox(height: 20),
                const Text(
                  "App de Trecho de Livros",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Este aplicativo foi desenvolvido para salvar trechos de livros de forma prática e organizada, utilizando Flutter e Firebase.",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Criado e Desenvolvido por:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Ana Maluf",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 32),
                IconButton(
                  icon: const Icon(Icons.code, size: 40, color: Colors.white),
                  onPressed: abrir,
                  tooltip: "GitHub",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}