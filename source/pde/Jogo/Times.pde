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
