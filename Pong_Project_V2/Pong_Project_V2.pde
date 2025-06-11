// ==== PONG PROJECT ====  
// Globals, settings, setup, reset  

int mode;
final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;
int winningScore = 5;

// Paddle settings
final float initialPaddleSize = 100;
final float minPaddleSize = 40;
final float paddleShrinkAmount = 2;
float paddleSize;
float leftY, rightY;

// Ball settings
float ballX, ballY;
float ballSpeedX, ballSpeedY;
final float ballSize = 20;
final float speedIncreaseFactor = 1.05;

// Scores
int leftScore = 0;
int rightScore = 0;

// Game mode & input
boolean singlePlayer = true;
boolean wPressed = false, sPressed = false, upPressed = false, downPressed = false;
