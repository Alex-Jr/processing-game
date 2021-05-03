public abstract class Prop { 
  protected PVector pos;
  protected float tamanho;
  
  public Prop(float x, float y, float tamanho) {
    this.pos = new PVector(x, y);
    this.tamanho = tamanho;
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
  
  // ---
  
  
  // prop não se mexem, só são desenhados na tela
  public abstract void draw();  
}
