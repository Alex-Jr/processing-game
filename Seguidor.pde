public class Seguidor extends Enemy{   
  public Seguidor(float x, float y, float tamanho, float speed) {
    super(x, y, tamanho, speed, color(0, 0, 255));
  }
  
  // sempre ira utilizar a pos atual do jogador como nova direção
  public void move() {
    int x = (int) p.getPosX();
    int y = (int) p.getPosY();
    
    direction.x = RNG(x - 100, x + 100);
    direction.y = RNG(y - 100, y + 100);

   if(pos.x < direction.x) pos.x += speed.x;
   if(pos.x > direction.x) pos.x -= speed.x;
  
   if(pos.y < direction.y) pos.y += speed.y;
   if(pos.y > direction.y) pos.y -= speed.y; 
  }
}
