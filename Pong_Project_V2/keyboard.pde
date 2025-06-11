// ==== KEYBOARD ====  
void keyPressed() {
  if (mode==INTRO) { if (key=='1') { singlePlayer=true; mode=GAME; } if (key=='2') { singlePlayer=false; mode=GAME; } }
  else if (mode==GAME) { if (key=='w'||key=='W') wPressed=true; if (key=='s'||key=='S') sPressed=true; if (key=='p'||key=='P') mode=PAUSE; if (!singlePlayer) { if (keyCode==UP) upPressed=true; if (keyCode==DOWN) downPressed=true; } }
  else if (mode==PAUSE) { if (key=='p'||key=='P') mode=GAME; }
}
void keyReleased() {
  if (mode==GAME) { if (key=='w'||key=='W') wPressed=false; if (key=='s'||key=='S') sPressed=false; if (!singlePlayer) { if (keyCode==UP) upPressed=false; if (keyCode==DOWN) downPressed=false; } }
}
