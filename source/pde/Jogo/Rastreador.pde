public class Rastreador extends Enemy implements MudaCor{   
  public Rastreador(float x, float y, float tamanho, float speed) {
    super(x, y, tamanho, speed, color(0, 255, 0));
  }
  
  public void trocacor() {
    this.c = color(RNG(0, 255), RNG(0, 255), RNG(0, 255));
  }
  
  public void move() {
   // isso significa se vc estiver a 25 unidades da sua direção, pegue a posição atual do jogador como nova direção e troque de cor
   if(
      (pos.x > direction.x - 25 && pos.x < direction.x + 25)
      && (pos.y > direction.y - 25 && pos.y < direction.y + 25)
    ) {
      direction.x = p.getPosX();
      direction.y = p.getPosY();
      this.trocacor();
    }

   if(pos.x < direction.x) pos.x += speed.x;
   if(pos.x > direction.x) pos.x -= speed.x;
  
   if(pos.y < direction.y) pos.y += speed.y;
   if(pos.y > direction.y) pos.y -= speed.y; 
  }
}
