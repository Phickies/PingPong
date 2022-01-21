

Field field;
Player player1, player2;
Score_Table scoreTable1, scoreTable2;
Ball ball;

boolean autoPlayPlayer1 = true;
boolean autoPlayPlayer2 = true;

void setup() {
  size(1050, 700);
  strokeWeight(6);
  stroke(255);
  rectMode(RADIUS);
  ellipseMode(RADIUS);
  textAlign(CENTER, CENTER);

  field       = new Field(400, 300);
  player1     = new Player("left");
  player2     = new Player("right");
  scoreTable1 = new Score_Table("left");
  scoreTable2 = new Score_Table("right");
  ball        = new Ball();

  player1.setPosition(field);
  player2.setPosition(field);
}

void draw() {
  background(0);

  field.display();
  player1.display();
  player2.display();
  scoreTable1.display(player1);
  scoreTable2.display(player2);
  ball.display();

  if (autoPlayPlayer1){
  player1.setPosY(ball.getPosY());
  }
  if (autoPlayPlayer2){
  player2.setPosY(ball.getPosY());
  }
  
  player1.update(field);
  player2.update(field);

  if ( ball.getPosX() > width/2 ) {
    ball.setIsLeft(false);
    ball.collide(player2);
  } else {
    ball.setIsLeft(true);
    ball.collide(player1);
  }

  if (player1.getKeyPressed()) {
    player1.move();
  }
  if (player2.getKeyPressed()) {
    player2.move();
  }
  
  
  if(scoreTable1.getScore() == 5){
    noLoop();
    scoreTable1.displayWin();
  } else if (scoreTable2.getScore() == 5){
    noLoop();
    scoreTable2.displayWin();
  }

  if (ball.getPosX() > width/2) {
    if (ball.playerMissed()) {
      scoreTable1.update();
      ball.setEndPosition("right");
      ball.reset();
    }
  } else {
    if (ball.playerMissed()) {
      scoreTable2.update();
      ball.setEndPosition("left");
      ball.reset();
    }
  }
}

void keyPressed() {
  player1.setKeyPressed(true);
  player2.setKeyPressed(true);
}

void keyReleased() {
  player1.setKeyPressed(false);
  player2.setKeyPressed(false);
}
