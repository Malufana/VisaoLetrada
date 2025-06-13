import 'package:flutter/material.dart';
import 'package:visaoletrada/auth.dart';
import 'package:visaoletrada/home.dart';

class LoginAutenticado extends StatefulWidget {
  const LoginAutenticado({super.key});

  @override
  State<LoginAutenticado> createState() => _LoginAutenticadoState();
}

class _LoginAutenticadoState extends State<LoginAutenticado> {
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página de Login"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(
                hintText: "Digite seu email"
              ),
            ),
            TextField(
              controller: _senha,
              decoration: InputDecoration(
                hintText: "Digite sua senha"
              ),
              obscureText: true,
              obscuringCharacter: '+',
            ),
            Row(children: [
              ElevatedButton(
                onPressed: () async{
                  final message = await AuthService.login(email: _email.text, password: _senha.text);
                  if(massage!.contains("Success")){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TelaHome()));
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
                }, child: Text("LOGIN")
              )
            ])
          ],
        ),
      ),
    );
  }
}