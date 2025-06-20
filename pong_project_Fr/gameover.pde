// GAME OVER 
void drawGameOver() {
  textSize(40);
  fill(255);
  if (leftScore > rightScore) {
    text("Left Player Wins!", width/2, height/2 - 40);
  } else {
    text("Right Player Wins!", width/2, height/2 - 40);
  }
  drawButton(width/2, height/2 + 40, 200, 50, "Back to Menu", () -> {
    mode = INTRO;
    resetGame();
  });
}
