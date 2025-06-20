// INTRO 
void drawIntro() {
  textSize(40);
  text("PONG - Select Mode", width/2, height/4);
  drawButton(width/2, height/2 - 40, 200, 50, "1 Player", () -> {
    singlePlayer = true;
    startGame();
  });
  drawButton(width/2, height/2 + 40, 200, 50, "2 Player", () -> {
    singlePlayer = false;
    startGame();
  });
}
