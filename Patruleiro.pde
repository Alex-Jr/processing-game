public class Patruleiro extends Enemy{   
  public Patruleiro(int x, int y, int tamanho) {
    super(x, y, tamanho, 4);
  }
  
  public void move() {
   if(
      (pos.x <= direction.x + 25 || pos.x >= direction.x - 25)
      && (pos.y <= direction.y + 25 && pos.y >= direction.y - 25)
    ) {
      direction.x = RNG(25, width - 25);
      direction.y = RNG(25, height - 25);
    }

   if(pos.x < direction.x) pos.x += speed.x;
   if(pos.x > direction.x) pos.x -= speed.x;
  
   if(pos.y < direction.y) pos.y += speed.y;
   if(pos.y > direction.y) pos.y -= speed.y; 
  }
}
