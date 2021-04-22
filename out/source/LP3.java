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

public class LP3 extends PApplet {

Player p = new Player(400, 400, 50);

ArrayList<Entity> entities = new ArrayList<Entity>();

boolean [] keys = new boolean[128];

public void setup() {
  
  
  entities.add(p);
  entities.add(new Seguidor(200, 200, 50));
  entities.add(new Patruleiro(200, 200, 50));
}

public void draw() { //<>//
  background(0);
  
  for (int i = 0; i < entities.size(); i++) {
      Entity entity = entities.get(i);
      entity.draw();
      entity.move();
      checkColissions(entity, i);
  }
}

public void keyPressed() {
  keys[key] = true; //<>//
}

public void keyReleased() {
  keys[key] = false;
}

public void checkColissions(Entity entity, int index) {
  for (int i = index + 1; i < entities.size(); i++) {
     Entity other = entities.get(i);
     entity.checkColission(other);
  }
}

public int RNG(int min,int max) {
   return (int) ((Math.random() * (max - min)) + min);
}
public abstract class Enemy extends Entity{    
  protected PVector direction;
  protected int c;

  public Enemy(float x, float y, float tamanho, float speed) {
    super(x, y, tamanho, speed);
    this.c = color(RNG(0, 255), RNG(0, 255), RNG(0, 255));
    this.direction = new PVector(width, height);
  }
      
  public void draw() {
    fill(c);
        
    pushMatrix();
    
    translate(pos.x, pos.y);
    //rotate(radians(angle));
    
    ellipseMode(CENTER);
       
    ellipse(0, 0, tamanho, tamanho);
    
    popMatrix();
   }
    //<>//
  public boolean checkColission(Entity other) {
    return super.checkColission(other);
  }
}
public abstract class Entity { 
  protected PVector pos;
  protected PVector speed;
  protected float angle;
  protected float tamanho;
  
  public Entity(float x, float y, float tamanho) {
    this.pos = new PVector(x, y);
    this.speed = new PVector(0, 0);
    this.tamanho = tamanho;
    this.angle = 0;
  }
  
  public Entity(float x, float y, float tamanho, float speed) {
    this.pos = new PVector(x, y);
    this.speed = new PVector(speed, speed);
    this.tamanho = tamanho;
    this.angle = 0;
  }
  
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
  
  public abstract void draw();
  
  public abstract void move(); 
  
  public boolean checkColission(Entity other) {
    return dist(pos.x, pos.y, other.getPosX(), other.getPosY()) < tamanho;
  };
}
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
public class Player extends Entity {
  
  public Player(float x, float y, float tamanho) {
   super(x, y, tamanho, 5f); 
  }
  
  public void draw() {
    fill(255);
    pushMatrix();
    
    translate(this.pos.x, this.pos.y);
    rotate(radians(this.angle));
    
    rectMode(CENTER);
    
    rect(0, 0, this.tamanho, this.tamanho);
    
    popMatrix();
  }
  
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
    if (keys['e']) angle ++;
    // counterlockwise
    if (keys['q']) angle --;
    
    if(pos.x < 0) pos.x += width;
    if(pos.x > width) pos.x = 0;
    if(pos.y < 0) pos.y += height;
    if(pos.y > height) pos.y = 0;
  }
  
  
  public boolean checkColission(Entity other) {
    boolean colidiu = super.checkColission(other);
    
    if(colidiu) System.out.print("colidiu");;
    return colidiu; //<>//
  }
}
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
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "LP3" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
