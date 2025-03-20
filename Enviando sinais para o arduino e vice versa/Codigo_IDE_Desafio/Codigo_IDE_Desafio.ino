// Definição dos pinos dos LEDs
int led_vermelho = 7;
int led_amarelo = 6;
int led_verde = 5;

void setup() {
  // Configura os pinos como saída
  pinMode(led_vermelho, OUTPUT);
  pinMode(led_amarelo, OUTPUT);
  pinMode(led_verde, OUTPUT);

  Serial.begin(9600); // Inicializa a comunicação serial
}

void loop() {
  if (Serial.available() > 0) {
    char state = Serial.read(); // Lê o caractere recebido do Processing

    // Controla os LEDs conforme o comando recebido
    if (state == 'R') {  // Vermelho
      digitalWrite(led_vermelho, HIGH);
      digitalWrite(led_amarelo, LOW);
      digitalWrite(led_verde, LOW);
    } else if (state == 'Y') {  // Amarelo
      digitalWrite(led_vermelho, LOW);
      digitalWrite(led_amarelo, HIGH);
      digitalWrite(led_verde, LOW);
    } else if (state == 'G') {  // Verde
      digitalWrite(led_vermelho, LOW);
      digitalWrite(led_amarelo, LOW);
      digitalWrite(led_verde, HIGH);
    }
  }
}
