import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(
    mqtt(),
  );
}

class mqtt extends StatelessWidget {
  const mqtt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text("MQTT Client"),
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
  // Controladores de texto para capturar a entrada do usuário.
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _brokerController = TextEditingController();

  // Variáveis para armazenar o status da conexão e a mensagem recebida.
  String _status = "Disconnected";
  String _receivedMessage = "";

  // Cliente MQTT.
  late MqttServerClient _client;

  // Função que realiza a conexão ao broker MQTT.
  void _connect() async {
    // Inicializa o cliente MQTT com o endereço do broker.
    _client = MqttServerClient(_brokerController.text, '');
    // Habilita o log para depuração
    _client.logging(on: true);

    // Define os callbacks para eventos de desconexão, conexão e inscrição.
    _client.onDisconnected = _onDisconnected;
    _client.onConnected = _onConnected;
    _client.onSubscribed = _onSubscribed;

    // Mensagem de conexão com configurações adicionais.
    final connMessage = MqttConnectMessage()
        // Identificador do cliente.
        .withClientIdentifier('flutter_client')
        .startClean()
        .withWillQos(
            // Define a qualidade de serviço (QoS).
            MqttQos.atLeastOnce);
    _client.connectionMessage = connMessage;

    try {
      // Tenta conectar ao broker.
      await _client.connect();
    } catch (e) {
      // Em caso de falha na conexão, atualiza o status e desconecta.
      setState(() {
        _status = 'Connection Failed: $e';
        _client.disconnect();
      });
      return;
    }

    // Listener para mensagens recebidas.
    _client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      // Atualiza a mensagem recebida no estado do widget.
      setState(() {
        _receivedMessage = pt;
      });
    });

    // Inscreve-se no tópico fornecido pelo usuário.
    _client.subscribe(_topicController.text, MqttQos.atLeastOnce);
  }

  // Callback para quando o cliente é desconectado.
  void _onDisconnected() {
    setState(() {
      _status = 'Disconnected';
    });
  }

  // Callback para quando o cliente é conectado.
  void _onConnected() {
    setState(() {
      _status = 'Connected';
    });
  }

  // Callback para quando o cliente se inscreve em um tópico.
  void _onSubscribed(String topic) {
    setState(() {
      _status = 'Subscribed at Topic: $topic';
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
                labelText: "MQTT Broker",
                labelStyle: TextStyle(color: Colors.blueGrey)),
          ),
          TextField(
            controller: _topicController,
            decoration: InputDecoration(
                labelText: "Topic",
                labelStyle: TextStyle(color: Colors.blueGrey)),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return Colors.green;
              }
              return Colors.greenAccent;
            })),
            onPressed: () {
              _connect();
            },
            child: Text("CONNECT"),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "[Status] $_status",
            style: TextStyle(backgroundColor: Colors.amberAccent),
          ),
          Text("Received Message: $_receivedMessage"),
        ],
      ),
    );
  }
}
