import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visaoletrada/detalhesLivro.dart';

class ListaLivro extends StatefulWidget {
  const ListaLivro({super.key});

  @override
  State<ListaLivro> createState() => __ListaLivroState();
}

class __ListaLivroState extends State<ListaLivro> {
  
  final TextEditingController linkImgController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();

  Future<void> postData() async {
    final String linkImg = linkImgController.text;
    final String titulo = tituloController.text;

    await FirebaseFirestore.instance.collection("Livros").add(
      {
        'linkImg': linkImg,
        'titulo': titulo
      }
    );

    if(!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Expanded(child: Text("Livro Salvo com Sucesso!"))
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: Duration(seconds: 3),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );

    linkImgController.clear();
    tituloController.clear();

  }
  

  void _mostrarAdicionarLivro(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          title: const Text("Adicionar Livro"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tituloController,
                  readOnly: false,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Título do Livro",
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: linkImgController,
                  readOnly: false,
                  textInputAction: TextInputAction.none,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: "Link da imagem",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {

                final localContext = context;

                if(tituloController.text.isEmpty || linkImgController.text.isEmpty){
                  ScaffoldMessenger.of(localContext).showSnackBar(
                    const SnackBar(content: Text("Preencha todos os campos!"))
                  );
                  return;
                }

                Navigator.of(localContext).pop();

                await postData();
              },
              child: const Text("Salvar"),
            )
          ],
        );
      },
    );
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
            Icon(Icons.library_books, color: Colors.black),
            SizedBox(width: 8),
            Text(
              "Leituras",
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
        child: Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight + 32.0),
          child: Column(
            children: [
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(120),
                      side: const BorderSide(color: Colors.black)
                    ),
                  ),
                  onPressed: () {
                    _mostrarAdicionarLivro();
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text("Adicionar Livro")
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Livros').snapshots(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }
                    if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                      return const Center(child: Text("Nenhum livro adicionado!"));
                    }

                    final livros = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: livros.length,
                      itemBuilder: (context, index){
                        var livro = livros[index];
                        final titulo = livro['titulo'];
                        final linkImg = livro['linkImg'];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetalhesLivros(livro: livro)),
                            );
                          },

                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Color(0xFF8ED0F6),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.black, width: 1.5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      linkImg,
                                      height: 250,
                                      width: 150,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    titulo,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.visible
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}