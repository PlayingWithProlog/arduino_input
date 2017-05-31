void setup() {
  // initialize serial communication
  Serial.begin(9600);
}

void loop() {
  // read the value of A0, divide by 4 and
  // send it as a byte over the serial connection
  Serial.print("input(");
  Serial.print(analogRead(A0) / 4);
  Serial.print(").");
  Serial.print('\n');
  delay(1000);
}
