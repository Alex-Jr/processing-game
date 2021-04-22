public abstract class Enemy extends Entity{    
  protected PVector direction;
  protected color c;

  public Enemy(float x, float y, float tamanho, float speed) {
    super(x, y, tamanho, speed);
    this.c = color(RNG(0, 255), RNG(0, 255), RNG(0, 255));
    this.direction = new PVector(width, height);
  }
      
  public void draw() {
    fill(c);
        
    pushMatrix();
    
    translate(pos.x, pos.y);
    //rotate(radians(angle));
    
    ellipseMode(CENTER);
       
    ellipse(0, 0, tamanho, tamanho);
    
    popMatrix();
   }
    //<>//
  public boolean checkColission(Entity other) {
    return super.checkColission(other);
  }
}
