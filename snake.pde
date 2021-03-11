public class Snake {
  
  public int len;
  public int grid;
  public int currentDir;
  public Vector blocks;
  
  public Snake(int grid, int x, int y) {
    this.grid = grid;
    currentDir = 2;
    Block b1 = new Block(x*this.grid + 50, y*this.grid + 50, currentDir, this.Color(0));
    Block b2 = new Block(b1.x+10, b1.y, currentDir, this.Color(1));
    blocks = new Vector(b1);
    blocks.Push(b2);
    len = blocks.len;
  }
  
  public void Redirect(int dir) {
    //println(dir);
    if (dir == currentDir || (dir == 0 && currentDir == 1) || (dir == 1 && currentDir == 0) || 
       (dir == 2 && currentDir == 3) || (dir == 3 && currentDir == 2)) return;
    currentDir = dir;
  }
  
  public void Move() {
    for (int i = len-1; i > 0; i--)
      blocks.Get(i).dir = blocks.Get(i-1).dir;
    blocks.Get(0).dir = currentDir;
    
    for (int i = len-1; i >= 0; i--) {
      if (blocks.Get(i).dir == 3) {
        blocks.Get(i).x += 10;
        if (zen && blocks.Get(i).x == width && i != 0)
          this.SetX(i, 0);
      }
      else if (blocks.Get(i).dir == 2) {
        blocks.Get(i).x -= 10;
        if (zen && blocks.Get(i).x == -10  && i != 0)
          this.SetX(i, width);
      }
      else if (blocks.Get(i).dir == 1) {
        blocks.Get(i).y -= 10;
        if (zen && blocks.Get(i).y == -10  && i != 0)
          this.SetY(i, height);
      }
      else {
        blocks.Get(i).y += 10;
        if (zen && blocks.Get(i).y == height  && i != 0)
          this.SetY(i, 0);
      }
    }
    
    //for (int i = 0; i < len; i++) print(blocks.Get(i).dir + " ");
    //println();
  }
  
  public void Grow() {
    Block last = blocks.Get(len-1);
    int x = last.x;
    int y = last.y;
    
    if      (last.dir == 0) y-=10;
    else if (last.dir == 1) y+=10;
    else if (last.dir == 2) x+=10;
    else                    x-=10;
    
    blocks.Push(new Block(x, y, last.dir, Color(len+1)));
    len++;
  }
  
  public int GetX(int index) {
    return blocks.Get(index).x;
  }
  
  public int GetY(int index) {
    return blocks.Get(index).y;
  }
  
  public int GetDir(int index) {
    return blocks.Get(index).dir;
  }
  
  public color GetCol(int index) {
    return blocks.Get(index).col;
  }
  
  public void SetX(int index, int elem) {
    Block b = new Block(elem, this.GetY(index), this.GetDir(index), this.GetCol(index));
    blocks.Set(index, b);
  }
  
  public void SetY(int index, int elem) {
    Block b = new Block(this.GetX(index), elem, this.GetDir(index), this.GetCol(index));
    blocks.Set(index, b);
  }
  
  private color Color(int index) {
    color col;
    if (rainbow) col = color(int(random(255)), int(random(255)), int(random(255)));
    else {
      if (light) {
        int c = 120 + index*5;
        if (c >= 230) c = 230;
        col = color(0,c,0);
      }
      else {
        int c = 230 - index*5;
        if (c <= 120) c = 120;
        col = color(0,c,0);
      }
    }
    return col;
  }
}
