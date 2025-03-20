import processing.serial.*;

Serial myPort;
char semaforo = 'R'; // Estado inicial do semáforo

void setup() {
  size(300, 500);
  myPort = new Serial(this, "COM5", 9600); // Conecta na porta COM do Arduino
}

void draw() {
  background(50); // Fundo escuro

  // Desenha o semáforo
  fill(30);
  rect(100, 50, 100, 300, 20);

  // Define as cores dos LEDs com base no estado do semáforo
  if (semaforo == 'R') {
    fill(255, 0, 0); // Vermelho aceso
  } else {
    fill(50); // Cinza (apagado)
  }
  ellipse(150, 100, 60, 60); // LED Vermelho

  if (semaforo == 'Y') {
    fill(255, 255, 0); // Amarelo aceso
  } else {
    fill(50);
  }
  ellipse(150, 200, 60, 60); // LED Amarelo

  if (semaforo == 'G') {
    fill(0, 255, 0); // Verde aceso
  } else {
    fill(50);
  }
  ellipse(150, 300, 60, 60); // LED Verde

  // Alterna entre os estados do semáforo
  if (frameCount % 180 == 0) { // Troca a cada 3 segundos (60 FPS * 3)
    if (semaforo == 'R') {
      semaforo = 'G'; // Muda para verde
    } else if (semaforo == 'G') {
      semaforo = 'Y'; // Muda para amarelo
    } else {
      semaforo = 'R'; // Muda para vermelho
    }
    myPort.write(semaforo); // Envia comando para o Arduino
  }
}
