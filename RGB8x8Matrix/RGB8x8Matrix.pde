#include <LedControl.h>

#define PIN_DATAIN 12
#define PIN_CLK 11
#define PIN_LOAD 10

LedControl lc = LedControl(PIN_DATAIN, PIN_CLK, PIN_LOAD, 1);

void setup() {
  lc.shutdown(0, false);
  lc.setIntensity(0, 15);
  lc.clearDisplay(0);
}

void loop() {
  cycleLEDs(false);
  cycleLEDs(true);
  cycleRows();
  cycleColumns();
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

void cycleRows() {
  for(int row = 0; row < 8; row++) {
    lc.setRow(0, row, B11111111);
    delay(100);
    lc.setRow(0, row, B00000000);
    delay(100);
  }  
}

void cycleColumns() {
  for(int col = 0; col < 8; col++) {
    lc.setColumn(0, col, B11111111);
    delay(100);
    lc.setColumn(0, col, B00000000);
    delay(100);
  }
}


