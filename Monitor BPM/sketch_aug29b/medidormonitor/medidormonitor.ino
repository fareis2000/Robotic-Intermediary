#include <PulseSensorPlayground.h>
#include <LiquidCrystal_I2C.h>
#define USE_ARDUINO_INTERRUPTS true

LiquidCrystal_I2C lcd(0x27, 16, 2);

#define sensor A0
const int limite = 550;
const int Led = 13;

PulseSensorPlayground pulsar;

void setup() {

  Serial.begin(9600);
  lcd.init();
  lcd.backlight();

  pulsar.analogInput(sensor);
  pulsar.blinkOnPulse(Led);
  pulsar.setThreshold(limite);
  
  if(pulsar.begin()){
    Serial.println("Sensor criado com sucesso");
  }
}

void loop() {
  lcd.setCursor(0,0);
  lcd.print("Heart Rate");

  int BPMAtual = pulsar.getBeatsPerMinute();
  int Signal = analogRead(sensor);  // <-- pega o sinal bruto

  // Envia para Processing
  Serial.println(Signal);

  if(pulsar.sawStartOfBeat()){
    Serial.print("BPM: ");
    Serial.println(BPMAtual);

    lcd.clear();
    lcd.setCursor(0, 1);
    lcd.print("BPM: ");
    lcd.print(BPMAtual);
  }
  
  delay(20);
}
