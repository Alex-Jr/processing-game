public abstract class Entity { 
  protected PVector pos; // PVector deixa mais limpo o código, é usado como pos.x e pos.y
  protected PVector speed;
  protected float angle;
  protected float tamanho;
  protected int frame;
  protected String name; // para facilitar debug
  protected Times time; // 0 = ALIADOS; 1 = INIMIGOS; 2 NEUTROS;
    
  public Entity(float x, float y, float tamanho, float speed) {
    this.pos = new PVector(x, y);
    this.speed = new PVector(speed, speed);
    this.tamanho = tamanho;
    this.angle = 0;
    this.frame = 0;
  }
  
  // get and set
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
  
  // --
  
  // todas entidades devem implementar draw e move
  public abstract void draw();
  
  public abstract void move(); 
  
  // esse método é útil para fazer ações a  cada x tempos
  public void clock() {
    frame++;
    
    if(frame > 60) {
      frame = 0;
    }
  };
  
  // todas as entidades tem uma verificação básica de colisão
  public boolean checkCollision(Entity other) {
    // essa linha impede membros do próprio time colidirem
    if(this.time.getValue() == other.time.getValue()) return false;
    
    // tamanho é usado como "tamanho vertical/horizontal" então é necessário dividir por 2
    return dist(pos.x, pos.y, other.getPosX(), other.getPosY()) < tamanho / 2;
  };
}
