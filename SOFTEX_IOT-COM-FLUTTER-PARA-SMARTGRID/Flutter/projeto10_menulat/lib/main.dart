// PROJETO COM MENU LATERAL
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
          backgroundColor: Colors.greenAccent,
          title: Text("MY MENU APP"),
        ),
        backgroundColor: Colors.white70,
        drawer: Drawer(
          backgroundColor: Colors.amberAccent,
          child: menu(),
        ),
        body: conteudo(),
      ),
    );
  }
}

class menu extends StatelessWidget {
  const menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          FlutterLogo(),
          Text(
            "DEVELOPED BY:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("Thayná Almeida")
        ],
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
      child: Text("lorem ipsum"),
    );
  }
}
