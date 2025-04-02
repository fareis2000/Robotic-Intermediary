import processing.serial.*;

Serial myPort;

String angle = "";
String distance = "";
String data = "";
String noObject;

float pixsDistance;
int iAngle = 0, iDistance = 0;  // Inicializa as variáveis corretamente
int index1 = 0;
int index2 = 0;
PFont orcFont;

void setup() {
  size(1366, 700);
  smooth();
  
  println(Serial.list()); // Lista as portas disponíveis
  myPort = new Serial(this, "COM5", 9600);  // Verifique se a COM5 está correta!
}

void draw() {
  background(0);  // Fundo preto
  fill(98, 245, 31);
  noStroke();
  fill(0, 4);
  rect(0, 0, width, 1010);
  fill(98, 245, 31);
  drawRadar();
  drawLine();
  drawObject();
  drawText();
}

void serialEvent(Serial myPort) {
  String data = myPort.readStringUntil('\n');  // Lê até encontrar uma nova linha
  if (data != null) {
    data = trim(data);
    String[] values = data.split("\\.");  // Divide os valores pelo ponto
    
    if (values.length == 2) {
      try {
        iAngle = int(values[0]);    // Converte o primeiro valor para ângulo
        iDistance = int(values[1]); // Converte o segundo valor para distância
        println("Ângulo: " + iAngle + " | Distância: " + iDistance);  // Debug no console
      } catch (Exception e) {
        println("Erro ao converter os valores: " + e.getMessage());
      }
    }
  }
}

void drawRadar() {
  pushMatrix();
  translate(683, 700);
  noFill();
  strokeWeight(2);
  stroke(98, 245, 31);
  arc(0, 0, 1300, 1300, PI, TWO_PI);
  arc(0, 0, 1000, 1000, PI, TWO_PI);
  arc(0, 0, 700, 700, PI, TWO_PI);
  arc(0, 0, 400, 400, PI, TWO_PI);
  line(-700, 0, 700, 0);
  for (int i = 30; i <= 150; i += 30) {
    line(0, 0, -700 * cos(radians(i)), -700 * sin(radians(i)));
  }
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(683, 700);
  strokeWeight(9);
  stroke(255, 10, 10);  // Vermelho para o objeto
  pixsDistance = iDistance * 10;  

  // Desenha a linha do objeto detectado
  line(
    pixsDistance * cos(radians(iAngle)),
    -pixsDistance * sin(radians(iAngle)),
    700 * cos(radians(iAngle)),
    -700 * sin(radians(iAngle))
  );
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30, 250, 60);  // Verde para a linha do radar
  translate(683, 700);
  line(0, 0, 700 * cos(radians(iAngle)), -700 * sin(radians(iAngle)));
  popMatrix();
}

void drawText() {
  pushMatrix();
  if (iDistance > 40) {
    noObject = "Out of Range";
  } else {
    noObject = "In Range";
  }
  fill(0, 0, 0);
  noStroke();
  rect(0, 1010, width, 1080);
  fill(98, 245, 31);
  textSize(25);
  text("10cm", 800, 690);
  text("20cm", 950, 690);
  text("30cm", 1100, 690);
  text("40cm", 1250, 690);
  textSize(40);
  text("Object: " + noObject, 240, 1050);
  text("Angle: " + iAngle + " *", 1050, 1050);
  text("Distance: ", 1380, 1050);
  if (iDistance < 40) {
    text("           " + iDistance + " cm", 1400, 1050);
  }
  textSize(25);
  fill(98, 245, 60);
  popMatrix();
}
