import processing.serial.*; // Importa a biblioteca Serial

Serial myPort;  // Objeto para a comunicação Serial
float background_color = 0; // Variável para armazenar a cor de fundo
boolean ledState = false;   // Estado atual do LED (evita enviar dados repetidamente)

void setup() {
  size(500, 500);                 // Define o tamanho da janela do Processing
  myPort = new Serial(this, "COM5", 9600); // Abre a comunicação Serial com a porta "COM5"
  myPort.bufferUntil('\n');        // Aguarda até receber um caractere de nova linha
}

// Função chamada automaticamente quando uma nova linha de dados é recebida pela Serial
void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n'); // Lê a string até a quebra de linha
  
  if (inString != null) {  // Garante que a string não seja nula
    inString = trim(inString); // Remove espaços extras
    background_color = float(inString); // Converte a string para número
  }
}

void draw() {
  background(150, 50, background_color); // Atualiza a cor do fundo com base no potenciômetro

  // Determina o novo estado do LED com base no clique do mouse
  boolean newLedState = mousePressed && (mouseButton == LEFT);

  // Só envia um comando para o Arduino se o estado do LED mudar
  if (newLedState != ledState) {
    if (newLedState) {
      myPort.write('1'); // Envia '1' para ligar o LED
    } else {
      myPort.write('0'); // Envia '0' para desligar o LED
    }
    ledState = newLedState; // Atualiza o estado do LED
  }
}
