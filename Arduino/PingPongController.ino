
int aX, aY, aZ;
int bX, bY, bZ;

void setup() {
  Serial.begin(9600);
}

void loop() {

  aY = analogRead(A1);
  Serial.print('A');
  Serial.println(aY);
  bY = analogRead(A4);
  Serial.print('B');
  Serial.println(bY);
}
