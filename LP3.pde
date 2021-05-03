Player p = new Player(400, 400, 50); // é mto útil o player ser global

int lives = 3;
int score = 0;
int level = 0;

ArrayList<Entity> entities = new ArrayList<Entity>();
ArrayList<Prop> props = new ArrayList<Prop>();

boolean [] keys = new boolean[128]; // esse array armazena as teclas que estão sendo precionadas no momento

void setup() {
  size(800, 800);
  
  // simplesmente instanciando objetos importantes no setup
  entities.add(p);

  props.add(new Life(15, 15, 50));
  props.add(new Score(600, 750, 50));
  props.add(new Level(600, 50, 50));
  props.add(new Spawn(0, 0, 50));
  props.add(new Instrucoes(15, 750, 50));
}

void draw() { //<>//
  background(0);
  
  // responsável por parar o jogo caso fique sem vidas -- poderia ter uma forma reiniciar aqui
  if(lives <= 0) {
    textSize(32);
    fill(255, 0, 0);
    text("Você morreu", 10, 30);
    return;
  }


  // realiza funções básica de todas as entidades mapeadas no array entities
  // importante notar que a posição da entidade dentro do array funciona como uma espécie de prioridade
  // como o player é o primeiro a ser instânciado, todas suas ações ocorrem primeiro
  // inclusive desenhar, então tudo fica por cima dele lol.
  for (int i = 0; i < entities.size(); i++) {
      Entity entity = entities.get(i);
      
      entity.clock(); // tick interno
      entity.move(); // movimento
      entity.draw(); // desenho
      
      // essas linha apaga entidade que sair da tela por exemplo: balas
      if(entity.getPosX() < 0 || entity.getPosX() > width || entity.getPosY() < 0 || entity.getPosY() > height) entities.remove(i);
      
      // deixar essa função aqui evita verificar colisões desnecessárias
      // por exemplo, se 0 colidiu com 1, obrigatóriamente 1 colidiu com 0 (logo não verificamos o segundo caso)
      // pq checkColissions sempre verifica com oq está a frente no array:)
      checkCollisions(entity, i);
      // por isso, teoricamente falando o jogador colide com inimigos, mas nunca um inimigo colide com um jogador : )
  }
  
  // mesma questão de prioridade, PROPS SÂO DESENHADOS POR CIMA DE TODAS AS ENTIDADES
  for (int i = 0; i < props.size(); i++) {
      Prop prop = props.get(i);
      prop.draw();
  }
}


void mousePressed(){
  entities.add(new Bullet(p.getPosX(), p.getPosY(), p.angle, Times.ALIADOS));
}

void keyPressed() {
  int keyNumber = key;
  if(keyNumber > 127) {
    return;
  }
  keys[key] = true;
}

void keyReleased() {
  int keyNumber = key;
  if(keyNumber > 127) {
    return;
  }
  keys[key] = false;
}

void addScore(int v) {
  score += v;
}

// checa se a entidade passada colidiu com alguma outra entidade
void checkCollisions(Entity entity, int index) { // passar o index além da entidade permite achar no array mais facilmente
  for (int i = index + 1; i < entities.size(); i++) {
     Entity other = entities.get(i);
     boolean colidiu = entity.checkCollision(other);
          
     // apaga tudo que colidiu
     if(colidiu)  {
       addScore(50); //<>//
       entities.remove(i); // i é sempre "other" entity
       if(entity != p) entities.remove(index); // index é a entidade atual, por isso precisamos verificar para não apagar o player
     }
  }
}

// simples gerador de números aleatórios
int RNG(int min, int max) {
   return (int) ((Math.random() * (max - min)) + min);
}
