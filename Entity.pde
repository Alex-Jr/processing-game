public abstract class Entity { 
  protected PVector pos;
  protected PVector speed;
  protected float angle;
  protected float tamanho;
  
  public Entity(float x, float y, float tamanho) {
    this.pos = new PVector(x, y);
    this.speed = new PVector(0, 0);
    this.tamanho = tamanho;
    this.angle = 0;
  }
  
  public Entity(float x, float y, float tamanho, float speed) {
    this.pos = new PVector(x, y);
    this.speed = new PVector(speed, speed);
    this.tamanho = tamanho;
    this.angle = 0;
  }
  
  public float getPosX() {
    return this.pos.x;
  };
  
  public void setPosX(float x) {
    this.pos.x = x;
  }
  
  public float getPosY() {
    return this.pos.y;
  };
  
  public void setPosY(float y) {
    this.pos.y = y;
  }
  
  public float getTamanho() {
    return this.tamanho;
  };
  
  public void setTamanho(float tamanho) {
    this.tamanho = tamanho;
  }
  
  public abstract void draw();
  
  public abstract void move(); 
  
  public boolean checkColission(Entity other) {
    return dist(pos.x, pos.y, other.getPosX(), other.getPosY()) < tamanho;
  };
}
