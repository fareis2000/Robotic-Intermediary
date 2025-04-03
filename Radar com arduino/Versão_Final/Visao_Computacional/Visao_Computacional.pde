// Importa as bibliotecas necessárias para comunicação serial e eventos de teclado
import processing.serial.*; 
import java.awt.event.KeyEvent; 
import java.io.IOException;

// Declara um objeto para a comunicação serial
Serial myPort; 

// Variáveis para armazenar os valores de ângulo e distância recebidos
String angle = "";
String distance = "";
String data = "";
String noObject = "Out of Range"; // Mensagem padrão quando nenhum objeto é detectado
float pixsDistance; // Distância em pixels para exibição no radar
int iAngle = 0, iDistance = 0; // Variáveis inteiras para armazenar ângulo e distância
int index1 = 0; // Variável auxiliar não utilizada neste código
PFont orcFont; // Fonte para exibição de textos (não utilizada no código)

// Configuração inicial do Processing
void setup() {
  size(1366, 700); // Define o tamanho da tela
  smooth(); // Suaviza as bordas dos desenhos
  myPort = new Serial(this, "COM9", 9600); // Configura a porta serial com taxa de transmissão de 9600 bps
  myPort.bufferUntil('\n'); // Aguarda até receber um caractere de nova linha para processar os dados
}

// Função principal de desenho, executada em loop contínuo
void draw() {
  fill(98, 245, 31); // Define a cor verde para os desenhos
  noStroke(); // Remove contornos dos elementos
  fill(0, 4); // Define um fundo escuro transparente
  rect(0, 0, width, 1010); // Desenha o fundo
  
  fill(98, 245, 31); // Define a cor verde novamente
  drawRadar(); // Chama a função para desenhar o radar
  drawLine(); // Chama a função para desenhar a linha do radar
  drawObject(); // Chama a função para desenhar os objetos detectados
  drawText(); // Chama a função para exibir os textos informativos
}

// Função chamada automaticamente sempre que novos dados são recebidos via porta serial
void serialEvent(Serial myPort) { 
  String rawData = myPort.readStringUntil('\n'); // Lê a linha recebida até o caractere de nova linha

  if (rawData != null) { // Verifica se os dados não estão vazios
    rawData = rawData.trim(); // Remove espaços extras no início e fim da string
    String[] values = rawData.split("\\."); // Divide a string pelo caractere ponto (ex: "45.30" -> ["45", "30"])
    
    if (values.length == 2) { // Verifica se foram recebidos dois valores (ângulo e distância)
      try {
        iAngle = int(values[0]); // Converte o primeiro valor para inteiro (ângulo)
        iDistance = int(values[1]); // Converte o segundo valor para inteiro (distância)
        println("Recebido -> Ângulo: " + iAngle + " | Distância: " + iDistance); // Exibe os valores recebidos no console
      } catch (NumberFormatException e) {
        println("Erro ao converter: " + rawData); // Exibe erro caso a conversão falhe
      }
    }
  }
}

// Função para desenhar o radar
void drawRadar() {
  pushMatrix(); // Salva o estado atual da matriz de transformação
  translate(683, 700); // Move o ponto de origem para o centro inferior da tela
  noFill(); // Sem preenchimento
  strokeWeight(2); // Define a espessura das linhas
  stroke(98, 245, 31); // Define a cor verde para as linhas do radar
  
// Desenha um arco (meio círculo) com diâmetro de 1300 pixels.
  // O arco começa em PI (180°) e termina em TWO_PI (360°), formando a metade superior de um círculo.
  arc(0, 0, 1300, 1300, PI, TWO_PI);

  // Desenha um segundo arco menor com diâmetro de 1000 pixels, também representando uma faixa de detecção.
  arc(0, 0, 1000, 1000, PI, TWO_PI);

  // Desenha um terceiro arco com diâmetro de 700 pixels, subdividindo ainda mais a área do radar.
  arc(0, 0, 700, 700, PI, TWO_PI);

  // Desenha o menor arco com diâmetro de 400 pixels, próximo ao centro do radar.
  arc(0, 0, 400, 400, PI, TWO_PI);
  
  // Desenha uma linha horizontal que atravessa o centro do radar, indo de -700 a 700 pixels no eixo X.
  line(-700, 0, 700, 0);

  // Desenha uma linha inclinada a 30° a partir do centro do radar.
  // A posição final é calculada com funções trigonométricas (cosseno e seno) para determinar a coordenada X e Y.
  line(0, 0, -700 * cos(radians(30)), -700 * sin(radians(30)));

  // Desenha uma linha inclinada a 60° a partir do centro do radar.
  line(0, 0, -700 * cos(radians(60)), -700 * sin(radians(60)));

  // Desenha uma linha vertical (90°), que aponta para cima a partir do centro do radar.
  line(0, 0, -700 * cos(radians(90)), -700 * sin(radians(90)));

  // Desenha uma linha inclinada a 120° a partir do centro do radar.
  line(0, 0, -700 * cos(radians(120)), -700 * sin(radians(120)));

  // Desenha uma linha inclinada a 150° a partir do centro do radar.
  line(0, 0, -700 * cos(radians(150)), -700 * sin(radians(150)));
  
  popMatrix(); // Restaura o estado anterior da matriz de transformação
}

