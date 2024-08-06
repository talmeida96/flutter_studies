// PROJETO 7 - GRAFICO DE LINHAS COM INSERÇÃO MANUAL DE VALORES
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(
    chart_app(),
  );
}

class chart_app extends StatelessWidget {
  const chart_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text(
            "LINE CHART",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: contudo(),
      ),
    );
  }
}

class contudo extends StatefulWidget {
  const contudo({super.key});

  @override
  State<contudo> createState() => _contudoState();
}

class _contudoState extends State<contudo> {
  final TextEditingController _xController =
      // Controlador para o campo de texto do eixo X.
      TextEditingController();
  final TextEditingController _yController =
      // Controlador para o campo de texto do eixo Y.
      TextEditingController();
  // Lista para armazenar os pontos de dados inseridos.
  List<_DataPoint> _dataPoints = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _xController,
                  decoration: InputDecoration(
                    labelText: "(X) VALUE",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextField(
                  controller: _yController,
                  decoration: InputDecoration(
                    labelText: "(Y) VALUE",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.green;
              }
              return Colors.greenAccent;
            })),
            onPressed: () {
              setState(() {
                // Tenta converter o texto do campo X para um número.
                double? x = double.tryParse(_xController.text);
                // Tenta converter o texto do campo Y para um número.
                double? y = double.tryParse(_yController.text);
                if (x != null && y != null) {
                  // Atualiza o estado do widget para adicionar o novo ponto de dados.
                  _dataPoints.add(_DataPoint(x, y));
                }
                _xController.clear(); // Limpa o campo de texto do eixo X.
                _yController.clear(); // Limpa o campo de texto do eixo Y.
              });
            },
            child: Text("ADD"),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.red;
              }
              return Colors.redAccent;
            })),
            onPressed: () {
              setState(() {
                // Limpa a lista de pontos de dados.
                _dataPoints.clear();
              });
            },
            child: Text(
              "DELETE CHART",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: NumericAxis(), // Define o eixo X como numérico.
              primaryYAxis: NumericAxis(), // Define o eixo Y como numérico.
              series: <CartesianSeries<dynamic, dynamic>>[
                LineSeries<_DataPoint, double>(
                  dataSource:
                      _dataPoints, // Fonte de dados para a série de linha.
                  xValueMapper: (_DataPoint point, _) =>
                      point.x, // Mapeia o valor X de cada ponto de dados.
                  yValueMapper: (_DataPoint point, _) =>
                      point.y, // Mapeia o valor Y de cada ponto de dados.
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DataPoint {
  // Classe para representar um ponto de dados.
  _DataPoint(this.x, this.y); // Construtor que inicializa os valores X e Y.
  final double x; // Valor X do ponto de dados.
  final double y; // Valor Y do ponto de dados.
}
