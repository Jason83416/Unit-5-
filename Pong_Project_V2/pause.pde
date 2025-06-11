// ==== PAUSE ====  
void pauseScreen() {
  for (int r = max(width,height); r > 0; r--) {
    float t = map(r,0,max(width,height),0,1);
    noFill(); stroke(0,0,0,200*t); ellipse(width/2,height/2,r,r);
  }
  noStroke(); fill(255); textSize(32);
  text("Game Paused\nPress P to Resume", width/2, height/2);
}
