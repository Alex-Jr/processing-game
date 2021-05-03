public class Player extends Entity implements MudaCor {
  private boolean invuneravel;
  private long invuneravelStartTime;
  
  public Player(float x, float y, float tamanho) {
   super(x, y, tamanho, 5f); 
   this.time = Times.ALIADOS;
   this.name = "Player";
  }
  
  public void draw() {
    // player pisca durante invuneravel
    if(invuneravel) {
      this.trocacor();
    } else {
      fill(255, 255, 255); 
    }

    pushMatrix();
    
    translate(this.pos.x, this.pos.y);
    rotate(radians(this.angle));
    
    rectMode(CENTER);
    
    rect(0, 0, this.tamanho, this.tamanho);
    
    fill(20, 20, 20);
    
    rect(this.tamanho / 2, -15, 7, 7); // pequeno olho
    
    rect(this.tamanho / 2, 15, 7, 7); // pequeno olho
    
    //rect(this.tamanho/ 2, 0, 20, 5);
    
    popMatrix();
  }
  
  // como keys é um array de boolean com 128 posições
  // ao utilizar keys['a'] eu verifico se o valor "true" está no array na posição numérica equivalente a letra 'a'
  // isso me permite verificar se várias teclas estão pressionadas ao mesmo tempo :)
  public void move() {
    // move left 
    if (keys['a']) pos.x -= speed.x;
    // move right
    if (keys['d']) pos.x += speed.x;
    // move up
    if (keys['w']) pos.y -= speed.y;
    // move down
    if (keys['s']) pos.y += speed.y;
    // clockwise
    if (keys['e']) angle += 2;
    // counterlockwise
    if (keys['q']) angle -= 2;
    
    // permite que o player se teletransporte
    // ISSO É BEM IMPORTANTE POIS QUALQUER OBJETO COM POS.X MENOR QUE 0 OU MAIOR QUE WIDHT (MESMO PARA ALTURA) SERÁ DELETADO
    if(pos.x < 0) pos.x += width;
    if(pos.x > width) pos.x = 0;
    if(pos.y < 0) pos.y += height;
    if(pos.y > height) pos.y = 0;
  }
    
  public boolean checkCollision(Entity other) {
    boolean colidiu = super.checkCollision(other);
    
    if(!colidiu) return false; // parece bobo, mas isso evita fazer outra operações

    if(this.invuneravel) return false; // mesmo acima
    
    invuneravelStartTime = System.currentTimeMillis();
    this.invuneravel = true;
    
    lives = lives - 1;
    
    return true;
  }
  
  public void clock() {
    super.clock();
   
     
    if(!this.invuneravel) return;
    // A CADA CLOCK ISSO VERIFICA SE JA PASSOU 3 SEGUNDOS DESDE QUE O PLAYER FICOU INVUNERAVEL
    long currentTime = System.currentTimeMillis();
    if(currentTime >= (3 * 1000 + invuneravelStartTime)) this.invuneravel = false;
  }
  
  // troca de cor a cada 5 frames
  public void trocacor() {
    if(frame % 5 == 0) {
      fill(0, 0, 0);
    } else {
      fill(255, 255, 255);
    }
  }
}
