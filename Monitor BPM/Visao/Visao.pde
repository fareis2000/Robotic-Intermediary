import processing.serial.*;

Serial myPort;
float[] ecg = new float[500]; // buffer do sinal
int index = 0;

void setup() {
  size(800, 400);
  myPort = new Serial(this, "COM6", 9600); // ajuste a porta correta
  myPort.bufferUntil('\n'); // <-- Corrigido
  background(0);
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  noFill();
  beginShape();
  for (int i = 0; i < ecg.length; i++) {
    float y = map(ecg[i], 0, 1023, height, 0); 
    vertex(i * (width / float(ecg.length)), y);
  }
  endShape();
}

void serialEvent(Serial myPort) {
  String inString = trim(myPort.readStringUntil('\n')); // lê até quebra de linha
  if (inString != null) {
    println(inString); // debug: mostra no console
    if (inString.matches("\\d+")) { // só aceita números
      float val = float(inString);
      ecg[index] = val;
      index = (index + 1) % ecg.length;
    }
  }
}
