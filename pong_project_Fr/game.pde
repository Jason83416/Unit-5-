void drawGame() {
  // Draw scores
  textSize(32);
  fill(255);
  text(leftScore, width / 4, 40);
  text(rightScore, 3 * width / 4, 40);

  // Draw center dotted line
  stroke(255);
  for (int y = 0; y < height; y += 20) {
    line(width / 2, y, width / 2, y + 10);
  }
  noStroke();

  // Draw semicircle paddles
  fill(200);
  // Left paddle (flat side right)
  arc(0, leftY, paddleRadius * 2, paddleRadius * 2, -HALF_PI, HALF_PI);

  // Right paddle (flat side left)
  arc(width, rightY, paddleRadius * 2, paddleRadius * 2, PI / 2, 3 * PI / 2);

  // Draw and move ball
  fill(255);
  ellipse(ballX, ballY, ballSize, ballSize);
  ballX += ballVX;
  ballY += ballVY;

  // Bounce on top and bottom walls
  if (ballY < ballSize / 2 || ballY > height - ballSize / 2) {
    ballVY *= -1;
  }

  // Paddle collisions
  boolean hitLeft = dist(ballX, ballY, 0, leftY) <= paddleRadius + ballSize / 2 && ballVX < 0;
  boolean hitRight = dist(ballX, ballY, width, rightY) <= paddleRadius + ballSize / 2 && ballVX > 0;

  if (hitLeft || hitRight) {
    ballVX *= -1;
    if (bounceSound != null) {
      bounceSound.rewind();
      bounceSound.play();
    }
    paddleRadius = max(minPaddleRadius, paddleRadius - paddleShrinkAmount);
  }

  // Scoring
  if (ballX < 0) {
    rightScore++;
    resetBall();
  } else if (ballX > width) {
    leftScore++;
    resetBall();
  }

  if (leftScore >= winningScore || rightScore >= winningScore) {
    mode = GAMEOVER;
  }

  // Paddle movement
  if (wPressed) leftY -= paddleSpeed;
  if (sPressed) leftY += paddleSpeed;

  if (singlePlayer) {
    float threshold = 5;
    float botSpeed = paddleSpeed * 0.85;
    if (ballY > rightY + threshold) {
      rightY += botSpeed;
    } else if (ballY < rightY - threshold) {
      rightY -= botSpeed;
    }
  } else {
    if (upPressed) rightY -= paddleSpeed;
    if (downPressed) rightY += paddleSpeed;
  }

  // Constrain paddles
  leftY = constrain(leftY, paddleRadius, height - paddleRadius);
  rightY = constrain(rightY, paddleRadius, height - paddleRadius);
}
