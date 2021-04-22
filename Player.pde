public class Player extends Entity {
  
  public Player(float x, float y, float tamanho) {
   super(x, y, tamanho, 5f); 
  }
  
  public void draw() {
    fill(255);
    pushMatrix();
    
    translate(this.pos.x, this.pos.y);
    rotate(radians(this.angle));
    
    rectMode(CENTER);
    
    rect(0, 0, this.tamanho, this.tamanho);
    
    popMatrix();
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
    if(pos.x > width) pos.x = 0;
    if(pos.y < 0) pos.y += height;
    if(pos.y > height) pos.y = 0;
  }
  
  
  public boolean checkColission(Entity other) {
    boolean colidiu = super.checkColission(other);
    
    if(colidiu) System.out.print("colidiu");;
    return colidiu; //<>//
  }
}
