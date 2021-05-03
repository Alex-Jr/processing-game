public class Bullet extends Entity {
  private float angle;
  
  // balas precisam de time para evitar colisões desnecessárias
  public Bullet(float x, float y, float angle, Times time) {
    super(x, y, 5, 5);
 
    this.angle = angle;
    this.time = time;
    this.name = "Bullet";
  }
  
  
  public void move() {
    float rad = angle / 180 * PI; 
    pos.x = pos.x + (cos(rad) * speed.x); // trigonometria básica para saber o movimento da bullet
    pos.y = pos.y + (sin(rad) * speed.y);
  }
  
  
  public void draw() { //<>// //<>//
    fill(255);
    
    pushMatrix();
    
    translate(this.pos.x, this.pos.y);      
    
    rotate(radians(this.angle));
    
    rectMode(CENTER);
    
    rect(0, 0, this.tamanho, this.tamanho);

    popMatrix();
  }
  
}
