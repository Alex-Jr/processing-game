# processing-game

Trabalho realizado como requisito para aprovação na disciplina LP3 na UFRRJ.
Um simples jogo em que você movimenta um quadrado branco que atira.
A cada segundo há uma pequena chance de spawnar circulos inimigos
O jogo fica mais difícil a cada level

## Requisitos
* [Java 11](https://www.oracle.com/br/java/technologies/javase-jdk11-downloads.html)
* [Processing](https://processing.org/download/) - Incluso na pasta lib

## Compilando

``` bash
$ javac -classpath lib/processing.jar: source/java/Jogo.java -d out
```

### Execução

``` bash
$ java -classpath lib/processing.jar:out/ Jogo
```