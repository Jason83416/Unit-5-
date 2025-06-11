// ==== GAME ====
// Main gameplay loop with background gradient, center line, and beep on paddle hit
void drawGame() {
  // Cool background gradient from navy to teal
  for (int i = 0; i < height; i++) {
    float t = map(i, 0, height, 0, 1);
    stroke(lerpColor(color(10, 10, 30), color(0, 100, 120), t));
    line(0, i, width, i);
  }
  noStroke();

  // Center dashed line
  stroke(255);
  strokeWeight(2);
  for (int y = 0; y < height; y += 20) {
    line(width/2, y, width/2, y + 10);
  }
  noStroke();

  // Scores
  fill(255, 0, 0); 
  textSize(32); 
  text(leftScore, width/4, 50);
  fill(0, 255, 0); 
  text(rightScore, 3 * width/4, 50);

  // Paddles
  fill(255);
  arc(0, leftY, paddleSize, paddleSize, -HALF_PI, HALF_PI);
  arc(width, rightY, paddleSize, paddleSize, HALF_PI, 3 * HALF_PI);

  // Ball
  ellipse(ballX, ballY, ballSize, ballSize);

  // Move ball
  ballX += ballSpeedX;
  ballY += ballSpeedY;

  // Bounce off top/bottom
  if (ballY < ballSize/2 || ballY > height - ballSize/2) {
    ballSpeedY *= -1;
  }

  // Paddle collisions
  if (dist(ballX, ballY, 0, leftY) < paddleSize/2 + ballSize/2) {
    ballSpeedX *= -1;
    ballSpeedX *= speedIncreaseFactor;
    ballSpeedY *= speedIncreaseFactor;
    paddleSize = max(minPaddleSize, paddleSize - paddleShrinkAmount);
    ballX = paddleSize/2 + ballSize/2;
    java.awt.Toolkit.getDefaultToolkit().beep();
  }
  if (dist(ballX, ballY, width, rightY) < paddleSize/2 + ballSize/2) {
    ballSpeedX *= -1;
    ballSpeedX *= speedIncreaseFactor;
    ballSpeedY *= speedIncreaseFactor;
    paddleSize = max(minPaddleSize, paddleSize - paddleShrinkAmount);
    ballX = width - paddleSize/2 - ballSize/2;
    java.awt.Toolkit.getDefaultToolkit().beep();
  }

  // Scoring and reset
  if (ballX < 0) {
    rightScore++;
    if (rightScore >= winningScore) mode = GAMEOVER;
    else resetBall();
  }
  if (ballX > width) {
    leftScore++;
    if (leftScore >= winningScore) mode = GAMEOVER;
    else resetBall();
  }

  // Paddle movement / AI
  if (wPressed) leftY -= 5;
  if (sPressed) leftY += 5;
  if (!singlePlayer) {
    if (upPressed) rightY -= 5;
    if (downPressed) rightY += 5;
  } else {
    if (ballY < rightY) rightY -= 4;
    if (ballY > rightY) rightY += 4;
  }

  // Constrain paddles
  leftY = constrain(leftY, paddleSize/2, height - paddleSize/2);
  rightY = constrain(rightY, paddleSize/2, height - paddleSize/2);
}
