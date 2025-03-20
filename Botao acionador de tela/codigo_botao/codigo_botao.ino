int pinoBotao = 2;
int estadoBotao;
int estadoBotaoAnterior = LOW;
unsigned long tempoDebounce = 50; // Tempo para debounce
unsigned long ultimoTempo = 0;

void setup() {
  pinMode(pinoBotao, INPUT);
  Serial.begin(9600);
}

void loop() {
  int leitura = digitalRead(pinoBotao);
  
  // Debounce: só atualiza o estado do botão depois que o tempo de debounce passa
  if (leitura != estadoBotaoAnterior) {
    ultimoTempo = millis(); // Reinicia o tempo de debounce
  }

  if ((millis() - ultimoTempo) > tempoDebounce) {
    if (leitura != estadoBotao) {
      estadoBotao = leitura;
      Serial.println(estadoBotao);  // Envia 1 ou 0 para o Processing
    }
  }

  estadoBotaoAnterior = leitura;
}

