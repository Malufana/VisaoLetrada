// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:visaoletrada/home.dart';
import 'package:visaoletrada/navigation.dart';

TextEditingController _user = TextEditingController();
TextEditingController _pass = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String usuarioCadastro = "Careca";
  String senhaCadastrada = "Semdente@2025";
  String verificador = "";

  bool Logar(){
    if(_user.text == usuarioCadastro && _pass.text == senhaCadastrada){
      return true;
    }else{
      setState(() {
        verificador = "Credenciais erradas";
      });
      return false;
    }
  }

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
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            margin: const EdgeInsets.symmetric(horizontal: 32.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),  
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "USER",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    filled: true,
                    fillColor: Colors.grey[200]
                  ),
                  controller: _user,
                ),
                SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                    hintText: "PASSWORD",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    filled: true,
                    fillColor: Colors.grey[200]
                  ),
                  controller: _pass,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.black, width: 1)
                    )
                  ),
                  onPressed: (){
                    if(Logar()){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NavApp())
                      );
                    }
                  }, child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Entrar", style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                      ))
                    ],
                  ),
                  ),
                )
              ],
            ),  
          ),
        )
      )  
    );
  }
}