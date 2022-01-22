class Score_Table {

  private PFont newFont;
  private int score = 0;
  private String side;

  Score_Table(String side) {
    this.side = side;
  }

  void setScore(int score) {
    this.score = score;
  }

  int getScore() {
    return score;
  }

  String getSide() {
    return side;
  }

  void display(Player player) {
    newFont = createFont("Montserrat-Thin.ttf", 200);
    textFont(newFont);
    textSize(200);
    fill(255);
    if (player.getPosition() == "left") {
      text(score, width/2 - 200, height/2 - 35);
    } else if (player.getPosition() == "right") {
      text(score, width/2 + 200, height/2 - 35);
    }
    fill(255);
  }

  void update() {
    score++;
  }

  // display only when you win
  void displayWin() {
    fill(255, 255, 0);
    textSize(100);
    if (side == "left") {
      text("WIN", width/2 - 200, height/2 - 200);
    } else if (side == "right") {
      text("WIN", width/2 + 200, height/2 - 200);
    }
  }
}
