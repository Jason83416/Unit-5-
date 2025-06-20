// Jason Zhao 
//Pong Game


import ddf.minim.*;

// GENERAL 
Minim minim;
AudioPlayer bounceSound;

// Game modes
int mode;
final int INTRO    = 0;
final int GAME     = 1;
final int PAUSE    = 2;
final int GAMEOVER = 3;

// Scores
int leftScore    = 0;
int rightScore   = 0;
int winningScore = 3;

// Paddles
float paddleRadius       = 60;  
final float minPaddleRadius    = 30;
final float paddleShrinkAmount = 5;
float leftY, rightY;
float paddleSpeed        = 5;

// Ball
float ballX, ballY;
float ballVX, ballVY;
float ballSize           = 20;

// Control flags
boolean singlePlayer = true;
boolean wPressed      = false;
boolean sPressed      = false;
boolean upPressed     = false;
boolean downPressed   = false;
boolean clicked       = false;

void setup() {
  size(800, 600);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);
  minim = new Minim(this);
  bounceSound = minim.loadFile("beep.mp3");
  resetGame();
  mode = INTRO;
}

void draw() {
  drawBackground();
  fill(255);
  
  switch(mode) {
    case INTRO:     drawIntro();     break;
    case GAME:      drawGame();      break;
    case PAUSE:     drawPause();     break;
    case GAMEOVER:  drawGameOver();  break;
  }
  
  clicked = false;
}

void startGame() {
  resetGame();
  mode = GAME;
}

void resetGame() {
  leftScore    = 0;
  rightScore   = 0;
  leftY        = height/2;
  rightY       = height/2;
  paddleRadius = 60;
  resetBall();
}

void resetBall() {
  ballX = width/2;
  ballY = height/2;
  float angle = random(-PI/4, PI/4);
  ballVX = 5 * cos(angle) * (random(1) > 0.5 ? 1 : -1);
  ballVY = 5 * sin(angle);
}

void drawBackground() {
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    int c = lerpColor(color(10, 10, 40), color(0, 180, 200), inter);
    stroke(c);
    line(0, y, width, y);
  }
  noStroke();
}
