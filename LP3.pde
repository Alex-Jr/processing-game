Player p = new Player(400, 400, 50);

boolean [] keys = new boolean[128];

void setup() {
  size(800, 800);
  
}

void draw() {
  background(0);
  p.draw();
  p.move();
}

void keyPressed() {
  keys[key] = true; //<>//
}

void keyReleased() {
  keys[key] = false;
}
