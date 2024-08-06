// PROJETO 3

import 'package:flutter/material.dart';

void main() {
  runApp(
    meuapp(),
  );
}

class meuapp extends StatelessWidget {
  const meuapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Linha e coluna"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: Container(
            child: Column(
              // coloca um widget embaixo do outro
              children: [
                Text("Linha"),
                Icon(
                  Icons.linked_camera_outlined,
                ),
                Row(
                  // coloca um widget ao lado do outro
                  mainAxisAlignment: MainAxisAlignment.center, //centraliza
                  children: [
                    Text("Coluna"),
                    Icon(
                      Icons.linked_camera_outlined,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      Container(
                        height: 50,
                        color: Colors.amber[600],
                        child: const Center(child: Text('Entry A')),
                      ),
                      Container(
                        height: 50,
                        color: Colors.amber[500],
                        child: const Center(child: Text('Entry B')),
                      ),
                      Container(
                        height: 50,
                        color: Colors.amber[100],
                        child: const Center(child: Text('Entry C')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
