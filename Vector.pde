public class Vector {
  
  public int len;
  private Block vector[];
  
  public Vector(Block elem) {
    len = 1;
    vector = new Block[1];
    vector[0] = elem;
  }
  
  public Block Get(int index) {
    return vector[index];
  }
  
  public void Push(Block elem) {
    Block temp[] = new Block[len+1];
    for (int i = 0; i < len; i++) 
      temp[i] = vector[i];
      
    len++;
    temp[len-1] = elem;
    
    vector = new Block[len];
    for (int i = 0; i < len; i++) 
      vector[i] = temp[i];
  }
  
  public void Set(int index, Block elem) {
    vector[index] = elem;
  }
}
