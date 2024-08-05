// PROJETO 5 - USO DE EXPAND, ROW E COLUMN

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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(color: Colors.red),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Container(
                  color: Colors.yellow,
                  width: 50,
                  height: 50,
                ),
                Row(
                  children: [
                    SizedBox(width: 50),
                    Container(
                      color: Colors.brown,
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      color: Colors.green,
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
