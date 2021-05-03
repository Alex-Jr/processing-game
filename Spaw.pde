public class Spawn extends Prop {
  int quantidade;

  public Spawn(float x, float y, float tamanho){
    super(x, y, tamanho);
  }
  
  // realiza algumas contas com rng para saber se vai invocar um novo inimigo
  // onde vai invocar
  // tamanho
  // velocidade
  // qual inimigo
  // sabe quando aumentar a dificuldade do jogo através do level atual: ex: level 0 = 100%; level 1 = 102%:
  public void draw() { // teoricamente não desenha algo na tela, mas adiciona um novo inimigo para ser desenhado no prox frame - draw não é um bom nome
    int spawnRng = RNG(0, 100);
    float difficulty = (log(level + 1) / log(999999999999999f)) + 1; // log(0) = indefinido
    
    if(spawnRng * difficulty < 99 ) return; // parece pouco, mas lembre que "DRAW" é chamado a cada frame
      
    int enemyRng = RNG(0, 100);
    
    float xRng = RNG(50, 750);  
    
    float yRng = RNG(50, 750);
    
    float tamanhoRng = RNG(40, 60);
   
    if(xRng == p.getPosX()) xRng = p.getTamanho() * 2;
     
    if(yRng == p.getPosY()) yRng = p.getTamanho() * 2;
    
    
    if (enemyRng< 25) {
      //
    } else if(enemyRng < 50) {
      entities.add(new Patruleiro(xRng, yRng, tamanhoRng, 4 * difficulty));
    } else if(enemyRng < 75) {
      entities.add(new Rastreador(xRng, yRng, tamanhoRng, 2 * difficulty));
    } else if(enemyRng < 97) {
      entities.add(new PatruleiroExpansor(xRng, yRng, tamanhoRng, 4 * difficulty));
    } else if(enemyRng < 98) {
      entities.add(new Seguidor(xRng, yRng, tamanhoRng, 3 * difficulty));
    }
  }
}
