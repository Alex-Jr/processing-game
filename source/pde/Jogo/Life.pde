public class Life extends Prop {

  public Life(float x, float y, float tamanho){
    super(x, y, tamanho);
  }
  
  // desenha os corações
  public void draw() {
    for(int i = 0; i < lives; i++) {   // utiliza a variavel glboal LIVES para saber quantos corações desenhar
      noStroke();
      fill(255, 0, 0);
      
      pushMatrix();
      translate(pos.x + (i * tamanho), pos.y);
      
      beginShape();
      
      vertex(50, 15);
      bezierVertex(50, -5, 90, 5, 50, 40);
      
      vertex(50, 15);
      bezierVertex(50, -5, 10, 5, 50, 40);
  
      endShape();
      
      popMatrix();
    }
    
  }
}
