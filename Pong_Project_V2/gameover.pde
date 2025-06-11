// ==== GAME OVER ====  
void gameOverScreen() {
  stroke(255,50);
  for (int x=-height; x<width; x+=20) line(x,0,x+height,height);
  noStroke(); fill(150,0,0,200); rect(width/2,height/2,width,height);
  fill(255); textSize(32);
  if (leftScore>=winningScore) text("Left Player Wins!",width/2,height/2-20);
  else text("Right Player Wins!",width/2,height/2-20);
  text("Click to Restart", width/2, height/2+20);
}
