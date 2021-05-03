public class Instrucoes extends Prop {
  public Instrucoes(float x, float y, float tamanho){
    super(x, y, tamanho);
  }
  
  // simplesmente desenha as instruções na tela
  public void draw() {    
    level =  (int) score / 500;
    
    pushMatrix();
    translate(pos.x, pos.y);
    
    textSize(16);
    fill(255, 0, 0);
    text("WASD - MOVIMENTO", 0, -40);
    text("QE - GIRA", 0, -20);
    text("MOUSE - ATIRA", 0, 0);
    
    popMatrix();
  }
}
