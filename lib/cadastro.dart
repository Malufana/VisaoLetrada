import 'package:flutter/material.dart';
import 'package:visaoletrada/auth.dart';
import 'package:visaoletrada/home.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Usuario"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(hintText: "Digite seu email"),
            ),
            TextField(
              controller: _senha,
              decoration: InputDecoration(hintText: "Digite sua senha"),
              obscureText: true,
              obscuringCharacter: "+",
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final message = await AuthService().registration(email: _email.text, password: _senha.text);

                    if(message!.contains("Success")){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TelaHome()));
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message))
                    );
                  },child: Text("Cadastrar")
                ),
                ElevatedButton(
                  onPressed: (){
                    _email.text = "";
                    _senha.text = "";
                  }, 
                  child: Text("Limpar credenciais")
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}