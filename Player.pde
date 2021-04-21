public class Player {
  PVector pos, speed;
  float angle;
  int tamanho;


  public Player(int x, int y, int tamanho) {
    this.pos = new PVector(x, y);
    this.speed = new PVector(5, 5);
    this.tamanho = tamanho;
    this.angle = 0;
  }

  public void move() {
    // move left 
    if (keys['a']) pos.x -= speed.x;
    // move right
    if (keys['d']) pos.x += speed.x;
    // move up
    if (keys['w']) pos.y -= speed.y;
    // move down
    if (keys['s']) pos.y += speed.y;
    // clockwise
    if (keys['e']) angle ++;
    // counterlockwise
    if (keys['q']) angle --;
    
    if(pos.x < 0) pos.x += width;
    if(pos.x > width) pos.x += 0;
    if(pos.y < 0) pos.x += height;
    if(pos.x > height) pos.x += 0;
  }

  public void draw() {
    fill(255);
    
    //pos.x = constrain(pos.x, 25, width - 25);
    //pos.x = constrain(pos.y, 25, height - 25);
    
    pushMatrix();
    
    translate(pos.x, pos.y);
    rotate(radians(angle));
    
    rectMode(CENTER);
    
    rect(0, 0, tamanho, tamanho);
    
    popMatrix();
  }
}
