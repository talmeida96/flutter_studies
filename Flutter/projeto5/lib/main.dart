// PROJETO 4 - TRABALHANDO COM LISTAS (ADICIONAR E REINICIAR LISTA DE ITENS)
import 'package:flutter/material.dart';

void main() {
  runApp(
    listApp(),
  );
}

class listApp extends StatelessWidget {
  const listApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(
            "INCREMENTAL LIST",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: content(),
      ),
    );
  }
}

int quantidade = 0;

class content extends StatefulWidget {
  const content({super.key});

  @override
  State<content> createState() => _contentState();
}

class _contentState extends State<content> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.green;
              }
              return Colors.greenAccent;
            })),
            onPressed: () {
              //atualiza a tela com a nova quantidade
              quantidade = quantidade + 1;
              setState(() {});
            },
            child: Text(
              "ADD",
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.amber;
              }
              return Colors.amberAccent;
            })),
            onPressed: () {
              quantidade = 0;
              setState(() {});
            },
            child: Text("RESTART"),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: quantidade,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Thayná: $index"),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
