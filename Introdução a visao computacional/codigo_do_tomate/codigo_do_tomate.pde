void setup() {
  size(800, 640); // Define o tamanho da janela gráfica: 800 pixels de largura por 640 pixels de altura.
  background(216, 230, 245); // Define a cor de fundo inicial da janela como um azul claro (RGB: 216, 230, 245).
  noStroke(); // Remove o contorno (stroke) das formas geométricas.
}

void draw() {
    background(216, 230, 245); // Redefine a cor de fundo a cada frame para evitar rastros de desenhos anteriores.
    
    fill(255, 230, 245); // Define a cor de preenchimento como rosada (RGB: 255, 230, 245).
    ellipse(400, 200, 200, 160); // Desenha uma elipse em (400, 200) com largura 200 e altura 160.

    fill(34, 139, 34); // Define a cor de preenchimento como verde escuro (RGB: 34, 139, 34).
    triangle(370, 140, 400, 100, 430, 140); // Desenha um triângulo maior formando a parte superior da copa da árvore.
    triangle(400, 130, 380, 110, 420, 110); // Adiciona um triângulo menor no topo central da copa.
    triangle(380, 140, 370, 120, 390, 110); // Adiciona um triângulo na lateral esquerda da copa.
    triangle(420, 140, 430, 120, 410, 110); // Adiciona um triângulo na lateral direita da copa.

    rectMode(CENTER); // Define que o ponto de referência dos retângulos será o centro (em vez do canto superior esquerdo).
    rect(400, 150, 10 , 30); // Desenha o tronco da árvore como um retângulo em (400, 150), com largura 10 e altura 30.
}
