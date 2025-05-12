// Processing Top-Down Shooter
// Continuous fire on 'M'
// Enemies accelerate up to a speed cap
// After score >= 20: more opponents and homing behavior

Player player;
ArrayList<Bullet> bullets;
ArrayList<Enemy> enemies;
int score;
int spawnTimer;
boolean gameOver;

// Continuous-fire control
boolean firing = false;
int fireTimer = 0;
int fireCooldown = 5;  // frames between shots when holding M

void setup() {
  size(800, 600);
  initGame();
  textAlign(LEFT, TOP);
}

void draw() {
  background(30);

  if (gameOver) {
    drawGameOver();
    return;
  }

  // Determine spawn interval and count based on score
  int spawnInterval = (score < 20) ? 60 : 30;
  int spawnCount = (score < 20) ? 1 : 2;
  if (++spawnTimer > spawnInterval) {
    for (int i = 0; i < spawnCount; i++) {
      enemies.add(new Enemy(random(20, width - 20), -20));
    }
    spawnTimer = 0;
  }

  // Update & draw player
  player.update();
  player.display();

  // Continuous fire
  if (firing) {
    if (++fireTimer >= fireCooldown) {
      bullets.add(new Bullet(player.x, player.y - player.size/2));
      fireTimer = 0;
    }
  }

  // Bullets
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    if (b.offscreen()) {
      bullets.remove(i);
    } else {
      b.display();
    }
  }

  // Enemies
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy e = enemies.get(i);
    e.update();
    e.display();

    boolean destroyed = false;
    // Bullet collision
    for (int j = bullets.size() - 1; j >= 0; j--) {
      if (e.hits(bullets.get(j))) {
        bullets.remove(j);
        destroyed = true;
        score++;
        break;
      }
    }
    // Player collision
    if (!destroyed && e.hits(player)) {
      destroyed = true;
      player.health--;
      if (player.health <= 0) {
        gameOver = true;
      }
    }
    if (destroyed || e.offscreen()) {
      enemies.remove(i);
    }
  }

  // HUD
  fill(255);
  textSize(18);
  text("Score: " + score, 10, 10);
  player.drawHealthBar(10, 40, 200, 20);
}

void keyPressed() {
  if (!gameOver) {
    // Single shots
    if (key == ' ' || key == 'z') {
      bullets.add(new Bullet(player.x, player.y - player.size/2));
    }
    // Start continuous fire on M
    if (key == 'm' || key == 'M') {
      firing = true;
      fireTimer = fireCooldown; // immediate shot
    }
    // Movement
    if (keyCode == LEFT  || key == 'a') player.movingLeft  = true;
    if (keyCode == RIGHT || key == 'd') player.movingRight = true;
    if (keyCode == UP    || key == 'w') player.movingUp    = true;
    if (keyCode == DOWN  || key == 's') player.movingDown  = true;
  } else if (key == 'r' || key == 'R') {
    initGame();  // restart on R
  }
}

void keyReleased() {
  if (!gameOver) {
    // Stop continuous fire
    if (key == 'm' || key == 'M') {
      firing = false;
    }
    // Movement
    if (keyCode == LEFT  || key == 'a') player.movingLeft  = false;
    if (keyCode == RIGHT || key == 'd') player.movingRight = false;
    if (keyCode == UP    || key == 'w') player.movingUp    = false;
    if (keyCode == DOWN  || key == 's') player.movingDown  = false;
  }
}

void initGame() {
  player = new Player(width/2, height - 60);
  bullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemy>();
  score = 0;
  spawnTimer = 0;
  gameOver = false;
  firing = false;
  fireTimer = 0;
}

void drawGameOver() {
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(48);
  text("GAME OVER", width/2, height/2 - 30);
  textSize(24);
  fill(255);
  text("Final Score: " + score, width/2, height/2 + 20);
  textSize(16);
  text("Press 'R' to Restart", width/2, height/2 + 60);
}

// --- Player Class ---
class Player {
  float x, y;
  float size = 40;
  float speed = 5;
  int health = 5;
  int maxHealth = 5;
  boolean movingLeft, movingRight, movingUp, movingDown;

  Player(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    if (movingLeft)  x -= speed;
    if (movingRight) x += speed;
    if (movingUp)    y -= speed;
    if (movingDown)  y += speed;
    x = constrain(x, size/2, width - size/2);
    y = constrain(y, size/2, height - size/2);
  }

  void display() {
    fill(0, 150, 255);
    noStroke();
    ellipse(x, y, size, size);
  }

  void drawHealthBar(float px, float py, float w, float h) {
    stroke(255);
    noFill();
    rect(px, py, w, h);
    noStroke();
    fill(255, 0, 0);
    float hw = map(health, 0, maxHealth, 0, w);
    rect(px, py, hw, h);
    fill(255);
    textSize(14);
    text("Health: " + health, px + 5, py + 2);
  }
}

// --- Bullet Class ---
class Bullet {
  float x, y;
  float speed = 8;
  float size = 8;

  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    y -= speed;
  }

  void display() {
    fill(255, 255, 0);
    noStroke();
    ellipse(x, y, size, size);
  }

  boolean offscreen() {
    return y < -size;
  }
}

// --- Enemy Class ---
class Enemy {
  float x, y;
  float size = 30;
  float speed = 2;
  float acceleration = 0.05;
  float maxSpeed = 6;

  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    speed = min(speed + acceleration, maxSpeed);
    if (score < 20) {
      // Straight downward
      y += speed;
    } else {
      // Homing behavior
      float angle = atan2(player.y - y, player.x - x);
      x += cos(angle) * speed;
      y += sin(angle) * speed;
    }
  }

  void display() {
    fill(255, 0, 0);
    noStroke();
    rectMode(CENTER);
    rect(x, y, size, size);
  }

  boolean offscreen() {
    return y > height + size;
  }

  boolean hits(Bullet b) {
    return dist(x, y, b.x, b.y) < (size/2 + b.size/2);
  }

  boolean hits(Player p) {
    return dist(x, y, p.x, p.y) < (size/2 + p.size/2);
  }
}
