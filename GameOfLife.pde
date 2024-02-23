import de.bezier.guido.*;
int NUM_ROWS = 20;
int NUM_COLS = 20;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );
  for (int i = 0; i<NUM_ROWS; i++) {
    for (int j = 0; j<NUM_COLS; j++) {
      buttons[i][j]=new Life(i,j);
    }
  } //your code to initialize buttons goes here
  for (int i = 0; i<NUM_ROWS; i++) {
    for (int j = 0; j<NUM_COLS; j++) {
      buffer[i][j]=false;
    }
  } //your code to initialize buffer goes here
}

public void draw () {
  background( 0 ); 
  if (running == false) //pause the program
    return; 
  copyFromButtonsToBuffer(); 
  for (int i = 0; i<buttons.length; i++) {
    for (int j = 0; j<buttons[i].length; j++) {
      if(countNeighbors(i,j)==3||countNeighbors(i,j)==2){
        buffer[i][j]=true;
      } else if (countNeighbors(i,j)>3){
        buffer[i][j]=false;
      }
      buttons[i][j].draw();
    }
  } //use nested loops to draw the buttons here
  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
}

public void copyFromBufferToButtons() {
  for (int i = 0; i<NUM_ROWS; i++) {
    for (int j = 0; j<NUM_COLS; j++) {
      buffer[i][j]=buttons[i][j].getLife();
    }
  }
}

public void copyFromButtonsToBuffer() {
  for (int i = 0; i<NUM_ROWS; i++) {
    for (int j = 0; j<NUM_COLS; j++) {
      buttons[i][j].setLife(buffer[i][j]);
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
  for (int i = 0; i<buffer.length; i++) {
    for (int j = 0; j<buffer[i].length; j++) {
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
    fill( 150 ); 
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    if (alive) return true;
      return false;
  }
  public void setLife(boolean living) {
    //your code here
    alive = living;
  }
}
