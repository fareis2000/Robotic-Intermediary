#include <SoftwareSerial.h> // Biblioteca para comunicação serial

// Definição dos pinos dos motores
const int motorEsquerdaFrente = 3;
const int motorEsquerdaTras = 5;
const int motorDireitaFrente = 6;
const int motorDireitaTras = 9;

// Definição dos pinos do módulo Bluetooth
const int bluetoothRx = 10; // RX do módulo Bluetooth
const int bluetoothTx = 11; // TX do módulo Bluetooth

// Inicializa a comunicação serial para o Bluetooth nas portas 10 e 11
SoftwareSerial Bluetooth(bluetoothRx, bluetoothTx);

// Definições dos comandos
#define FORWARD 'F'
#define BACKWARD 'B'
#define LEFT 'L'
#define RIGHT 'R'
#define STOP 'S' // Novo comando para parar

void setup() {
  // Configuração dos pinos dos motores como saída
  pinMode(motorEsquerdaFrente, OUTPUT);
  pinMode(motorEsquerdaTras, OUTPUT);
  pinMode(motorDireitaFrente, OUTPUT);
  pinMode(motorDireitaTras, OUTPUT);

  // Inicializa a comunicação serial
  Serial.begin(9600);  // Para monitoramento no Serial Monitor
  Bluetooth.begin(9600);  // Para comunicação com o módulo Bluetooth

  Serial.println("Carrinho Bluetooth pronto!");
}

void loop() {
  if (Bluetooth.available()) {
    char command = Bluetooth.read();  // Lê o comando recebido do Bluetooth
    Serial.print("Comando recebido: ");
    Serial.println(command);  // Mostra o comando recebido no Serial Monitor
    executeCommand(command);  // Executa o comando
  }
}

// Função para executar os comandos recebidos
void executeCommand(char command) {
  switch (command) {
    case FORWARD: // Movendo para frente
      Serial.println("Movendo para frente");
      moverFrente();
      break;

    case BACKWARD: // Movendo para trás
      Serial.println("Movendo para trás");
      moverTras();
      break;

    case LEFT: // Virando para a esquerda
      Serial.println("Virando para a esquerda");
      virarEsquerda();
      break;

    case RIGHT: // Virando para a direita
      Serial.println("Virando para a direita");
      virarDireita();
      break;

    case STOP: // Parando os motores
      Serial.println("Parando os motores");
      pararMotores();
      break;

    default:
      Serial.println("Comando inválido");
      pararMotores();
      break;
  }
}

// Funções de controle dos motores
void moverFrente() {
  digitalWrite(motorEsquerdaFrente, HIGH);
  digitalWrite(motorEsquerdaTras, LOW);
  digitalWrite(motorDireitaFrente, HIGH);
  digitalWrite(motorDireitaTras, LOW);
}

void moverTras() {
  digitalWrite(motorEsquerdaFrente, LOW);
  digitalWrite(motorEsquerdaTras, HIGH);
  digitalWrite(motorDireitaFrente, LOW);
  digitalWrite(motorDireitaTras, HIGH);
}

void virarEsquerda() {
  digitalWrite(motorEsquerdaFrente, LOW);
  digitalWrite(motorEsquerdaTras, HIGH);
  digitalWrite(motorDireitaFrente, HIGH);
  digitalWrite(motorDireitaTras, LOW);
}

void virarDireita() {
  digitalWrite(motorEsquerdaFrente, HIGH);
  digitalWrite(motorEsquerdaTras, LOW);
  digitalWrite(motorDireitaFrente, LOW);
  digitalWrite(motorDireitaTras, HIGH);
}

void pararMotores() {
  digitalWrite(motorEsquerdaFrente, LOW);
  digitalWrite(motorEsquerdaTras, LOW);
  digitalWrite(motorDireitaFrente, LOW);
  digitalWrite(motorDireitaTras, LOW);
}
