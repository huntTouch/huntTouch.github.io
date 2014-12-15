class DistractorObj {

  private int xPos, yPos;
  String symbol;

  private boolean error = false;

  public PVector pos;
  // distance to touch point
  public float   dist; 

  private PImage errorX;  
  

  DistractorObj(int _xPos, int _yPos, String _symbol) {
    xPos = _xPos;
    yPos = _yPos;
    symbol = _symbol;

    pos = new PVector(xPos, yPos); 
    dist = 0.f;

    errorX = loadImage("circleError.png");
  }


  void display() {

    dist = touchPos.dist(pos);

    if ( error ) {
      fill(#FF5D5D);
    } else {
      fill(#FFE96A); //#88E96A same color as character for max distraction
    } 

    if (error) {
      stroke(#FF2E2E);
    } else {
      stroke(#FFFFFF);
    }
    ellipse(xPos, yPos, 65, 65);

    //draw symbol
    if (!error) {
      textAlign(CENTER); 
      fill(#333333);
      textSize(30);
      text(symbol, xPos, yPos+10);
    }

    if (error) {  
      imageMode(CENTER); 
      image(errorX, xPos, yPos); 
      imageMode(CORNER);
      }
    }

    void setError() {
      error = true;
    }

  // not used? 
  void setNormal() {
    error = false;
  }
  
  boolean getError() {
    return error; 
  }
  
}
