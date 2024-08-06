import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cartão de Visita'),
        ),
        body: Center(
          child: CartaoDeVisita(),
        ),
      ),
    );
  }
}

class CartaoDeVisita extends StatefulWidget {
  @override
  _CartaoDeVisitaState createState() => _CartaoDeVisitaState();
}

class _CartaoDeVisitaState extends State<CartaoDeVisita> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // padding: EdgeInsets.all(100.0),
        // color: Colors.yellow[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalhePage('Thayná')),
                );
              },
              child: Text(
                'Nome',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Icon(Icons.face_3, size: 40),
            SizedBox(height: 20),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalhePage('+55 (015)')),
                );
              },
              child: Text(
                'Telefone',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Icon(Icons.phone_android, size: 40),
            SizedBox(height: 20),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalhePage('Engenheira')),
                );
              },
              child: Text(
                'Cargo',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Icon(Icons.badge, size: 40),
          ],
        ),
      ),
    );
  }
}

class DetalhePage extends StatelessWidget {
  final String titulo;

  DetalhePage(this.titulo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
      ),
      body: Center(
        child: Text(
          titulo,
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
