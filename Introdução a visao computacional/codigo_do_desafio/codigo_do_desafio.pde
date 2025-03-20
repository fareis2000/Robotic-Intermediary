// Função chamada uma única vez no início para configurar a tela
void setup() {
  size(500, 400);         // Define o tamanho da tela para 500x400 pixels
  background(255);        // Define o fundo da tela como branco
}

// Função que é executada continuamente em um loop
void draw() {

  // Desenha o rosto (um círculo azul)
  fill(14, 75, 171);      // Define a cor de preenchimento como azul
  ellipse(250, 200, 300, 300);  // Desenha um círculo no centro da tela com largura e altura de 300

  // Desenha as sobrancelhas
  stroke(0);              // Define a cor da borda como preta
  fill(0);                // Define a cor de preenchimento como preta
  rect(130, 140, 70, 10); // Desenha a sobrancelha esquerda (retângulo preto)
  rect(300, 140, 70, 10); // Desenha a sobrancelha direita (retângulo preto)

  // Desenha o nariz
  stroke(255);            // Define a cor da borda como branca
  fill(14, 75, 1714);     // Define uma cor (valor incorreto, mas azul por padrão)
  rect(245, 200, 10, 30); // Desenha o nariz (pequeno retângulo azul)

  // Define as coordenadas iniciais dos olhos
  int augeLW = 175, augeLH = 200, augeRW = 330, augeRH = 200; // Coordenadas dos olhos
  int pupileLW = augeLW, pupileLH, pupileRW, pupileRH;       // Coordenadas iniciais das pupilas
  int mundH = 275; // Altura inicial da boca

  // Verifica se o mouse está pressionado para desenhar os olhos
  if (mousePressed) {
    stroke(0, 0, 0);      // Define a borda como preta
    fill(0, 0, 0);        // Define o preenchimento como preto
    ellipse(175, 200, 70, 70);  // Desenha o olho esquerdo todo preto
    ellipse(330, 200, 70, 70);  // Desenha o olho direito todo preto
  } else {
    stroke(0, 0, 0);      // Define a borda como preta
    fill(255);            // Define o preenchimento como branco
    ellipse(augeLW, augeLH, 70, 70); // Desenha o contorno do olho esquerdo
    ellipse(augeRW, augeRH, 70, 70); // Desenha o contorno do olho direito
  }

  // Controla o movimento da pupila esquerda baseado na posição do mouse
  if (mouseX < 155) {
    pupileLW = 155; // Limita a pupila esquerda na extremidade esquerda
  } else if (mouseX > 195) {
    pupileLW = 195; // Limita a pupila esquerda na extremidade direita
  } else {
    pupileLW = mouseX; // Segue o mouse no eixo X dentro do limite
  }

  if (mouseY < 180) {
    pupileLH = 180; // Limita a pupila esquerda na parte superior
  } else if (mouseY > 220) {
    pupileLH = 220; // Limita a pupila esquerda na parte inferior
  } else {
    pupileLH = mouseY; // Segue o mouse no eixo Y dentro do limite
  }
  ellipse(pupileLW, pupileLH, 30, 30); // Desenha a pupila esquerda

  // Controla o movimento da pupila direita baseado na posição do mouse
  if (mouseX < 310) {
    pupileRW = 310; // Limita a pupila direita na extremidade esquerda
  } else if (mouseX > 350) {
    pupileRW = 350; // Limita a pupila direita na extremidade direita
  } else {
    pupileRW = mouseX; // Segue o mouse no eixo X dentro do limite
  }

  if (mouseY < 180) {
    pupileRH = 180; // Limita a pupila direita na parte superior
  } else if (mouseY > 220) {
    pupileRH = 220; // Limita a pupila direita na parte inferior
  } else {
    pupileRH = mouseY; // Segue o mouse no eixo Y dentro do limite
  }
  fill(0); // Define a cor de preenchimento como preta
  ellipse(pupileRW, pupileRH, 30, 30); // Desenha a pupila direita

  // Controla a altura da boca com base na posição vertical do mouse
  if (mouseY < 275) {
    mundH = 0; // Boca fechada se o mouse estiver acima da boca
  } else if (mouseY > 325) {
    mundH = 50; // Boca aberta ao máximo se o mouse estiver muito abaixo
  } else {
    mundH = mouseY - 275; // Ajusta a altura da boca proporcionalmente
  }
  fill(251, 0, 0); // Define a cor da boca como vermelho
  rect(200, 275, 100, mundH); // Desenha a boca com a altura definida
}
