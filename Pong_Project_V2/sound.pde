// ==== SOUNDS ====  
// Use system beep on paddle hit (no external library needed)

void setup() {
  size(800, 600);
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);

  resetGame();
  mode = INTRO;
}

void resetGame() {
  leftScore = 0;
  rightScore = 0;
  paddleSize = initialPaddleSize;
  leftY = height/2;
  rightY = height/2;
  resetBall();
  mode = INTRO;
}

void resetBall() {
  ballX = width/2;
  ballY = height/2;
  float angle = random(-PI/4, PI/4);
  ballSpeedX = 5 * (random(1) < 0.5 ? -1 : 1) * cos(angle);
  ballSpeedY = 5 * sin(angle);
}
