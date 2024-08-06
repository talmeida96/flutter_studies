// PROJETO 6 - LISTA COM ENTRADA DE TEXTO

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    meuaplicativo(),
  );
}

class meuaplicativo extends StatelessWidget {
  const meuaplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lista"),
          backgroundColor: Colors.blueAccent,
        ),
        body: conteudo(),
      ),
    );
  }
}

class conteudo extends StatefulWidget {
  const conteudo({super.key});

  @override
  State<conteudo> createState() => _conteudoState();
}

class _conteudoState extends State<conteudo> {
  final List<String> _lista = []; // Lista que armazenará os itens adicionados
  final TextEditingController _textController1 =
      TextEditingController(); // Controlador para o primeiro TextField
  final TextEditingController _textController2 =
      TextEditingController(); // Controlador para o segundo TextField

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _textController1,
            decoration: InputDecoration(labelText: "Item 1"),
          ),
          TextField(
            controller: _textController2,
            decoration: InputDecoration(labelText: "Item 2"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _lista
                    .add('${_textController1.text} - ${_textController2.text}');
                _textController1.clear();
                _textController2.clear();
              });
            },
            child: Text("Adicionar a lista"),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _lista.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_lista[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
