public class Level extends Prop {
  public Level(float x, float y, float tamanho){
    super(x, y, tamanho);
  }
  
  // desenha o level atual e calcula o level atual
  public void draw() {    
    level =  (int) score / 500;
    
    pushMatrix();
    translate(pos.x, pos.y);
    
    textSize(32);
    fill(255, 0, 0);
    text("Level: " + String.valueOf(level), 0, 0);
    
    popMatrix();
  }
}
