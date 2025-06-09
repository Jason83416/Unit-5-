//Jason Zhao
//Pong

color lightpurple = #BF9A82;
color brown       = #45201E;
color pink        = #FF0F53;
color green       = #558A67;

//mode framework
int mode;
final int INTRO    = 1;
final int GAME     = 2;
final int PAUSE    = 3;
final int GAMEOVER = 4;

//entity variables
float leftx, lefty, leftd, rightx, righty, rightd; //paddles
float ballx, bally, balld; //ball
float vx, vy;
boolean AI;

//scoring
int leftscore, rightscore, timer;

//keyboard variables 
boolean wkey, skey, upkey, downkey;

//intro screen 
float angle = 0;


void setup() {
  noStroke();
  size(800, 600);
  mode = INTRO;
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  
  reset();
  
  //initialize paddles 
  leftx = 0;
  lefty = height/2;
  leftd = 200;
  
  rightx = width;
  righty = height/2;
  rightd = 200;
  
  //initialize ball
  ballx = width/2;
  bally = height/2;
  balld = 100;
  
  //initialize keyboard variables 
  wkey = skey = upkey = downkey = false;
  
}

void draw() {
  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == PAUSE) {
    pause();
  } else if (mode == GAMEOVER) {
    gameover();
  } else {
    println("Mode error:" + mode);
  }
}
