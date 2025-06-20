// MOUSE 
void mousePressed() {
  if (mode == GAME)       mode = PAUSE;
  else if (mode == PAUSE) mode = GAME;
  else                    clicked = true;
}

void drawButton(float x, float y, float w, float h, String label, Runnable action) {
  boolean hovered = dist(mouseX, mouseY, x, y) < w/2;
  fill(hovered ? 180 : 100);
  rect(x, y, w, h, 10);
  fill(255);
  textSize(20);
  text(label, x, y);
  if (hovered && clicked) action.run();
}
