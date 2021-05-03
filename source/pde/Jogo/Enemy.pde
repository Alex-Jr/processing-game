public abstract class Enemy extends Entity{    
  protected PVector direction;
  protected color c;
  
  // Todo inimigo nasce com direção inicial aleatória
  
  public Enemy(float x, float y, float tamanho, float speed) {
    super(x, y, tamanho, speed);
    this.c = color(RNG(0, 255), RNG(0, 255), RNG(0, 255));
    this.direction = new PVector(RNG(0, width), RNG(0, height));
    this.time = Times.INIMIGOS;
    this.name = "Enemy";
  }
  
  // para possibilitar passar cor durante a criação
  
  public Enemy(float x, float y, float tamanho, float speed, color c) {
    super(x, y, tamanho, speed);
    this.c = c;
    this.direction = new PVector(RNG(0, width), RNG(0, height));
    this.time = Times.INIMIGOS;
    this.name = "Enemy";
  }
  
  
  // todos os inimigos são esferas    
  public void draw() {
    fill(c);
        
    pushMatrix();
    
    translate(pos.x, pos.y);
    //rotate(radians(angle));
    
    ellipseMode(CENTER);
       
    ellipse(0, 0, tamanho, tamanho);
    
    popMatrix();
   } //<>//
}
