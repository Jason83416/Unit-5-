// ==== INTRO ====  
// Gradient intro screen
void introScreen() {
  for (int y = 0; y < height; y++) {
    float t = map(y, 0, height, 0, 1);
    stroke(lerpColor(color(255,150,0), color(150,0,255), t));
    line(0, y, width, y);
  }
  noStroke();
  fill(255);
  textSize(32);
  text("Press 1 for One Player", width/2, height/2 - 20);
  text("Press 2 for Two Players", width/2, height/2 + 20);
}
