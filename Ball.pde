class Ball {

  private PVector position     = new PVector(width/2, height/2);
  private PVector accelerate   = new PVector(8, 8);
  private boolean isLeft;
  private String endPosition;

  Ball() {
  }

  void setIsLeft(boolean state) {
    this.isLeft = state;
  }

  void setEndPosition(String endPosition) {
    this.endPosition = endPosition;
  }

  float getPosX() {
    return position.x;
  }

  float getPosY() {
    return position.y;
  }

  boolean getIsLeft() {
    return isLeft;
  }

  void display() {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    ellipse(position.x, position.y, 10, 10);
    fill(2550, 0, 0);
  }

  void collide(Player player) {

    position.add(accelerate);

    if (isLeft == true) {
      if ((position.x - 12 < player.posX + 6 ) && (position.y < player.posY + 40) && (position.y > player.posY - 40)) {
        accelerate.x *= -1;
      }
    } else {
      if ((position.x + 12 > player.posX - 6 ) && (position.y < player.posY + 40) && (position.y > player.posY - 40)) {
        accelerate.x *= -1;
      }
    }
    if (position.y + 10 >= height/2 + field.getFHeight() || position.y - 10 <= height/2 - field.getFHeight()) {
      accelerate.y *= -1;
      accelerate.x += int(random(-1, 3));
    }
  }

  void reset() {
    position.set(width/2, height/2);
    if (endPosition == "left") {
      accelerate.set(8, 8);
    } else if (endPosition == "right") {
      accelerate.set(-8, -8);
    }
  }

  // check if whether the ball is missed the player
  boolean playerMissed() {
    boolean missed = false;
    if (position.x + 10 >= width /2 + field.getFWidth()  || position.x - 10 <= width/2  - field.getFWidth()) {
      missed = true;
    }
    return missed;
  }
}
