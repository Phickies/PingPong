class Field {

  private float fWidth, fHeight;

  Field(float fWidth, float fHeight) {
    this.fWidth = fWidth;
    this.fHeight = fHeight;
  }

  public float getFWidth() {
    return fWidth;
  }

  public float getFHeight() {
    return fHeight;
  }

  void display() {
    fill(0);
    stroke(255);
    rect(width/2, height/2, fWidth, fHeight);
    for (float i = height/2 - fHeight + 1; i <= height/2 + fHeight - 1; i += 20) {
      line(width/2, i, width/2, i + 10);
    }
    fill(0);
  }
}
