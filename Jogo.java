import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Jogo extends PApplet {

Player p = new Player(400, 400, 50); // é mto útil o player ser global

int lives = 3;
int score = 0;
int level = 0;

ArrayList<Entity> entities = new ArrayList<Entity>();
ArrayList<Prop> props = new ArrayList<Prop>();

boolean [] keys = new boolean[128]; // esse array armazena as teclas que estão sendo precionadas no momento

public void setup() {
  
  
  // simplesmente instanciando objetos importantes no setup
  entities.add(p);

  props.add(new Life(15, 15, 50));
  props.add(new Score(600, 750, 50));
  props.add(new Level(600, 50, 50));
  props.add(new Spawn(0, 0, 50));
  props.add(new Instrucoes(15, 750, 50));
}

public void draw() {
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


public void mousePressed(){
  entities.add(new Bullet(p.getPosX(), p.getPosY(), p.angle, Times.ALIADOS));
}

public void keyPressed() {
  int keyNumber = key;
  if(keyNumber > 127) {
    return;
  }
  keys[key] = true;
}

public void keyReleased() {
  int keyNumber = key;
  if(keyNumber > 127) {
    return;
  }
  keys[key] = false;
}

public void addScore(int v) {
  score += v;
}

// checa se a entidade passada colidiu com alguma outra entidade
public void checkCollisions(Entity entity, int index) { // passar o index além da entidade permite achar no array mais facilmente
  for (int i = index + 1; i < entities.size(); i++) {
     Entity other = entities.get(i);
     boolean colidiu = entity.checkCollision(other);
          
     // apaga tudo que colidiu
     if(colidiu)  {
       addScore(50);
       entities.remove(i); // i é sempre "other" entity
       if(entity != p) entities.remove(index); // index é a entidade atual, por isso precisamos verificar para não apagar o player
     }
  }
}

// simples gerador de números aleatórios
public int RNG(int min, int max) {
   return (int) ((Math.random() * (max - min)) + min);
}
public class Bullet extends Entity {
  private float angle;
  
  // balas precisam de time para evitar colisões desnecessárias
  public Bullet(float x, float y, float angle, Times time) {
    super(x, y, 5, 5);
 
    this.angle = angle;
    this.time = time;
    this.name = "Bullet";
  }
  
  
  public void move() {
    float rad = angle / 180 * PI; 
    pos.x = pos.x + (cos(rad) * speed.x); // trigonometria básica para saber o movimento da bullet
    pos.y = pos.y + (sin(rad) * speed.y);
  }
  
  
  public void draw() { //<>//
    fill(255);
    
    pushMatrix();
    
    translate(this.pos.x, this.pos.y);      
    
    rotate(radians(this.angle));
    
    rectMode(CENTER);
    
    rect(0, 0, this.tamanho, this.tamanho);

    popMatrix();
  }
  
}
public abstract class Enemy extends Entity{    
  protected PVector direction;
  protected int c;
  
  // Todo inimigo nasce com direção inicial aleatória
  
  public Enemy(float x, float y, float tamanho, float speed) {
    super(x, y, tamanho, speed);
    this.c = color(RNG(0, 255), RNG(0, 255), RNG(0, 255));
    this.direction = new PVector(RNG(0, width), RNG(0, height));
    this.time = Times.INIMIGOS;
    this.name = "Enemy";
  }
  
  // para possibilitar passar cor durante a criação
  
  public Enemy(float x, float y, float tamanho, float speed, int c) {
    super(x, y, tamanho, speed);
    this.c = c;
    this.direction = new PVector(RNG(0, width), RNG(0, height));
    this.time = Times.INIMIGOS;
    this.name = "Enemy";
  }
  
  
  // todos os inimigos são esferas    
  public void draw() {
    fill(c);
        
    pushMatrix();
    
    translate(pos.x, pos.y);
    //rotate(radians(angle));
    
    ellipseMode(CENTER);
       
    ellipse(0, 0, tamanho, tamanho);
    
    popMatrix();
   }
}
public abstract class Entity { 
  protected PVector pos; // PVector deixa mais limpo o código, é usado como pos.x e pos.y
  protected PVector speed;
  protected float angle;
  protected float tamanho;
  protected int frame;
  protected String name; // para facilitar debug
  protected Times time; // 0 = ALIADOS; 1 = INIMIGOS; 2 NEUTROS;
    
  public Entity(float x, float y, float tamanho, float speed) {
    this.pos = new PVector(x, y);
    this.speed = new PVector(speed, speed);
    this.tamanho = tamanho;
    this.angle = 0;
    this.frame = 0;
  }
  
  // get and set
  public float getPosX() {
    return this.pos.x;
  };
  
  public void setPosX(float x) {
    this.pos.x = x;
  }
  
  public float getPosY() {
    return this.pos.y;
  };
  
  public void setPosY(float y) {
    this.pos.y = y;
  }
  
  public float getTamanho() {
    return this.tamanho;
  };
  
  public void setTamanho(float tamanho) {
    this.tamanho = tamanho;
  }
  
  // --
  
  // todas entidades devem implementar draw e move
  public abstract void draw();
  
  public abstract void move(); 
  
  // esse método é útil para fazer ações a  cada x tempos
  public void clock() {
    frame++;
    
    if(frame > 60) {
      frame = 0;
    }
  };
  
  // todas as entidades tem uma verificação básica de colisão
  public boolean checkCollision(Entity other) {
    // essa linha impede membros do próprio time colidirem
    if(this.time.getValue() == other.time.getValue()) return false;
    
    // tamanho é usado como "tamanho vertical/horizontal" então é necessário dividir por 2
    return dist(pos.x, pos.y, other.getPosX(), other.getPosY()) < tamanho / 2;
  };
}
public interface Expansor {
  public void expandir();
  public void diminuir();
}
public class Instrucoes extends Prop {
  public Instrucoes(float x, float y, float tamanho){
    super(x, y, tamanho);
  }
  
  // simplesmente desenha as instruções na tela
  public void draw() {    
    level =  (int) score / 500;
    
    pushMatrix();
    translate(pos.x, pos.y);
    
    textSize(16);
    fill(255, 0, 0);
    text("WASD - MOVIMENTO", 0, -40);
    text("QE - GIRA", 0, -20);
    text("MOUSE - ATIRA", 0, 0);
    
    popMatrix();
  }
}
public class Level extends Prop {
  public Level(float x, float y, float tamanho){
    super(x, y, tamanho);
  }
  
  // desenha o level atual e calcula o level atual
  public void draw() {    
    level =  (int) score / 500;
    
    pushMatrix();
    translate(pos.x, pos.y);
    
    textSize(32);
    fill(255, 0, 0);
    text("Level: " + String.valueOf(level), 0, 0);
    
    popMatrix();
  }
}
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
public interface MudaCor {
  public void trocacor();
}
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
public class PatruleiroExpansor extends Patruleiro implements Expansor { 
   private boolean expandindo = false;
      
   public PatruleiroExpansor(float x, float y, float tamanho, float speed) {
     super(x, y, tamanho, speed);
   }
   
   public void expandir() {
     this.tamanho += 1.05f; // se maior que o tamanho que diminui significa que com o tempo ele fica maior para sempre
     
     if(this.frame <= 30) {
       this.expandindo = false;
     }
   }
    
   public void diminuir() {
     this.tamanho -= 1;
     
     if(this.frame > 30) {
        this.expandindo = true;
     }
   }
   
   public void clock() { // motivos para o clock ser útil
     super.clock();
         
     if(this.expandindo) {
       this.expandir(); // 30 frames expandindo
     } else {
       this.diminuir(); // 30 frames diminuindo
     }
   }
}
public abstract class Prop { 
  protected PVector pos;
  protected float tamanho;
  
  public Prop(float x, float y, float tamanho) {
    this.pos = new PVector(x, y);
    this.tamanho = tamanho;
  }
  
  // get and set
  public float getPosX() {
    return this.pos.x;
  };
  
  public void setPosX(float x) {
    this.pos.x = x;
  }
  
  public float getPosY() {
    return this.pos.y;
  };
  
  public void setPosY(float y) {
    this.pos.y = y;
  }
  
  public float getTamanho() {
    return this.tamanho;
  };
  
  public void setTamanho(float tamanho) {
    this.tamanho = tamanho;
  }
  
  // ---
  
  
  // prop não se mexem, só são desenhados na tela
  public abstract void draw();  
}
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
public enum Times {  // simples enum armazenar os times
  ALIADOS(0), INIMIGOS(1), NEUTROS(2);
  
  private final int value;
  
  private Times(int v){
     this.value = v;
  }
  
  public int getValue() {
    return this.value;
  }
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Jogo" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