// Função para desenhar objetos detectados pelo sensor
void drawObject() {
  pushMatrix(); // Salva a matriz de transformação atual

  // Move o ponto de origem para o centro inferior da tela (posição do radar)
  translate(683, 700); 
  
  strokeWeight(9); // Define a espessura da linha para 9 pixels
  stroke(255, 10, 10); // Define a cor vermelha para indicar objetos detectados

  // Converte a distância recebida do sensor (em cm) para pixels na tela
  pixsDistance = iDistance * 22.5;

  // Verifica se a distância está dentro do alcance esperado (0 cm < iDistance < 40 cm)
  if (iDistance < 40 && iDistance > 0) { 
    // Desenha uma linha do ponto detectado até a borda do radar na direção do ângulo recebido
    line(
      pixsDistance * cos(radians(iAngle)),  // Coordenada X do objeto detectado
      -pixsDistance * sin(radians(iAngle)), // Coordenada Y do objeto detectado
      700 * cos(radians(iAngle)),  // Coordenada X na borda do radar
      -700 * sin(radians(iAngle))  // Coordenada Y na borda do radar
    );
  }
  
  popMatrix(); // Restaura a matriz de transformação original
}


// Função para desenhar a linha de varredura do radar
void drawLine() {
  pushMatrix(); // Salva a matriz de transformação atual

  strokeWeight(9); // Define a espessura da linha como 9 pixels
  stroke(30, 250, 60); // Define a cor da linha como verde brilhante

  // Move o ponto de origem para o centro inferior da tela, onde o radar está localizado
  translate(683, 700); 

  // Desenha a linha de varredura do radar, que se move conforme o ângulo (iAngle)
  line(
    0, 0,                     // Ponto inicial (centro do radar)
    700 * cos(radians(iAngle)),  // Coordenada X da extremidade da linha
    -700 * sin(radians(iAngle))  // Coordenada Y da extremidade da linha (negativo para apontar para cima)
  );

  popMatrix(); // Restaura a matriz de transformação original
}

void drawText() { 
  pushMatrix(); // Salva a matriz de transformação atual

  // Verifica se há um objeto dentro do alcance
  if (iDistance > 40 || iDistance <= 0) {
    noObject = "Out of Range"; // Define como "fora do alcance" se a distância for inválida
  } else {
    noObject = "In Range"; // Define como "dentro do alcance" se o objeto estiver detectado
  }

  fill(0, 0, 0); // Define a cor preta para o fundo do texto
  noStroke(); // Remove contorno
  rect(0, 1010, width, 1080); // Desenha um retângulo preto para exibir informações de leitura

  fill(98, 245, 31); // Define a cor do texto como verde brilhante
  textSize(25); // Define o tamanho da fonte

  // Exibe as marcações de distância na tela
  text("10cm", 800, 690);
  text("20cm", 950, 690);
  text("30cm", 1100, 690);
  text("40cm", 1250, 690);

  textSize(40); // Aumenta o tamanho da fonte para os dados principais

  // Exibe o status do objeto detectado
  text("Object: " + noObject, 240, 1050);

  // Exibe o ângulo atual do radar
  text("Angle: " + iAngle + "°", 1050, 1050);

  // Exibe a distância medida pelo sensor
  text("Distance: ", 1380, 1050);
  
  if (iDistance < 40 && iDistance > 0) { // Se a distância for válida, exibe o valor real
    text("        " + iDistance + " cm", 1400, 1050);
  }

  // Exibe os ângulos no radar para referência visual
  textSize(25); // Define o tamanho da fonte para os ângulos
  fill(98, 245, 60); // Usa um tom de verde mais claro

  // Exibe "30°" no local correto do radar
  translate(390 + 960 * cos(radians(30)), 780 - 960 * sin(radians(30)));
  rotate(-radians(-60)); // Ajusta a rotação do texto
  text("30°", 0, 0);
  resetMatrix(); // Reseta a matriz de transformação

  // Exibe "60°"
  translate(490 + 960 * cos(radians(60)), 920 - 960 * sin(radians(60)));
  rotate(-radians(-30));
  text("60°", 0, 0);
  resetMatrix();

  // Exibe "90°"
  translate(630 + 960 * cos(radians(90)), 990 - 960 * sin(radians(90)));
  rotate(radians(0));
  text("90°", 0, 0);
  resetMatrix();

  // Exibe "120°"
  translate(760 + 960 * cos(radians(120)), 1000 - 960 * sin(radians(120)));
  rotate(radians(-38));
  text("120°", 0, 0);
  resetMatrix();

  // Exibe "150°"
  translate(840 + 900 * cos(radians(150)), 920 - 960 * sin(radians(150)));
  rotate(radians(-60));
  text("150°", 0, 0);

  popMatrix(); // Restaura a matriz de transformação original
}
