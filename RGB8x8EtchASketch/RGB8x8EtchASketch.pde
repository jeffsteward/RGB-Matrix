#include <LedControl.h>

#define PIN_DATAIN 12
#define PIN_CLK 11
#define PIN_LOAD 10

LedControl lc = LedControl(PIN_DATAIN, PIN_CLK, PIN_LOAD, 1);

int xValueRaw = 0;      //value read directly from the pot
int xValueOutput = 0;   //value after mapping to the proper range for the matrix     
int yValueRaw = 0;      //value read directly from the pot
int yValueOutput = 0;   //value after mapping to the proper range for the matrix     

void setup() {
  lc.shutdown(0, false);
  lc.setIntensity(0, 15);
  lc.clearDisplay(0);

  Serial.begin(9600);
}

void loop() {
  lc.setLed(0, xValueOutput, yValueOutput, false);
  
  xValueRaw = analogRead(A1);
  xValueOutput = map(xValueRaw, 0, 1023, 0, 7);
  
  yValueRaw = analogRead(A0);
  yValueOutput = map(yValueRaw, 0, 1023, 0, 7);
  
  lc.setLed(0, xValueOutput, yValueOutput, true);
  
}

void cycleLEDs(boolean keepLit) {
  for(int row = 0; row < 8; row++) {
     for(int col = 0; col < 8; col++) {
       delay(190);
       lc.setLed(0, row, col, true);
       if (keepLit == false) {
         delay(100);
         lc.setLed(0, row, col, false);
       }
     }
  }
  lc.clearDisplay(0);
}

void debug() {
  
  Serial.print(xValueRaw);
  Serial.print("\t");
  Serial.println(xValueOutput);
 
  Serial.print(yValueRaw);
  Serial.print("\t");
  Serial.println(yValueOutput);
  
}
