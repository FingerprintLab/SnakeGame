public class Apple {
  
  private int x;
  private int y;
  private color col;
  
  public Apple(int x, int y) {
    this.x = x;
    this.y = y;
    this.col = this.CalcColor();
  }
  
  public int X() {
    return this.x;
  }
  
  public int Y() {
    return this.y;
  }
  
  public color Col() {
    return this.col;
  }
  
  private color CalcColor() {
    if (rainbow) return color(int(random(255)), int(random(255)), int(random(255)));
    else return color(230, 0, 0);
  }
}
