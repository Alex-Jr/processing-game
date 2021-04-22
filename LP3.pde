Player p = new Player(400, 400, 50);

ArrayList<Entity> entities = new ArrayList<Entity>();

boolean [] keys = new boolean[128];

void setup() {
  size(800, 800);
  
  entities.add(p);
  entities.add(new Seguidor(200, 200, 50));
  entities.add(new Patruleiro(200, 200, 50));
}

void draw() { //<>//
  background(0);
  
  for (int i = 0; i < entities.size(); i++) {
      Entity entity = entities.get(i);
      entity.draw();
      entity.move();
      checkColissions(entity, i);
  }
}

void keyPressed() {
  keys[key] = true; //<>//
}

void keyReleased() {
  keys[key] = false;
}

void checkColissions(Entity entity, int index) {
  for (int i = index + 1; i < entities.size(); i++) {
     Entity other = entities.get(i);
     entity.checkColission(other);
  }
}

int RNG(int min,int max) {
   return (int) ((Math.random() * (max - min)) + min);
}
