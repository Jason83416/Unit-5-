// KEYBOARD 
void keyPressed() {
  if (key == 'w')       wPressed = true;
  if (key == 's')       sPressed = true;
  if (keyCode == UP)    upPressed   = true;
  if (keyCode == DOWN)  downPressed = true;
}

void keyReleased() {
  if (key == 'w')       wPressed = false;
  if (key == 's')       sPressed = false;
  if (keyCode == UP)    upPressed   = false;
  if (keyCode == DOWN)  downPressed = false;
}
