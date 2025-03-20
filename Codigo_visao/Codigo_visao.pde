import processing.serial.*;

Serial myPort;  // Objeto para comunicação serial
String val;     // Variável para armazenar a string recebida
int estadoBotao; // Variável para armazenar o estado do botão
boolean botaoPres; // Flag que indica se o botão foi pressionado

void setup() {
    // Listar todas as portas seriais disponíveis
    String[] listaDePortas = Serial.list();
    for (int i = 0; i < listaDePortas.length; i++) {
        println(listaDePortas[i]); // Imprime as portas disponíveis
    }
    
    // Certifique-se de substituir pelo índice correto para a sua porta
    myPort = new Serial(this, "COM7", 9600);  // Modifique o índice conforme necessário
    myPort.bufferUntil('\n'); // Garantir que o Processing só leia quando receber uma linha completa
    size(500, 500);  // Tamanho da tela
    background(0);   // Fundo preto
}

void serialEvent(Serial myPort) {
    // Lê a linha recebida pela porta serial
    val = myPort.readString(); 
    
    if (val != null) {
        val = trim(val);  // Remove espaços em branco extras
        println("Valor recebido: " + val); // Imprime o valor recebido
        
        // Converte para inteiro (1 ou 0) e atualiza o estado do botão
        estadoBotao = int(val);
        botaoPres = (estadoBotao == 1); // Define se o botão está pressionado
    }
}

void draw() {
    // Se o botão estiver pressionado, desenha o círculo verde
    if (botaoPres) {
        fill(0, 255, 0); // Cor verde para o círculo
        ellipse(250, 250, 55, 55); // Desenha o círculo
    } else {
        background(0); // Fundo preto quando o botão não está pressionado
    }
}
