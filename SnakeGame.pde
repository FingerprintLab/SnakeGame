Snake snake;
Apple apple;
boolean gameOver = false;
boolean zen = false;
boolean showGrid = false;
boolean rainbow = false;
boolean light = true;
boolean progressiveSpeed = true;
int points, initial;
float timeCount, speed, prog;
int dir;

void setup() {
  size(200, 200);
  background(60);
  noStroke();
  textAlign(CENTER, CENTER);
  textSize(max(width/10 - 5, 15));
 
  points = 0;
  dir = 2;
  timeCount = 0.0;
  speed = 15;
  prog = 0.20;
  snake = new Snake(10, int(random(width/10 - 10)), int(random(height/10 - 10)));
  spawnApple();
}

void draw() {
  if (gameOver) {
    if (light) {
      background(220);
      fill(60);
    }
    else {
      background(60);
      fill(220);
    }
    text("GAME OVER\n POINTS: "+points, width/2, height/2);
    
    if (keyPressed) {
      if (key == 10) {
          if (gameOver) {
              println("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nNew game");
              gameOver = false;
              points = 0;
              setup();
        }
      }
    }
  }
  else  {
    gameOver();
    
    if (keyPressed)
      if (key == CODED)
        dir = getDirection(keyCode);
      else if (key == 103 || key == 71)
        showGrid = !showGrid;
    
    if (int(timeCount % speed) == 0) {
      timeCount = 0;
      snake.Redirect(dir);
      snake.Move();
    
      if (snake.GetX(0) == apple.X() && snake.GetY(0) == apple.Y()) {
        snake.Grow();
        spawnApple();
        points++;
        speed -= prog;
        println("Points: "+points);
      }

      if (light) background(220);
      else background(60);
      refresh();
    }
    timeCount+=1;
  }
}

void spawnApple() {
  int appleX;
  int appleY;
  boolean ok = true;
  
  do {
    appleX = int(random(width/10))*10;
    appleY = int(random(height/10))*10;
    for (int i = 0; i < snake.len; i++) {
      if (appleX == snake.GetX(i) && appleY == snake.GetY(i)) {
        ok = false;
        break;
      }
      else ok = true;
    }
  } while (!ok);
  
  apple = new Apple(appleX, appleY);
}

int getDirection(int k) {
    if (k == RIGHT) {
      return 3;
    }
    else if (k == LEFT) {
      return 2;
    }
    else if (k == UP) {
      return 1;
    }
    else if (k == DOWN) {
      return 0;
    }
    else return -1;
}

void refresh() {
  if (showGrid) drawGrid();

  for (int i = snake.len-1; i >= 0; i--) {
    fill(snake.GetCol(i));
    rect(snake.GetX(i), snake.GetY(i)+1, 9, 9, 3);
  }
  
  fill(apple.Col());
  rect(apple.X(), apple.Y()+1, 9, 9, 6);
}

void drawGrid() {
  boolean col = true;

  for (int i = -1; i < width; i+=10) {
    for (int j = 0; j < height; j+=10) {
      
      if (col) {
        if (light) fill(220);
        else fill(60);
      }
      else {
        if (light) fill(216);
        else fill(56);
      }
      
      rect(i, j, 10, 10, 4);
      col = !col;
    }
    col = !col;
  }
}

void gameOver() {  
  if(snake.GetX(0) == width || snake.GetX(0) == -10 || snake.GetY(0) == height || snake.GetY(0) == -10) {
    if (!zen) {
      gameOver = true;
      println("Game over");
      draw();
    }
    else {
      if      (snake.GetX(0) == width)  snake.SetX(0, 0);
      else if (snake.GetX(0) == -10)    snake.SetX(0, width);
      else if (snake.GetY(0) == height) snake.SetY(0, 0);
      else                              snake.SetY(0, height);
    }
  }
    
  int headX = snake.GetX(0);
  int headY = snake.GetY(0);
  for (int i = 1; i < snake.len; i++) {
    if (headX == snake.GetX(i) && headY == snake.GetY(i) && !zen) {
      gameOver = true;
      println("Game over");
      draw();
    }
  }
}
