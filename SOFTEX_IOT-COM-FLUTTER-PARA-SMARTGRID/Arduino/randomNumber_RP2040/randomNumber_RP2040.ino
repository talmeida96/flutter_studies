#include <WiFiNINA.h>
#include <MQTT.h>
#include <MQTTClient.h>

// Definição das credenciais da rede WiFi
char ssid[] = "Projeto-Lader";
char pass[] = "Lader1234@";
int status = WL_IDLE_STATUS;  // status do rádio WiFi (inicialmente ocioso)

WiFiClient wifiClient;   // Cria um cliente WiFi
MQTTClient mqttClient;   // Cria um cliente MQTT

// Definição do servidor MQTT e informações de autenticação
#define BROKER_IP     "test.mosquitto.org"  // IP do broker MQTT
const char topic[] =  "FIT_thay";  // Tópico MQTT para publicação
#define DEV_NAME      "mqttdevice2"

unsigned long lastMillis = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  conectawifi();  // função para conexão ao WiFi
  mqttClient.begin(BROKER_IP, 1883, wifiClient); // Inicializa o cliente MQTT com o IP do broker e a porta 1883
  conectamqtt(); // Conecta-se ao servidor MQTT
}

void loop() {
  // put your main code here, to run repeatedly:
  mqttClient.loop(); // Mantém a conexão MQTT ativa, processando mensagens recebidas
  if (!mqttClient.connected()) { // Se desconectado do MQTT, tenta reconectar
    conectawifi(); // Reconecta à rede WiFi
    conectamqtt(); // Reconecta ao servidor MQTT
    //printData(); // Imprime informações da rede
  }
  if (millis() - lastMillis > 5000) { // Verifica se passaram 5 segundos desde o último envio
    lastMillis = millis(); // Atualiza o tempo da última mensagem enviada
    enviaValores(); // Envia valores aleatórios via MQTT
  }
}

void conectawifi() {
  // tenta conectar-se à rede WiFi
  while (status != WL_CONNECTED) { // continua tentando até conectar
    Serial.print("Tentando conectar à rede: ");
    Serial.println(ssid);
    status = WiFi.begin(ssid, pass); // inicia a conexão WiFi
    delay(10000); // Aguarda 10 segundos para a conexão
  }

  // Se conectado, imprime os dados da rede
  Serial.println("Conectado à rede");
  Serial.println("----------------------------------------");
  printData(); // Imprime informações da rede
  Serial.println("----------------------------------------");
}

void printData() {
  // Imprime informações da placa e da rede
  Serial.println("Informações da Placa:");
  IPAddress ip = WiFi.localIP(); // Obtém o endereço IP local
  Serial.print("Endereço IP: ");
  Serial.println(ip);

  Serial.println("Informações da Rede:");
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID()); // Obtém o SSID da rede

  long rssi = WiFi.RSSI(); // Obtém a força do sinal
  Serial.print("Força do sinal (RSSI): ");
  Serial.println(rssi);

  byte encryption = WiFi.encryptionType(); // Obtém o tipo de criptografia
  Serial.print("Tipo de criptografia: ");
  Serial.println(encryption, HEX);
}

void conectamqtt() {
  // Conecta-se ao servidor MQTT
  Serial.print("\nConectando ao MQTT...");
  while (!mqttClient.connect(DEV_NAME)) {
    Serial.print(".");
    delay(1000);
  }
  Serial.println("\nConectado ao MQTT!");
  Serial.print("BROKER_IP: ");
  Serial.println(BROKER_IP);
}

void enviaValores() {
  // Gera um valor aleatório entre 0 e 50 e envia via MQTT
  int valor = random(0, 51); // Gera um valor aleatório entre 0 e 50
  char mensagem[50];
  snprintf(mensagem, 50, "%d", valor); // Converte o valor para string
  mqttClient.publish(topic, mensagem); // Publica a mensagem no tópico MQTT
  Serial.print("Valor enviado: ");
  Serial.println(mensagem);
}



