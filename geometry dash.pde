float X = 50;
float Y = 300;
float pSize = 50;
float grav = 1;
float jump = -15;
float Superjump = -20;
float pV = 0;

float obstakelX = 800;
float obstakelY = 310;
float Width = 40;
float Height = 40;

int score = 0;
float speed = 10;

boolean Over = false;
boolean start = false;
int Cooldown = 5000;
int time = 0;
float clr = 0;

PImage backgroundImage;

void setup() {
  size(800, 400);
  textSize(32);
  colorMode(HSB);
  backgroundImage = loadImage("86yagye25g841.png");
}

void draw() {
  image(backgroundImage, 0, 0, width, height);

  tekenGrond();
  
  if (!start) {
    fill(0);
    text("Press 'Enter' to Start", width / 2 - 150, height / 2);
  } else {
    if (!Over) {
      fill(clr, 255, 255);
      rect(X, Y, pSize, pSize, 28);

      fill(0);
      rect(obstakelX, obstakelY, Width, Height);
      triangle(obstakelX, obstakelY, obstakelX + Width / 2, obstakelY - 20, obstakelX + Width, obstakelY);

      obstakelX -= speed;

      if (obstakelX < -Width) {
        obstakelX = width;
        score++;
        speed = speed + 0.2;
      }

      Y += pV;
      pV += grav;

      if (Y > 300) {
        Y = 300;
        pV = 0;
      }

      if (X + pSize > obstakelX && X < obstakelX + Width && Y + pSize > obstakelY) {
        Over = true;
      }

      fill(255);
      text(score, 650, 30);

      clr += 1;
      if (clr > 255) {
        clr = 0;
      }
    } else {
      fill(50, 0, 0);
      text("Game Over", width / 2 - 100, height / 2);
      text("Total Score: " + score, width / 2 - 100, height / 2 + 50);
    }
  }
}

void tekenGrond(){
  fill(34, 139, 34); 
  rect(0, 350, width, 50); 
}

void keyPressed() {
  if (!start && key == ENTER) {
    start = true;
    Over = false;
  } else if (key == ' ' && Y == 300 && start) {
    pV = jump;
  } else if (key == 'e' && Y == 300 && (millis() - time >= Cooldown) && start) {
    pV = Superjump;
    time = millis();
  }
}
