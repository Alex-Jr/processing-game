public class Patruleiro extends Enemy{   
  public Patruleiro(float x, float y, float tamanho, float speed) {
    super(x, y, tamanho, speed, color(255, 0, 255));
  }
  
  public void move() {
    // isso significa se vc estiver a 25 unidades da sua direção, pegue uma nova direção aleatória
   if(
      (pos.x < direction.x + 25 && pos.x > direction.x - 25)
      && (pos.y < direction.y + 25 && pos.y > direction.y - 25)
    ) {
      direction.x = RNG(5, width - 5);
      direction.y = RNG(5, height - 5);
    }

   if(pos.x < direction.x) pos.x += speed.x;
   if(pos.x > direction.x) pos.x -= speed.x;
  
   if(pos.y < direction.y) pos.y += speed.y;
   if(pos.y > direction.y) pos.y -= speed.y; 
  }
}
