int lp = 7, ln = 6, rp = 8, rn = 9, cp = 4, cn = 5;
int i;
byte command = 'z', num = 0;
boolean isrunning = false;
long interval = 0, start = 0;

void setup()
{
  Serial.begin(9600);
  delay(500);
  for (i=4; i <= 9; i++)
  {
    pinMode(i, OUTPUT);
  }
}

void forward()
{
  digitalWrite(lp, HIGH);
  digitalWrite(rp, HIGH);
  
  digitalWrite(ln, LOW);
  digitalWrite(rn, LOW);
}

void backward()
{
  digitalWrite(lp, LOW);
  digitalWrite(rp, LOW);
  
  digitalWrite(ln, HIGH);
  digitalWrite(rn, HIGH);
}
  
void left()
{
  digitalWrite(lp, LOW);
  digitalWrite(rp, HIGH);
  
  digitalWrite(ln, HIGH);
  digitalWrite(rn, LOW);
}

void right()
{
  digitalWrite(lp, HIGH);
  digitalWrite(rp, LOW);
  
  digitalWrite(ln, LOW);
  digitalWrite(rn, HIGH);
}

void still()
{
  digitalWrite(lp, LOW);
  digitalWrite(rp, LOW);
  
  digitalWrite(ln, LOW);
  digitalWrite(rn, LOW);
  
  digitalWrite(cp, LOW);
  digitalWrite(cn, LOW);
}

void open_claw()
{
  digitalWrite(cp, HIGH);
  digitalWrite(cn, LOW);
}

void close_claw()
{
  digitalWrite(cp, LOW);
  digitalWrite(cn, HIGH);
}

void loop()
{
  if(Serial.available() > 0)
  {
    command = Serial.read(); Serial.println(command); delay(7); num = Serial.read(); //Serial.flush();
  }
  else {command = 'y'; num = 0;}
    
  if (isrunning == false)
  {
    switch(command)
    {
      case 'w' : {forward(); isrunning = true; start = millis(); interval = 1000 * num; break;}
      case 'a' : {left(); isrunning = true; start = millis(); interval = num * 15 ; break;}
      case 'd' : {right(); isrunning = true; start = millis(); interval = num * 15; break;}
      case 'o' : {open_claw(); isrunning = true; start = millis(); interval = 3000; break;}
      case 'c' : {close_claw(); isrunning = true; start = millis(); interval = 3000; break;}
    }
    num = 0;
    //delay(1800);
    //Serial.flush();
  }
  else if (command == 'x' || millis() - start > interval)
  {
    still(); isrunning = false; delay(2300); Serial.flush();
  }
  
  if (!isrunning) Serial.write('?');
}
