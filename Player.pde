class Player {

  private String position;
  private float posX, posY;
  private boolean keyPressed = false;

  Player(String position) {
    this.position = position;
  }

  void setPosition(Field field) {
    posY = 350;
    if (position == "left") {
      this.posX = width/2 - field.getFWidth() + 20;
    } else {
      this.posX = width/2 + field.getFWidth() - 20;
    }
  }

  void setPosX(float posX) {
    this.posX = posX;
  }

  void setPosY(float posY) {
    this.posY = posY;
  }

  void setKeyPressed(boolean state) {
    this.keyPressed = state;
  }

  String getPosition() {
    return position;
  }

  boolean getKeyPressed() {
    return keyPressed;
  }

  void display() {
    fill(255);
    rect(posX, posY, 5, 40, 90);
    fill(255);
  }

  void update(Field field) {
    if (posY + 50 >= height/2 + field.getFHeight()) {
      posY = height/2 + field.getFHeight() - 50;
    } else if (posY - 50 <= height/2 - field.getFHeight()) {
      posY = height/2 - field.getFHeight() + 50;
    }
  }

  void move() {
    if (position == "left") {
      switch (key) {
      case 'w':
        posY -= 13;
        break;
      case 's':
        posY += 13;
        break;
      }
    }
    if (position == "right") {
      switch (key) {
      case 'o':
        posY -= 13;
        break;
      case 'l':
        posY += 13;
        break;
      }
    }
  }

  void move(float value) {
    posY += value;
  }
}
