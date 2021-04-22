public class Seguidor extends Enemy{   
  public Seguidor(int x, int y, int tamanho) {
    super(x, y, tamanho, 3);
  }
  
  public void move() {
   if(
      (pos.x <= direction.x + 25 || pos.x >= direction.x - 25)
      && (pos.y <= direction.y + 25 && pos.y >= direction.y - 25)
    ) {
      direction.x = p.getPosX();
      direction.y = p.getPosY();
    }

   if(pos.x < direction.x) pos.x += speed.x;
   if(pos.x > direction.x) pos.x -= speed.x;
  
   if(pos.y < direction.y) pos.y += speed.y;
   if(pos.y > direction.y) pos.y -= speed.y; 
  }
}
