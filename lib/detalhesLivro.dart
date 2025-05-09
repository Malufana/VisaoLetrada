import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class DetalhesLivros extends StatefulWidget {
  const DetalhesLivros({super.key, required QueryDocumentSnapshot<Object?> livro});

  @override
  State<DetalhesLivros> createState() => _DetalhesLivrosState();
}

class _DetalhesLivrosState extends State<DetalhesLivros> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}