class CharObj {

  int xPos, yPos;
  String symbol;

  boolean error = false;
  boolean selected = false; 

  public PVector pos;
  // distance to touch point
  public float   dist;  
  
  public boolean normal = true; 

  PImage errorX; 

  CharObj(int _xPos, int _yPos, String _symbol) {
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
    } else if ( selected ) {
      fill(10, 200, 100);
    } else if ( normal ) {
      fill(#FFE96A);
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

    void setSelected() {
      error = false;
      selected = true;
      normal = false;
    }

  void setError() {
    error = true;
    selected = false;
    normal = false;
  }

  void setNormal() {
    error = false;
    selected = false;
    normal = true; 
  }
}
