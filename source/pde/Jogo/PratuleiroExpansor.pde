public class PatruleiroExpansor extends Patruleiro implements Expansor { 
   private boolean expandindo = false;
      
   public PatruleiroExpansor(float x, float y, float tamanho, float speed) {
     super(x, y, tamanho, speed);
   }
   
   public void expandir() {
     this.tamanho += 1.05; // se maior que o tamanho que diminui significa que com o tempo ele fica maior para sempre
     
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
