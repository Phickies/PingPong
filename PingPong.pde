/*
  ------PING CHILLING-------
 
 created by @Phicks
 <22-01-2022>
 -----------------------------------------------------------------------------------------------------
 
 This is a Ping Pong simulated game.
 using 'W' and 'S' to control player1,
 using 'O' and 'L' to control player2,
 Player 1 control on the left side and player 2 is on the opposite side.
 Earn 5 point first to win the game,
 
 You can turn on the autoPlayerPlayer1 or 2 to play againist computer and algorithm.
 
 In order to make "controller MODE" work, you need to hook up with the arduino broad,
 upload the sketch on the "PingPongController.ino" file into the arduino broad.
 Plug on a small joystick and you can now enjoy the game your friends.
 This game using the "GraphicUserInterface" source code from Phicks to create GUI.
 
 [WARNING]
 - The sensitive MODE is under construction.
 - It is prefer to hook up with the controller since the keybroad input is suck as fuck.
 - You can improve, copy, remix yourself a better version, use it for your own purpose.
 ------------------------------------------------------------------------------------------------------
 */

import processing.serial.*;

Serial port;

Button button, button2;
Toggle toggle;
Field field;
Player player1, player2;
Score_Table scoreTable1, scoreTable2;
Ball ball;

String GAMESTATE = "START";
String buff = "";
float controlA, controlB;

boolean autoPlayPlayer1 = false;
boolean autoPlayPlayer2 = true;
boolean control         = false;
boolean controlNoti     = false;

void setup() {
  size(1050, 700);
  strokeWeight(6);
  stroke(255);
  rectMode(RADIUS);
  ellipseMode(RADIUS);
  textAlign(CENTER, CENTER);

  button      = new Button(false, width/2, height/2, 100, 50, 90, 0, "START", 50, 255, null);
  button2     = new Button(false, width/2, height/2 - 100, 150, 50, 90, 0, "CONTINUE", 50, 255, null);
  toggle      = new Toggle(width/2, height/2 + 200, 20, color(0, 255, 0), color(255, 0, 0), 255);
  field       = new Field(400, 300);
  player1     = new Player("left");
  player2     = new Player("right");
  scoreTable1 = new Score_Table("left");
  scoreTable2 = new Score_Table("right");
  ball        = new Ball();

  try {
    port      = new Serial(this, Serial.list()[0], 9600);
  }
  catch (Exception e) {
    controlNoti = true;
  }

  player1.setPosition(field);
  player2.setPosition(field);
}

void draw() {
  switch (GAMESTATE) {
  case "START":
    background(0);
    stroke(0);
    textSize(100);
    fill(250, 250, 10);
    text("Ping Chilling", width/2, height/2 - 200);
    button.display();
    textSize(25);
    fill(255);
    text("Controller MODE", width/2, height/2 + 130);
    toggle.display();
    text("Press ESC to quit", width/2, height/2 + 300);
    button.hoverAnimation(255, 255, 255);
    fill(255, 0, 0);
    text("There is no controller hooked up", width/2 + 300, 20);
    break;

  case "PAUSE":
    background(0);
    stroke(0);
    textSize(100);
    button2.display();
    textSize(25);
    fill(255);
    text("Controller MODE", width/2, height/2 + 130);
    toggle.display();
    text("Press ESC to quit", width/2, height/2 + 300);
    button2.hoverAnimation(255, 255, 255);
    break;

  case "PLAY":
    background(0);

    field.display();
    player1.display();
    player2.display();
    scoreTable1.display(player1);
    scoreTable2.display(player2);
    ball.display();

    if (autoPlayPlayer1) {
      player1.setPosY(ball.getPosY());
    }
    if (autoPlayPlayer2) {
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

    if (!control) {
      if (player1.getKeyPressed()) {
        player1.move();
      }
      if (player2.getKeyPressed()) {
        player2.move();
      }
    } else {
      while (port.available() > 0) {
        serialEvent(port.read());
      }
      player1.move(controlA);
      player2.move(controlB);
    }


    if (scoreTable1.getScore() == 5) {
      noLoop();
      scoreTable1.displayWin();
    } else if (scoreTable2.getScore() == 5) {
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
    break;
  }
}

void mousePressed() {
  if (button.isPressed()) {
    GAMESTATE = "PLAY";
  }

  if (button2.isPressed()) {
    GAMESTATE = "PLAY";
  }

  if (toggle.switched()) {
    if (toggle.getSwitchState()) {
      toggle.setSwitchState(false);
      control = true;
    } else {
      toggle.setSwitchState(true);
      control = false;
    }
  }
}

void keyPressed() {
  player1.setKeyPressed(true);
  player2.setKeyPressed(true);

  if (key == TAB) {
    GAMESTATE = "PAUSE";
  }
}

void keyReleased() {
  player1.setKeyPressed(false);
  player2.setKeyPressed(false);
}

void serialEvent(int serial) {
  try {
    if (serial != 10) {
      buff += char(serial);
    } else {
      println(char(serial));
      char c = buff.charAt(0);
      buff = buff.substring(1);
      buff = buff.substring(0, buff.length() - 1);
      if (c == 'A') {
        controlA = map(parseInt(buff), 0, 1023, 13, -13);
      } else if (c == 'B') {
        controlB = map(parseInt(buff), 0, 1023, 13, -13);
      }
      buff = "";
    }
  }
  catch (Exception error) {
    println("no valid data");
  }
}
