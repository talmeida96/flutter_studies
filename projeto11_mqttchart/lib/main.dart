import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    mqtt_chart(),
  );
}

class mqtt_chart extends StatelessWidget {
  const mqtt_chart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "MQTT Chart",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orangeAccent,
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
  final TextEditingController _brokerController =
      // Controlador para o TextField do broker
      TextEditingController();
  final TextEditingController _topicController =
      // Controlador para o TextField do tópico
      TextEditingController();

  // Lista para armazenar os dados do gráfico
  List<_ChartData> _chartData = [];

  // Cliente MQTT
  MqttServerClient? _client;

  // Controlador para a série do gráfico
  late ChartSeriesController _chartSeriesController;

// Função para conectar ao broker MQTT
  void _connect() async {
    // Obtém o broker do TextField
    final String broker = _brokerController.text;
    // Obtém o tópico do TextField
    final String topic = _topicController.text;

    // Inicializa o cliente MQTT
    _client = MqttServerClient(broker, '');
    _client!.logging(on: true);
    _client!.onConnected = _onConnected;
    _client!.onDisconnected = _onDisconnected;
    _client!.onSubscribed = _onSubscribed;

    // Configuração da mensagem de conexão
    final connMessage = MqttConnectMessage()
        .withClientIdentifier('Mqtt_Identifier')
        .keepAliveFor(60)
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    _client!.connectionMessage = connMessage;

    try {
      // Tenta conectar ao broker MQTT
      await _client!.connect();
    } catch (e) {
      print('Exception: $e');
      _client!.disconnect();
    }

    // Verifica se a conexão foi bem sucedida
    if (_client!.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected');
      // Inscreve no tópico
      _client!.subscribe(topic, MqttQos.atLeastOnce);
    } else {
      print(
          'ERROR: MQTT client connection failed - disconnecting, state is ${_client!.connectionStatus!.state}');
      _client!.disconnect();
    }
  }

  // Função chamada quando a conexão é estabelecida
  void _onConnected() {
    print('Connected');
  }

  // Função chamada quando a conexão é perdida
  void _onDisconnected() {
    print('Disconnected');
  }

// Função chamada quando a inscrição no tópico é bem sucedida
  void _onSubscribed(String topic) {
    print('Subscribed to $topic');
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('Received message: $pt from topic: ${c[0].topic}>');
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm').format(now);
      setState(() {
        _chartData.add(_ChartData(
            // Adiciona os dados ao gráfico
            now,
            double.tryParse(pt) ?? 0));
        _chartSeriesController.updateDataSource(
          addedDataIndexes: [
            _chartData.length - 1
          ], // Atualiza o gráfico com os novos dados
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _brokerController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "MQTT Broker",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _topicController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Topic",
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              _connect();
            },
            child: Text("CONNECT"),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat.Hm(),
                intervalType: DateTimeIntervalType
                    // Tipo de intervalo como minutos
                    .minutes,
                title: AxisTitle(text: 'HOUR'),
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: 'VALUE'),
              ),
              series: <LineSeries<_ChartData, DateTime>>[
                LineSeries<_ChartData, DateTime>(
                  // Fonte de dados do gráfico
                  dataSource: _chartData,
                  xValueMapper: (_ChartData data, _) =>
                      // Mapeia o eixo X para a hora
                      data.time,
                  yValueMapper: (_ChartData data, _) =>
                      // Mapeia o eixo Y para o valor
                      data.value,
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesController =
                        // Inicializa o controlador da série
                        controller;
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Classe para representar os dados do gráfico
class _ChartData {
  _ChartData(this.time, this.value);
  final DateTime time;
  final double value;
}
