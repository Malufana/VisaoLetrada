import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetalhesLivros extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> livro;

  const DetalhesLivros({super.key, required this.livro});

  @override
  State<DetalhesLivros> createState() => _DetalhesLivrosState();
}

class _DetalhesLivrosState extends State<DetalhesLivros> {

  final TextEditingController trechoController = TextEditingController();

  Future<void> adicionarTrecho() async{
    final texto = trechoController.text.trim();
    if(texto.isEmpty) return;

    await FirebaseFirestore.instance.collection("Livros").doc(widget.livro.id).collection("Trechos").add({
      'texto': texto
    });

    trechoController.clear();
    Navigator.pop(context);
  }

  Future<void> removerTrecho(String id) async{
    await FirebaseFirestore.instance.collection("Livros").doc(widget.livro.id).collection("Trechos").doc(id).delete();
  }

  void modalAdicionarTrecho(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Novo Trecho"),
        content: TextField(
          controller: trechoController,
          maxLines: 15,
          decoration: const InputDecoration(
            hintText: "Digite o trecho do livro",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
              trechoController.clear();
            },
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: adicionarTrecho,
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          children: [
            const Icon(Icons.library_books, color: Colors.black),
            const SizedBox(width: 8),
            Expanded(
              child: Text(widget.livro['titulo'], style: TextStyle(color: Colors.black), overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: modalAdicionarTrecho,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 100),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5de0e6), Color(0xFF004aad)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Livros").doc(widget.livro.id).collection("Trechos").snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());

            final trechos = snapshot.data!.docs;

            if(trechos.isEmpty){
              return const Center(
                child: Text(
                  "Nenhum trecho adicionado.",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: trechos.length,
              itemBuilder: (context, index){
                final trecho = trechos[index];

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 6,
                        offset: const Offset(0, 3)
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.black),
                          onPressed: () => removerTrecho(trecho.id),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Text(
                            trecho['texto'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}