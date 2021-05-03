public class Score extends Prop {
  private int count;

  public Score(float x, float y, float tamanho){
    super(x, y, tamanho);
  }
  
  
  // desenha e aumenta a contagem  SCORE a cada 5 frame
  public void draw() {    
    this.count += 1; // como PROP não tem clock, utiliza um contador exclusivo
    if(this.count == 5) {
      this.count = 0;
      score += 1;
    }

    pushMatrix();
    translate(pos.x, pos.y);
    
    textSize(32);
    fill(255, 0, 0);
    text("Score: " + String.valueOf(score), 0, 0);
    
    popMatrix();
  }
}
