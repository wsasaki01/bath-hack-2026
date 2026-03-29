// Basic D-Pad Code

int leftButtonPin = 1;
int leftButtonRead;

int downButtonPin = 2;
int downButtonRead;

int upButtonPin = 3;
int upButtonRead;

int rightButtonPin = 4;
int rightButtonRead;

int delayTime=50;

void setup() {
  // put your setup code here, to run once:
  
  pinMode(leftButtonPin, INPUT_PULLUP);
  pinMode(downButtonPin, INPUT_PULLUP);
  pinMode(upButtonPin, INPUT_PULLUP);
  pinMode(rightButtonPin, INPUT_PULLUP);

  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
leftButtonRead=digitalRead(leftButtonPin);
downButtonRead=digitalRead(downButtonPin);
upButtonRead=digitalRead(upButtonPin);
rightButtonRead=digitalRead(rightButtonPin);

int left; int down; int up; int right;
int upleft; int downleft; int upright; int downright;

if (leftButtonPin == HIGH ) {
  left = 1;
}
if (downButtonPin == HIGH ) {
  down = 1;
}
if (upButtonPin == HIGH ) {
  up = 1;
}
if (rightButtonPin == HIGH ) {
  right = 1;
}

if (leftButtonPin == HIGH && downButtonPin == HIGH) {
  downleft = 1;
}

if (leftButtonPin == HIGH && upButtonPin == HIGH) {
  upleft = 1;
}

if (rightButtonPin == HIGH && downButtonPin == HIGH) {
  downright = 1;
}

if (rightButtonPin == HIGH && upButtonPin == HIGH) {
  upright = 1;
}

Serial.println(leftButtonRead);
Serial.println(downButtonRead);

delay(delayTime);
}
