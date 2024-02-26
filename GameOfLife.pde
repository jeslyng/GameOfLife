import de.bezier.guido.*;
int NUM_ROWS = 50;
int NUM_COLS = 50;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );
  buttons = new Life[NUM_ROWS][NUM_COLS];
  for (int i = 0; i<NUM_ROWS; i++) {
    for (int j = 0; j<NUM_COLS; j++) {
      buttons[i][j]=new Life(i, j);
    }
  } //your code to initialize buttons goes here
  buffer = new boolean [NUM_ROWS][NUM_COLS];
  //your code to initialize buffer goes here
}

public void draw () {
  background( 0 ); 
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer(); 
  for (int i = 0; i<NUM_ROWS; i++) {
    for (int j = 0; j<NUM_COLS; j++) {
      if (countNeighbors(i, j)==3) {
        buffer[i][j]=true;
      } else if (countNeighbors(i, j)==2&&buttons[i][j].getLife()==true) {
        buffer[i][j]=true;
      } else {
        buffer[i][j]=false;
      }
      buttons[i][j].draw();
    }
  } //use nested loops to draw the buttons here
  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
  if (key == ' ')
    running = !running;
  if (key == 'r') {
    for (int i = 0; i < NUM_ROWS; i++)
    {
      for (int j = 0; j < NUM_COLS; j++)
      {
        buttons[i][j].setLife(false);
      }
    }
    running = false;
  }
}

public void copyFromBufferToButtons() {
  for (int i = 0; i<NUM_ROWS; i++) {
    for (int j = 0; j<NUM_COLS; j++) {
      buttons[i][j].setLife(buffer[i][j]);
    }
  }
}

public void copyFromButtonsToBuffer() {
  for (int i = 0; i<NUM_ROWS; i++) {
    for (int j = 0; j<NUM_COLS; j++) {  
      buffer[i][j]=buttons[i][j].getLife();
    }
  }
}

public boolean isValid(int r, int c) {
  if (r<NUM_ROWS&&c<NUM_COLS&&r>-1&&c>-1) 
    return true; 
  return false;
}

public int countNeighbors(int row, int col) {
  int n = 0; 
  for (int i = 0; i<NUM_ROWS; i++) {
    for (int j = 0; j<NUM_COLS; j++) {
      if (isValid(i, j)) {
        if (row==i&&j==col) {
        } else if (i>=row-1&&i<=row+1&&j>=col-1&&j<=col+1&&buffer[i][j]==true) {
          n++;
        }
      }
    }
  }
  return n;
}

public class Life {
  private int myRow, myCol; 
  private float x, y, width, height; 
  private boolean alive; 

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row; 
    myCol = col; 
    x = myCol*width; 
    y = myRow*height; 
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0); 
    else 
      fill((float)Math.random()*256, (float)Math.random()*100+156, (float)Math.random()*100+156); 
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    //your code here
    alive = living;
  }
}
