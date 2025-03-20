// Definição dos pinos
int led_pin = 7;   // Pino onde o LED está conectado
int pot_pin = A0;  // Pino do potenciômetro
int pot_output;    // Variável para armazenar a leitura do potenciômetro
char lastState = ' '; // Variável para armazenar o último estado recebido pela Serial

void setup() {
  pinMode(led_pin, OUTPUT); // Configura o LED como saída
  Serial.begin(9600);       // Inicializa a comunicação Serial com baud rate de 9600
}

void loop() {
  // Lê o valor do potenciômetro (0 a 1023)
  pot_output = analogRead(pot_pin);

  // Mapeia o valor lido para a faixa de 0 a 255 (escala de brilho de LEDs)
  int mapped_output = map(pot_output, 0, 1023, 0, 255);

  // Envia o valor mapeado para o Processing via Serial
  Serial.println(mapped_output);

  // Verifica se há dados disponíveis na Serial
  if (Serial.available() > 0) {
    char state = Serial.read(); // Lê o caractere recebido

    // Só altera o estado do LED se o novo comando for diferente do último recebido
    if (state != lastState) {
      lastState = state; // Atualiza o último estado

      // Liga ou desliga o LED de acordo com o caractere recebido
      if (state == '1') {
        digitalWrite(led_pin, HIGH);
      } else if (state == '0') {
        digitalWrite(led_pin, LOW);
      }
    }
  }

  delay(10); // Pequeno atraso para evitar sobrecarga na comunicação
}
