// ==== MAIN DRAW ====  
void draw() { switch(mode) { case INTRO: introScreen(); break; case GAME: drawGame(); break; case PAUSE: pauseScreen(); break; case GAMEOVER: gameOverScreen(); break; } }
