#include <Servo.h>

const int trigPin = 11;
const int echoPin = 10;

long tempo;
int distancia;

Servo servo;

void setup() {
    pinMode(trigPin, OUTPUT);
    pinMode(echoPin, INPUT);
    Serial.begin(9600);
    servo.attach(9);
}

void loop() {
    // Movimento do servo de 15° a 165°
    for (int i = 15; i <= 165; i++) {
        servo.write(i);
        delay(30);
        distancia = calculoDistancia();

        Serial.print(i);
        Serial.print(".");
        Serial.println(distancia);  // 🔴 Mantém o mesmo formato
    }

    // Movimento do servo de 165° a 15°
    for (int i = 165; i >= 15; i--) {
        servo.write(i);
        delay(30);
        distancia = calculoDistancia();

        Serial.print(i);
        Serial.print(".");
        Serial.println(distancia);  // 🔴 Agora está no formato correto!
    }
}

// Função para calcular a distância
int calculoDistancia() {
    digitalWrite(trigPin, LOW);
    delayMicroseconds(2);

    digitalWrite(trigPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);

    tempo = pulseIn(echoPin, HIGH);
    int distanciaCalculada = tempo * 0.034 / 2;

    // Limita a distância para evitar valores errados
    if (distanciaCalculada >= 400 || distanciaCalculada <= 2) {
        return -1; // Retorna -1 para indicar erro na leitura
    }
    return distanciaCalculada;
}
