/* @pjs preload="background.png","circleError.png"; */
/* @pjs preload="htp1.png","htp2.png","htp3.png","htp4.png","htp5.png","htp6.png","htp7.png","htp8.png","htpPractice.png"; */

// for outputing fixed pos
int curSel = 0; 
float lastTime = 0.0; 
float timeDiffBetweenClick = 0.0; 

PImage bg;
PFont font;

//character inc
int incChar = 0;
String seq[], highlighter;
int seqInc; 
CharObj character[][]; 
DistractorObj distractor[][]; 
String distractSymbol[][]; 
String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
//"abcdefghijklmnopqrstuvwxyz123456789"; 

// character positions
int charPosX[][]; 
int charPosY[][]; 
PVector charPos[][]; 

int characterNumInThisSeq[]; 
int distractPosX[][];
int distractPosY[][]; 
PVector distPos[][]; 

boolean finished = false; 
int wrongSelects = 0;

int numDistractor[]; 

ArrayList masterPos[]; 
//PVector fixedPos[][]; //set from photoshop

boolean mousePressedFlag = false; 
boolean sendOnce         = true; 

boolean doNextRound = false;
boolean showRoundText = false; 

String actualRoundMessages[]; 

// tutorial images
PImage tutImage[]; 
//String tutorialMessages[]; 
boolean tutorialMode = true; 
int     tutorialInc = 0; 

int roundTracker = 0; 
String language = " "; 
boolean printLangOnce = true;

int SeqOrder = 0; 
PVector touchPos = new PVector(); 

int startTimeOfCurrentScreen = -1; 
boolean endTimer = false; 
boolean timeIsUp = false; 

void setup() {

  size(docSizeX, docSizeY);
  background(docBgColor_r, docBgColor_g, docBgColor_b);
  bg = loadImage("background.png");
  font = loadFont("din1451.ttf"); 
  textFont(font, 38);

  //language = getLanguage();
  //println("setup lang: " + language); 
  //getLanguage(); 

  /*
  “en” – for English
   “fi” – for Finnish
   “it” – for Italian
   “da” – for Danish
   “nl” – for Dutch
   */

  // stroke(255);
  // ellipse(50*(devicePixelRatioX), 50*(devicePixelRatioX), 35*(devicePixelRatioX), 35*(devicePixelRatioX));

  // disable for release 
  //printScaleFactor(jsString);

  // printDpi();

  //setupFixedPos(); 

  tutImage = new PImage[9];
  tutImage[0] = loadImage("htp1.png");
  tutImage[1] = loadImage("htp2.png"); 
  tutImage[2] = loadImage("htp3.png"); 
  tutImage[3] = loadImage("htp4.png"); 
  tutImage[4] = loadImage("htp5.png"); 
  tutImage[5] = loadImage("htp6.png"); 
  tutImage[6] = loadImage("htp7.png"); 
  tutImage[7] = loadImage("htp8.png");
  tutImage[8] = loadImage("htpPractice.png");  

  seq = new String[19];
  seq[0] = "1234"; 
  seq[1] = "HORSE"; 
  seq[2] = "1A2B3C";
  seq[3] = "1234";
  seq[4] = "TRAIN";
  seq[5] = "A1B2C3";
  seq[6] = "CHAIR";
  seq[7] = "1234";
  seq[8] = "LIVE";
  seq[9] = "1L2IV3E";
  seq[10] = "TABLE";
  seq[11] = "1234567";
  seq[12] = "TRUCK";
  seq[13] = "1T2R3U4C5K";
  seq[14] = "ORANGE";
  seq[15] = "76543";
  seq[16] = "FLOWER";
  seq[17] = "A1B2C3";
  seq[18] = "WHITE";

  //tutorialMessages = new String[12];
  //tutorialMessages[0] = "How to Play the Hunt & Touch Game";
  //tutorialMessages[1] = "Look at the text in the white box.";
  //tutorialMessages[2] = "Touch on each letter or number in order.";
  //tutorialMessages[3] = "When you've finished new text will appear.";
  //tutorialMessages[4] = "Now let's practice…";
  //tutorialMessages[5] = "Try to touch as quickly and accurately as you can.";
  //tutorialMessages[6] = "Touch here to start";
  //tutorialMessages[7] = "Start";

  actualRoundMessages = new String[4]; 
  actualRoundMessages[0] = "Very good.  Now let's start the game.";

  actualRoundMessages[1] = "Excellent!  Let's keep going.";
  actualRoundMessages[2] = "Nice work!  Let's try some more.";
  actualRoundMessages[3] = "That's great!  Just one more set.";

  //seq[0][1] = "";
  highlighter = ""; 

  seqInc = curSel; //0

  characterNumInThisSeq = new int[19];
  characterNumInThisSeq[0] = 4; 
  characterNumInThisSeq[1] = 5; 
  characterNumInThisSeq[2] = 6; 
  characterNumInThisSeq[3] = 4; 
  characterNumInThisSeq[4] = 5; 
  characterNumInThisSeq[5] = 6;
  characterNumInThisSeq[6] = 5;
  characterNumInThisSeq[7] = 4;
  characterNumInThisSeq[8] = 4;
  characterNumInThisSeq[9] = 7; 
  characterNumInThisSeq[10] = 5; 
  characterNumInThisSeq[11] = 7; 
  characterNumInThisSeq[12] = 5;
  characterNumInThisSeq[13] = 10;
  characterNumInThisSeq[14] = 6;
  characterNumInThisSeq[15] = 5;
  characterNumInThisSeq[16] = 6;
  characterNumInThisSeq[17] = 6;
  characterNumInThisSeq[18] = 5;   

  character = new CharObj[20][20]; 
  charPosX  = new int[20][20]; 
  charPosY  = new int[20][20]; 
  // seq 0 

  // MASTER LIST OF CHARACTER POSITIONS 
  charPos = new PVector[20][20];
  distPos = new PVector[20][20];

  for (int i = 0; i < 19; i++) {
    for ( int c = 0; c < 19; c++) {
      charPos[i][c] = new PVector(); 
      distPos[i][c] = new PVector();
    }
  }

  charPos[0][0].x = 733;
  charPos[0][0].y = 365;
  charPos[0][1].x = 93;
  charPos[0][1].y = 525;
  charPos[0][2].x = 333;
  charPos[0][2].y = 285;
  charPos[0][3].x = 573;
  charPos[0][3].y = 205;

  charPos[1][0].x = 333;
  charPos[1][0].y = 285;
  charPos[1][1].x = 253;
  charPos[1][1].y = 445;
  charPos[1][2].x = 173;
  charPos[1][2].y = 285-20;
  charPos[1][3].x = 93;
  charPos[1][3].y = 205;
  charPos[1][4].x = 493;
  charPos[1][4].y = 445+20;

  distPos[1][0].x = 733;
  distPos[1][0].y = 205; 
  distPos[1][1].x = 813;
  distPos[1][1].y = 525;
  distPos[1][2].x = 813-60;
  distPos[1][2].y = 445-30;

  charPos[2][0].x = 333-30;
  charPos[2][0].y = 445+10;
  charPos[2][1].x = 733-50;
  charPos[2][1].y = 285+20;
  charPos[2][2].x = 333;
  charPos[2][2].y = 365;
  charPos[2][3].x = 253;
  charPos[2][3].y = 285;
  charPos[2][4].x = 813;
  charPos[2][4].y = 205+20;
  charPos[2][5].x = 173;
  charPos[2][5].y = 365+50;

  distPos[2][0].x = 93;
  distPos[2][0].y = 205; 
  distPos[2][1].x = 493;
  distPos[2][1].y = 445;
  distPos[2][2].x = 733;
  distPos[2][2].y = 205;
  distPos[2][3].x = 653;
  distPos[2][3].y = 445+34;

  charPos[3][0].x = 93;
  charPos[3][0].y = 525;
  charPos[3][1].x = 493;
  charPos[3][1].y = 365;
  charPos[3][2].x = 413;
  charPos[3][2].y = 285;
  charPos[3][3].x = 813;
  charPos[3][3].y = 205;

  charPos[4][0].x = 173;
  charPos[4][0].y = 285;
  charPos[4][1].x = 813;
  charPos[4][1].y = 205;
  charPos[4][2].x = 173-40;
  charPos[4][2].y = 445-20;
  charPos[4][3].x = 733;
  charPos[4][3].y = 365;
  charPos[4][4].x = 253;
  charPos[4][4].y = 525;

  distPos[4][0].x = 493;
  distPos[4][0].y = 525-120; 
  distPos[4][1].x = 333;
  distPos[4][1].y = 445;
  distPos[4][2].x = 413;
  distPos[4][2].y = 285-30;

  charPos[5][0].set(413, 525-20);
  charPos[5][1].set(573, 525);
  charPos[5][2].set(653+70, 365-25);
  charPos[5][3].set(93, 285);
  charPos[5][4].set(333, 365-50);
  charPos[5][5].set(93+30, 445-20);
  distPos[5][0].set(493, 365);
  distPos[5][1].set(653, 445);
  distPos[5][2].set(573, 205);
  distPos[5][3].set(813, 525-33);

  charPos[6][0].set(173, 445+20);
  charPos[6][1].set(413, 525-130);
  charPos[6][2].set(653, 205);
  charPos[6][3].set(253, 285-20);
  charPos[6][4].set(573, 445+48);
  distPos[6][0].set(93-20, 205+30);
  distPos[6][1].set(333, 525);
  distPos[6][2].set(93, 445-85);
  distPos[6][3].set(813, 285);
  distPos[6][4].set(813-60, 525-100);

  charPos[7][0].set(253, 285+23);
  charPos[7][1].set(173, 205);
  charPos[7][2].set(93, 285+90);
  charPos[7][3].set(813, 365);
  distPos[7][0].set(413, 365);
  distPos[7][1].set(493, 285);
  distPos[7][2].set(333, 445+50);
  distPos[7][3].set(653, 445);
  distPos[7][4].set(733, 205);

  charPos[8][0].set(253, 365-50);
  charPos[8][1].set(93, 445);
  charPos[8][2].set(493, 205+25);
  charPos[8][3].set(413, 365);
  distPos[8][0].set(813, 525);
  distPos[8][1].set(653, 205);
  distPos[8][2].set(733, 365);

  charPos[9][0].set(733, 445);
  charPos[9][1].set(333, 285);
  charPos[9][2].set(813, 525-200);
  charPos[9][3].set(413+20, 285-20);
  charPos[9][4].set(93, 525);
  charPos[9][5].set(93+20, 445);
  charPos[9][6].set(413+50, 525-20);
  distPos[9][0].set(573, 285+18);
  distPos[9][1].set(253, 205);
  distPos[9][2].set(253, 445-20);
  distPos[9][3].set(413, 365);

  charPos[10][0].set(733, 285);
  charPos[10][1].set(573+99, 525);
  charPos[10][2].set(573, 445+30);
  charPos[10][3].set(173, 285);
  charPos[10][4].set(413, 205);
  distPos[10][0].set(413, 365+60);
  distPos[10][1].set(573, 205+30);
  distPos[10][2].set(493, 365-20);
  distPos[10][3].set(653, 365+20);
  distPos[10][4].set(253, 445);

  charPos[11][0].set(413, 365);
  charPos[11][1].set(653, 285);
  charPos[11][2].set(173-50, 285+50);
  charPos[11][3].set(333, 525-30);
  charPos[11][4].set(733, 445);
  charPos[11][5].set(173, 525);
  charPos[11][6].set(573, 205);

  charPos[12][0].set(93, 205);
  charPos[12][1].set(813, 445+31);
  charPos[12][2].set(173, 525-111);
  charPos[12][3].set(813-120, 365);
  charPos[12][4].set(733, 205);
  distPos[12][0].set(413, 525);
  distPos[12][1].set(333, 285);
  distPos[12][2].set(493, 445);

  charPos[13][0].set(733, 525);
  charPos[13][1].set(813, 285);
  charPos[13][2].set(93, 445);
  charPos[13][3].set(653, 205);
  charPos[13][4].set(173-20, 285-20);
  charPos[13][5].set(813-89-20, 365+25);
  charPos[13][6].set(253, 445+30);
  charPos[13][7].set(173, 365);
  charPos[13][8].set(413, 365-50);
  charPos[13][9].set(573, 445-20);

  charPos[14][0].set(653-20, 445-30);
  charPos[14][1].set(733, 285-50);
  charPos[14][2].set(173, 205);
  charPos[14][3].set(93+150, 365);
  charPos[14][4].set(173-30, 445);
  charPos[14][5].set(573, 285+50);
  distPos[14][0].set(93, 285+20);
  distPos[14][1].set(333, 285-30);
  distPos[14][2].set(573+200, 525-30);
  distPos[14][3].set(413, 525);

  charPos[15][0].set(253, 445);
  charPos[15][1].set(573-100, 205);
  charPos[15][2].set(93, 285);
  charPos[15][3].set(573, 445+50);
  charPos[15][4].set(813, 445);

  charPos[16][0].set(493, 205);
  charPos[16][1].set(173, 365);
  charPos[16][2].set(413, 285);
  charPos[16][3].set(173-50, 205+22);
  charPos[16][4].set(733, 285-30);
  charPos[16][5].set(653-20, 365-30);
  distPos[16][0].set(653, 445+80);
  distPos[16][1].set(333, 445);
  distPos[16][2].set(813, 285+120);

  charPos[17][0].set(573, 205+30);
  charPos[17][1].set(333-33, 285);
  charPos[17][2].set(733, 525-65);
  charPos[17][3].set(93+55, 525-30);
  charPos[17][4].set(573-76, 285+250);
  charPos[17][5].set(813, 365+30);
  distPos[17][0].set(173, 205);
  distPos[17][1].set(93, 365-30);
  distPos[17][2].set(333, 525);
  distPos[17][3].set(333+90, 365);

  charPos[18][0].set(253, 525-310);
  charPos[18][1].set(493+30, 365);
  charPos[18][2].set(173-50, 285+30);
  charPos[18][3].set(813, 445+45);
  charPos[18][4].set(173+150, 445);

  distPos[18][0].set(573, 285+180);
  distPos[18][1].set(733, 365-30);
  distPos[18][2].set(413, 285);
  distPos[18][3].set(813-100, 205+30);
  distPos[18][4].set(93, 525);

  /*
  charPosX[0][0] = 300;
   charPosY[0][0] = 300;
   charPosX[0][1] = 500;
   charPosY[0][1] = 500; 
   
   charPosX[1][0] = 300;
   charPosY[1][0] = 300;
   charPosX[1][1] = 500;
   charPosY[1][1] = 500; 
   
   charPosX[2][0] = 300;
   charPosY[2][0] = 300;
   charPosX[2][1] = 500;
   charPosY[2][1] = 500;  
   
   charPosX[3][0] = 300;
   charPosY[3][0] = 300;
   charPosX[3][1] = 500;
   charPosY[3][1] = 500; 
   
   charPosX[4][0] = 300;
   charPosY[4][0] = 300;
   charPosX[4][1] = 500;
   charPosY[4][1] = 500;*/

  distractor = new DistractorObj[20][20]; 
  distractPosX  = new int[20][20]; 
  distractPosY  = new int[20][20]; 



  numDistractor = new int[20]; 
  numDistractor[0] = 0;
  numDistractor[1] = 3;
  numDistractor[2] = 4;
  numDistractor[3] = 0;
  numDistractor[4] = 3;
  numDistractor[5] = 4;
  numDistractor[6] = 5;
  numDistractor[7] = 5;
  numDistractor[8] = 3;
  numDistractor[9] = 4;
  numDistractor[10] = 5;
  numDistractor[11] = 0;
  numDistractor[12] = 3;
  numDistractor[13] = 0;
  numDistractor[14] = 4;
  numDistractor[15] = 0;
  numDistractor[16] = 3;
  numDistractor[17] = 4;
  numDistractor[18] = 5;

  distractSymbol = new String[20][20]; 

  //HORSE
  distractSymbol[1][0] = "A";
  distractSymbol[1][1] = "5";
  distractSymbol[1][2] = "X";

  //1A2B3C
  distractSymbol[2][0] = "T";
  distractSymbol[2][1] = "7";
  distractSymbol[2][2] = "4";
  distractSymbol[2][3] = "D";

  //TRAIN
  distractSymbol[4][0] = "3";
  distractSymbol[4][1] = "C";
  distractSymbol[4][2] = "7";

  //A1B2C3 
  distractSymbol[5][0] = "6";
  distractSymbol[5][1] = "Z";
  distractSymbol[5][2] = "8";
  distractSymbol[5][3] = "F";

  //CHAIR
  distractSymbol[6][0] = "E";
  distractSymbol[6][1] = "3";
  distractSymbol[6][2] = "Q";
  distractSymbol[6][3] = "V";
  distractSymbol[6][4] = "5";

  //1234
  distractSymbol[7][0] = "W";
  distractSymbol[7][1] = "9";
  distractSymbol[7][2] = "M";
  distractSymbol[7][3] = "U";
  distractSymbol[7][4] = "7";

  //LIVE
  distractSymbol[8][0] = "G";
  distractSymbol[8][1] = "W";
  distractSymbol[8][2] = "0";

  //1L2IV3E
  distractSymbol[9][0] = "W";
  distractSymbol[9][1] = "T";
  distractSymbol[9][2] = "R";
  distractSymbol[9][3] = "0";

  //TABLE
  distractSymbol[10][0] = "8";
  distractSymbol[10][1] = "2";
  distractSymbol[10][2] = "K";
  distractSymbol[10][3] = "0";
  distractSymbol[10][4] = "5";

  //TRUCK
  distractSymbol[12][0] = "Z";
  distractSymbol[12][1] = "X";
  distractSymbol[12][2] = "4";

  //ORANGE
  distractSymbol[14][0] = "U";
  distractSymbol[14][1] = "9";
  distractSymbol[14][2] = "H";
  distractSymbol[14][3] = "J";

  //FLOWER
  distractSymbol[16][0] = "C";
  distractSymbol[16][1] = "7";
  distractSymbol[16][2] = "X";

  //A1B2C3
  distractSymbol[17][0] = "8";
  distractSymbol[17][1] = "E";
  distractSymbol[17][2] = "P";
  distractSymbol[17][3] = "D";

  //WHITE
  distractSymbol[18][0] = "0";
  distractSymbol[18][1] = "5";
  distractSymbol[18][2] = "R";
  distractSymbol[18][3] = "A";
  distractSymbol[18][4] = "Y";

  setupGridPos(); 

  // release ver will have preset positions and distractor symbols 
  for ( int i = 0; i < 19; i++ ) { //19
    for ( int c = 0; c < characterNumInThisSeq[i]; c++ ) {
      // temp setup for demo 
      // non random for release 

      // old way of setting positions with overlap
      //charPosX[i][c] = (int)random(40, 850); //100*c;
      //charPosY[i][c] = (int)random(200, 500);//100*c; 

      //random positions for testing
      //int posSel = (int)random(0, masterPos[i].size());
      //PVector newPos = (PVector)masterPos[i].get(posSel);
      //charPosX[i][c] = newPos.x; 
      //charPosY[i][c] = newPos.y; 
      if ( i == curSel) {
        //println( "round: " + i + " " + "circle: " + c + " x: " + newPos.x + " y: " + newPos.y );
      }
      //masterPos[i].remove(posSel); 

      //character[i][c] = new CharObj(charPosX[i][c], charPosY[i][c], str(seq[i].charAt(c)));
      character[i][c] = new CharObj(charPos[i][c].x, charPos[i][c].y, str(seq[i].charAt(c)));
    }

    // for now same number of distractors as characters
    //for ( int d = 0; d < characterNumInThisSeq[i]; d++ ) {
    for ( int d = 0; d < numDistractor[i]; d++ ) {

      //distractPosX[i][d] = (int)random(40, 850);
      //distractPosY[i][d] = (int)random(200, 500);

      //int posSel = (int)random(0, masterPos[i].size());
      //PVector newPos = (PVector)masterPos[i].get(posSel);
      //distractPosX[i][d] = newPos.x; 
      //distractPosY[i][d] = newPos.y; 

      //masterPos[i].remove(posSel); 

      // distractSymbol[i][d] = str(alphabet.charAt(random(0, 35)));  
      // non random 

      //distractor[i][d] = new DistractorObj(distractPosX[i][d], distractPosY[i][d], distractSymbol[i][d]);
      distractor[i][d] = new DistractorObj(distPos[i][d].x, distPos[i][d].y, distractSymbol[i][d]);

      if ( i == curSel) {
        //println( "round: " + i + " " + "distracg: " + d + " x: " + newPos.x + " y: " + newPos.y + " " + distractor[i][d].symbol);
      }
    }

    // character[i][0] = new CharObj(charPosX[i][0], charPosY[i][0], "H");
    // character[i][1] = new CharObj(charPosX[i][1], charPosY[i][1], "2");
  }

  //  String words = "apple bear cat dog";
  //  String[] list = split(words, ' ');
  //
  //  // now write the strings to a file, each on a separate line
  //  saveStrings("nouns.txt", list);
}

void resetDistractors(String lang) {

  //fi
  if (lang == "fi") {
    //println("reset distractors fi");

    //KAHVI
    distractSymbol[1][0] = "A";
    distractSymbol[1][1] = "5";
    distractSymbol[1][2] = "Z";

    //1A2B3C
    distractSymbol[2][0] = "T";
    distractSymbol[2][1] = "7";
    distractSymbol[2][2] = "4";
    distractSymbol[2][3] = "D";

    //SORMI
    distractSymbol[4][0] = "3";
    distractSymbol[4][1] = "C";
    distractSymbol[4][2] = "7";

    //A1B2C3 
    distractSymbol[5][0] = "6";
    distractSymbol[5][1] = "Z";
    distractSymbol[5][2] = "8";
    distractSymbol[5][3] = "F";

    //TUOLI
    distractSymbol[6][0] = "E";
    distractSymbol[6][1] = "3";
    distractSymbol[6][2] = "Q";
    distractSymbol[6][3] = "V";
    distractSymbol[6][4] = "5";

    //1234
    distractSymbol[7][0] = "W";
    distractSymbol[7][1] = "9";
    distractSymbol[7][2] = "M";
    distractSymbol[7][3] = "U";
    distractSymbol[7][4] = "7";

    //KATU
    distractSymbol[8][0] = "G";
    distractSymbol[8][1] = "W";
    distractSymbol[8][2] = "0";

    //1K2A3TU
    distractSymbol[9][0] = "W";
    distractSymbol[9][1] = "Z";
    distractSymbol[9][2] = "R";
    distractSymbol[9][3] = "0";

    //KORIA
    distractSymbol[10][0] = "8";
    distractSymbol[10][1] = "2";
    distractSymbol[10][2] = "C";
    distractSymbol[10][3] = "3";
    distractSymbol[10][4] = "5";

    //MAITO
    distractSymbol[12][0] = "Z";
    distractSymbol[12][1] = "X";
    distractSymbol[12][2] = "4";

    //RUSKEA
    distractSymbol[14][0] = "U";
    distractSymbol[14][1] = "9";
    distractSymbol[14][2] = "H";
    distractSymbol[14][3] = "J";

    //HUVILA
    distractSymbol[16][0] = "C";
    distractSymbol[16][1] = "7";
    distractSymbol[16][2] = "X";

    //A1B2C3
    distractSymbol[17][0] = "8";
    distractSymbol[17][1] = "E";
    distractSymbol[17][2] = "P";
    distractSymbol[17][3] = "D";

    //MUSTA
    distractSymbol[18][0] = "0";
    distractSymbol[18][1] = "5";
    distractSymbol[18][2] = "R";
    distractSymbol[18][3] = "Y";
    distractSymbol[18][4] = "D";
  }

  if (lang == "nl") {
    //println("reset distractors nl");

    //HORSE
    distractSymbol[1][0] = "A";
    distractSymbol[1][1] = "5";
    distractSymbol[1][2] = "Z";

    //1A2B3C
    distractSymbol[2][0] = "T";
    distractSymbol[2][1] = "7";
    distractSymbol[2][2] = "4";
    distractSymbol[2][3] = "D";

    //TRAIN
    distractSymbol[4][0] = "3";
    distractSymbol[4][1] = "C";
    distractSymbol[4][2] = "7";

    //A1B2C3 
    distractSymbol[5][0] = "6";
    distractSymbol[5][1] = "Z";
    distractSymbol[5][2] = "8";
    distractSymbol[5][3] = "F";

    //CHAIR
    distractSymbol[6][0] = "B";
    distractSymbol[6][1] = "3";
    distractSymbol[6][2] = "Q";
    distractSymbol[6][3] = "V";
    distractSymbol[6][4] = "5";

    //1234
    distractSymbol[7][0] = "W";
    distractSymbol[7][1] = "9";
    distractSymbol[7][2] = "M";
    distractSymbol[7][3] = "U";
    distractSymbol[7][4] = "7";

    //LIVE
    distractSymbol[8][0] = "G";
    distractSymbol[8][1] = "W";
    distractSymbol[8][2] = "0";

    //1L2IV3E
    distractSymbol[9][0] = "W";
    distractSymbol[9][1] = "Z";
    distractSymbol[9][2] = "R";
    distractSymbol[9][3] = "0";

    //TABLE
    distractSymbol[10][0] = "8";
    distractSymbol[10][1] = "2";
    distractSymbol[10][2] = "C";
    distractSymbol[10][3] = "0";
    distractSymbol[10][4] = "5";

    //TRUCK
    distractSymbol[12][0] = "Z";
    distractSymbol[12][1] = "X";
    distractSymbol[12][2] = "4";

    //ORANGE
    distractSymbol[14][0] = "U";
    distractSymbol[14][1] = "9";
    distractSymbol[14][2] = "H";
    distractSymbol[14][3] = "K";

    //FLOWER
    distractSymbol[16][0] = "C";
    distractSymbol[16][1] = "7";
    distractSymbol[16][2] = "X";

    //A1B2C3
    distractSymbol[17][0] = "8";
    distractSymbol[17][1] = "E";
    distractSymbol[17][2] = "P";
    distractSymbol[17][3] = "D";

    //WHITE
    distractSymbol[18][0] = "0";
    distractSymbol[18][1] = "5";
    distractSymbol[18][2] = "3";
    distractSymbol[18][3] = "A";
    distractSymbol[18][4] = "Y";
  }

  if (lang == "it") {
    //println("reset distractors it");

    //HORSE
    distractSymbol[1][0] = "A";
    distractSymbol[1][1] = "5";
    distractSymbol[1][2] = "Z";

    //1A2B3C
    distractSymbol[2][0] = "T";
    distractSymbol[2][1] = "7";
    distractSymbol[2][2] = "4";
    distractSymbol[2][3] = "D";

    //TRAIN
    distractSymbol[4][0] = "3";
    distractSymbol[4][1] = "X";
    distractSymbol[4][2] = "7";

    //A1B2C3 
    distractSymbol[5][0] = "6";
    distractSymbol[5][1] = "Z";
    distractSymbol[5][2] = "8";
    distractSymbol[5][3] = "F";

    //CHAIR
    distractSymbol[6][0] = "B";
    distractSymbol[6][1] = "3";
    distractSymbol[6][2] = "Q";
    distractSymbol[6][3] = "V";
    distractSymbol[6][4] = "8";

    //1234
    distractSymbol[7][0] = "W";
    distractSymbol[7][1] = "9";
    distractSymbol[7][2] = "M";
    distractSymbol[7][3] = "U";
    distractSymbol[7][4] = "7";

    //LIVE
    distractSymbol[8][0] = "G";
    distractSymbol[8][1] = "W";
    distractSymbol[8][2] = "0";

    //1L2IV3E
    distractSymbol[9][0] = "W";
    distractSymbol[9][1] = "Z";
    distractSymbol[9][2] = "V";
    distractSymbol[9][3] = "0";

    //TABLE
    distractSymbol[10][0] = "8";
    distractSymbol[10][1] = "2";
    distractSymbol[10][2] = "P";
    distractSymbol[10][3] = "0";
    distractSymbol[10][4] = "5";

    //TRUCK
    distractSymbol[12][0] = "Z";
    distractSymbol[12][1] = "X";
    distractSymbol[12][2] = "4";

    //ORANGE
    distractSymbol[14][0] = "U";
    distractSymbol[14][1] = "9";
    distractSymbol[14][2] = "H";
    distractSymbol[14][3] = "K";

    //FLOWER
    distractSymbol[16][0] = "Y";
    distractSymbol[16][1] = "7";
    distractSymbol[16][2] = "X";

    //A1B2C3
    distractSymbol[17][0] = "8";
    distractSymbol[17][1] = "E";
    distractSymbol[17][2] = "P";
    distractSymbol[17][3] = "D";

    //CORDA
    distractSymbol[18][0] = "7";
    distractSymbol[18][1] = "5";
    distractSymbol[18][2] = "E";
    distractSymbol[18][3] = "G";
    distractSymbol[18][4] = "Y";
  }

  if (lang == "da") {
    //println("reset distractors da");

    //HORSE
    distractSymbol[1][0] = "A";
    distractSymbol[1][1] = "5";
    distractSymbol[1][2] = "Z";

    //1A2B3C
    distractSymbol[2][0] = "T";
    distractSymbol[2][1] = "7";
    distractSymbol[2][2] = "4";
    distractSymbol[2][3] = "D";

    //TRAIN
    distractSymbol[4][0] = "3";
    distractSymbol[4][1] = "C";
    distractSymbol[4][2] = "7";

    //A1B2C3 
    distractSymbol[5][0] = "6";
    distractSymbol[5][1] = "Z";
    distractSymbol[5][2] = "8";
    distractSymbol[5][3] = "F";

    //CHAIR
    distractSymbol[6][0] = "B";
    distractSymbol[6][1] = "3";
    distractSymbol[6][2] = "Q";
    distractSymbol[6][3] = "V";
    distractSymbol[6][4] = "5";

    //1234
    distractSymbol[7][0] = "W";
    distractSymbol[7][1] = "9";
    distractSymbol[7][2] = "M";
    distractSymbol[7][3] = "U";
    distractSymbol[7][4] = "7";

    //LIVE
    distractSymbol[8][0] = "Q";
    distractSymbol[8][1] = "W";
    distractSymbol[8][2] = "0";

    //1L2IV3E
    distractSymbol[9][0] = "W";
    distractSymbol[9][1] = "Z";
    distractSymbol[9][2] = "R";
    distractSymbol[9][3] = "0";

    //TABLE
    distractSymbol[10][0] = "8";
    distractSymbol[10][1] = "2";
    distractSymbol[10][2] = "C";
    distractSymbol[10][3] = "0";
    distractSymbol[10][4] = "5";

    //TRUCK
    distractSymbol[12][0] = "Z";
    distractSymbol[12][1] = "X";
    distractSymbol[12][2] = "4";

    //ORANGE
    distractSymbol[14][0] = "U";
    distractSymbol[14][1] = "9";
    distractSymbol[14][2] = "H";
    distractSymbol[14][3] = "M";

    //FLOWER
    distractSymbol[16][0] = "C";
    distractSymbol[16][1] = "7";
    distractSymbol[16][2] = "X";

    //A1B2C3
    distractSymbol[17][0] = "8";
    distractSymbol[17][1] = "E";
    distractSymbol[17][2] = "P";
    distractSymbol[17][3] = "D";

    //WHITE
    distractSymbol[18][0] = "0";
    distractSymbol[18][1] = "5";
    distractSymbol[18][2] = "R";
    distractSymbol[18][3] = "X";
    distractSymbol[18][4] = "Y";
  }
}

void switchLanguage(String lang) {


  /*
   “en” – for English
   “fi” – for Finnish
   “it” – for Italian
   “da” – for Danish
   “nl” – for Dutch
   
   actualRoundMessages[0] = "Very good.  Now let's start the game.";
   actualRoundMessages[1] = "Excellent!  Let's keep going.";
   actualRoundMessages[2] = "Nice work!  Let's try some more.";
   actualRoundMessages[3] = "That's great!  Just one more set.";
   
   */

  //println("change language to: " + language);  
  //tutImage[0] = loadImage("htpPractice.PNG");

  if (lang == "fi") {
    bg = loadImage("background_fi.png");
    tutImage[0] = loadImage("htp1_fi.PNG");
    tutImage[1] = loadImage("htp2_fi.PNG"); 
    tutImage[2] = loadImage("htp3_fi.PNG"); 
    tutImage[3] = loadImage("htp4_fi.PNG"); 
    tutImage[4] = loadImage("htp5_fi.PNG"); 
    tutImage[5] = loadImage("htp6_fi.PNG"); 
    tutImage[6] = loadImage("htp7_fi.PNG"); 
    tutImage[7] = loadImage("htp8_fi.PNG");
    tutImage[8] = loadImage("htpPractice_fi.PNG");

    actualRoundMessages[0] = "Hyvä! Aloitetaan sitten varsinainen peli.";
    actualRoundMessages[1] = "Erinomaista! Jatketaan…";
    actualRoundMessages[2] = "Hyvää työtä! Jatketaan vielä…";
    actualRoundMessages[3] = "Upeaa! Vielä yksi sarja.";
  }

  if (lang == "it") {
    bg = loadImage("background_it.png");
    tutImage[0] = loadImage("htp1_it.PNG");
    tutImage[1] = loadImage("htp2_it.PNG"); 
    tutImage[2] = loadImage("htp3_it.PNG"); 
    tutImage[3] = loadImage("htp4_it.PNG"); 
    tutImage[4] = loadImage("htp5_it.PNG"); 
    tutImage[5] = loadImage("htp6_it.PNG"); 
    tutImage[6] = loadImage("htp7_it.PNG"); 
    tutImage[7] = loadImage("htp8_it.PNG");
    tutImage[8] = loadImage("htpPractice_it.PNG");

    actualRoundMessages[0] = "Molto buona . Ora cominciamo il gioco.";
    actualRoundMessages[1] = "Eccellente ! Andiamo avanti.";
    actualRoundMessages[2] = "Bel lavoro ! Proviamo un po ' di più.";
    actualRoundMessages[3] = "È fantastico ! Solo un altro set.";
  }

  if (lang == "da") {
    bg = loadImage("background_da.png");
    tutImage[0] = loadImage("htp1_da.PNG");
    tutImage[1] = loadImage("htp2_da.PNG"); 
    tutImage[2] = loadImage("htp3_da.PNG"); 
    tutImage[3] = loadImage("htp4_da.PNG"); 
    tutImage[4] = loadImage("htp5_da.PNG"); 
    tutImage[5] = loadImage("htp6_da.PNG"); 
    tutImage[6] = loadImage("htp7_da.PNG"); 
    tutImage[7] = loadImage("htp8_da.PNG");
    tutImage[8] = loadImage("htpPractice_da.PNG");

    actualRoundMessages[0] = "Meget godt. Lad os nu starte spillet.";
    actualRoundMessages[1] = "Fremragende ! Lad os holde i gang.";
    actualRoundMessages[2] = "Flot arbejde ! Lad os prøve nogle flere.";
    actualRoundMessages[3] = "Det er godt ! Bare et sæt.";
  }

  if (lang == "nl") {
    bg = loadImage("background_nl.png");
    tutImage[0] = loadImage("htp1_nl.PNG");
    tutImage[1] = loadImage("htp2_nl.PNG"); 
    tutImage[2] = loadImage("htp3_nl.PNG"); 
    tutImage[3] = loadImage("htp4_nl.PNG"); 
    tutImage[4] = loadImage("htp5_nl.PNG"); 
    tutImage[5] = loadImage("htp6_nl.PNG"); 
    tutImage[6] = loadImage("htp7_nl.PNG"); 
    tutImage[7] = loadImage("htp8_nl.PNG");
    tutImage[8] = loadImage("htpPractice_nl.PNG");

    actualRoundMessages[0] = "Zeer goed . Laten we nu eens beginnen met het spel.";
    actualRoundMessages[1] = "Uitstekend! Laten we blijven gaan.";
    actualRoundMessages[2] = "Nice work! Laten we proberen wat meer.";
    actualRoundMessages[3] = "Dat is geweldig ! Nog een set.";
  }


  //  if (lang == "en") {
  //    seq[0] = "1234"; 
  //    seq[1] = "HORSE"; 
  //    seq[2] = "1A2B3C";
  //    seq[3] = "1234";
  //    seq[4] = "TRAIN";
  //    seq[5] = "A1B2C3";
  //    seq[6] = "CHAIR";
  //    seq[7] = "1234";
  //    seq[8] = "LIVE";
  //    seq[9] = "1L2IV3E";
  //    seq[10] = "TABLE";
  //    seq[11] = "1234567";
  //    seq[12] = "TRUCK";
  //    seq[13] = "1T2R3U4C5K";
  //    seq[14] = "ORANGE";
  //    seq[15] = "76543";
  //    seq[16] = "FLOWER";
  //    seq[17] = "A1B2C3";
  //    seq[18] = "WHITE";
  //  }

  // fi
  if (lang == "fi") {

    seq[0] = "1234"; 
    seq[1] = "KAHVI"; 
    seq[2] = "1A2B3C";

    seq[3] = "1234";
    seq[4] = "SORMI";
    seq[5] = "A1B2C3";
    seq[6] = "TUOLI";

    seq[7] = "1234";
    seq[8] = "KATU";
    seq[9] = "1K2A3TU";
    seq[10] = "KOIRA";

    seq[11] = "1234567";
    seq[12] = "MAITO";
    seq[13] = "1T2R3U4C5K";
    seq[14] = "RUSKEA";

    seq[15] = "76543";
    seq[16] = "HUVILA";
    seq[17] = "A1B2C3";
    seq[18] = "MUSTA";
  }

  if (lang == "it") {

    seq[0] = "1234"; 
    seq[1] = "VIALE"; 
    seq[2] = "1A2B3C";

    seq[3] = "1234";
    seq[4] = "ACQUA";
    seq[5] = "A1B2C3";
    seq[6] = "SEDIA";

    seq[7] = "1234";
    seq[8] = "ROSA";
    seq[9] = "1R2O3SA";
    seq[10] = "CUORE";

    seq[11] = "1234567";
    seq[12] = "FIORE";
    seq[13] = "1T2R3U4C5K";
    seq[14] = "CAMION";

    seq[15] = "76543";
    seq[16] = "BIANCO";
    seq[17] = "A1B2C3";
    seq[18] = "CORDA";
  }

  if (lang == "nl") {

    seq[0] = "1234"; 
    seq[1] = "BLAUW"; 
    seq[2] = "1A2B3C";

    seq[3] = "1234";
    seq[4] = "TREIN";
    seq[5] = "A1B2C3";
    seq[6] = "STOEL";

    seq[7] = "1234";
    seq[8] = "HUIS";
    seq[9] = "1H2U3IS";
    seq[10] = "TAFEL";

    seq[11] = "1234567";
    seq[12] = "BLOEM";
    seq[13] = "1T2R3U4C5K";
    seq[14] = "ORANJE";

    seq[15] = "76543";
    seq[16] = "VINGER";
    seq[17] = "A1B2C3";
    seq[18] = "ZWART";
  }

  if (lang == "da") {

    seq[0] = "1234"; 
    seq[1] = "RUNDE"; 
    seq[2] = "1A2B3C";

    seq[3] = "1234";
    seq[4] = "TOMAT";
    seq[5] = "A1B2C3";
    seq[6] = "HUSET";

    seq[7] = "1234";
    seq[8] = "GADE";
    seq[9] = "1G2A3DE";
    seq[10] = "TABEL";

    seq[11] = "1234567";
    seq[12] = "SPARK";
    seq[13] = "1T2R3U4C5K";
    seq[14] = "KVINDE";

    seq[15] = "76543";
    seq[16] = "BLOMST";
    seq[17] = "A1B2C3";
    seq[18] = "TABEL";
  }

  resetDistractors(lang);

  // release ver will have preset positions and distractor symbols 
  for ( int i = 0; i < 19; i++ ) { //19
    for ( int c = 0; c < characterNumInThisSeq[i]; c++ ) {
      // temp setup for demo 
      // non random for release 

      // old way of setting positions with overlap
      //charPosX[i][c] = (int)random(40, 850); //100*c;
      //charPosY[i][c] = (int)random(200, 500);//100*c; 

      //random positions for testing
      //int posSel = (int)random(0, masterPos[i].size());
      //PVector newPos = (PVector)masterPos[i].get(posSel);
      //charPosX[i][c] = newPos.x; 
      //charPosY[i][c] = newPos.y; 
      if ( i == curSel) {
        //println( "round: " + i + " " + "circle: " + c + " x: " + newPos.x + " y: " + newPos.y );
      }
      //masterPos[i].remove(posSel); 

      //character[i][c] = new CharObj(charPosX[i][c], charPosY[i][c], str(seq[i].charAt(c)));
      character[i][c] = new CharObj(charPos[i][c].x, charPos[i][c].y, str(seq[i].charAt(c)));
    }

    // for now same number of distractors as characters
    //for ( int d = 0; d < characterNumInThisSeq[i]; d++ ) {
    for ( int d = 0; d < numDistractor[i]; d++ ) {

      //distractPosX[i][d] = (int)random(40, 850);
      //distractPosY[i][d] = (int)random(200, 500);

      //int posSel = (int)random(0, masterPos[i].size());
      //PVector newPos = (PVector)masterPos[i].get(posSel);
      //distractPosX[i][d] = newPos.x; 
      //distractPosY[i][d] = newPos.y; 

      //masterPos[i].remove(posSel); 

      // distractSymbol[i][d] = str(alphabet.charAt(random(0, 35)));  
      // non random 

      //distractor[i][d] = new DistractorObj(distractPosX[i][d], distractPosY[i][d], distractSymbol[i][d]);
      distractor[i][d] = new DistractorObj(distPos[i][d].x, distPos[i][d].y, distractSymbol[i][d]);
      if ( i == curSel) {
        //println( "round: " + i + " " + "distracg: " + d + " x: " + newPos.x + " y: " + newPos.y + " " + distractor[i][d].symbol);
      }
    }
  }
}

boolean switchLang = false; 
boolean callGetLanguage = false;
void draw() {

  if (!callGetLanguage) {
    //getLanguage(); 
    callGetLanguage = true;
    printLangOnce = false;
  }
  
  language = finalLanguage; //fi, da, nl, it, en

  if (!printLangOnce && language != null && language != " ") {
    if (switchLang == false) {
      switchLanguage(language);
      //println("switchLang"); 
      switchLang = true;
    }
  }

  /*
  if (language != null && printLangOnce) {
   //println("chosen language: english, finnish, danish, dutch, italian? " + language);
   printLangOnce = false;
   }
   
   
   if (!printLangOnce && language != null && language != " ") {
   if (switchLang == false) {
   switchLanguage(language);
   //println("switchLang"); 
   switchLang = true;
   }
   }*/

  mousePos.x = mouseX;
  mousePos.y = mouseY; 

  if ( true /*!printLangOnce && switchLang*/  ) {

    //tutorial mode behavior
    if (tutorialMode) {
      image(tutImage[tutorialInc], 0, 0);

      if (isTouch) {

        if (tutorialInc == 8) {
          if ( mousePos.dist(okButton) < 160 ) {
            tutorialInc++;
          }
        }

        if (tutorialInc < 8) {
          tutorialInc++;
        }

        if (tutorialInc >= 9) {
          tutorialMode = false;

          //language = getLanguage();
          //println("chosen language: english, finnish, danish, dutch, italian? " + language);
        }
        isTouch = false;
      }

      if (tutorialInc < 8) {
        fill(#000000);
        textSize(24); 
        textAlign(CENTER); 
        if (language == "en") {
          text("Touch anywhere to continue", 500, 565);
        }
      }

      //println(tutorialInc);
    } else {

      //set start time of current level
      /*
      if ( startTimeOfCurrentScreen == -1 && !endTimer ) {
       startTimeOfCurrentScreen = millis();
       //println("Start timer");
       endTimer = true; 
       timeIsUp = false;
       }
       
       if ( millis() - startTimeOfCurrentScreen > 5000 && startTimeOfCurrentScreen != -1 ) {
       println("Time is up!");
       //timeIsUp = true; 
       startTimeOfCurrentScreen = -1
       }
       
       if (timeIsUp) {
       //finished = true;
       }*/

      image(bg, 0, 0); 

      textAlign(LEFT); 

      fill(#FFFFFF);
      text(seq[seqInc], 365, 140); //290

        fill(#FFCC00);
      text(highlighter, 365, 140); 

      touchPos.set(touchPosX, touchPosY, 0);

      // raw canvas calls
      //pctx.fillStyle = "#999333";
      //pctx.fillRect(0, 0, docSizeX, docSizeY);
      //pctx.clearRect(50, 50, 150, 150);
      /*
  pctx.strokeStyle = "#FFFFFF";
       pctx.fillStyle = "#FFFF00";
       pctx.beginPath();
       pctx.arc(touchPosX, touchPosY, 20*devicePixelRatioX, 0, Math.PI*2, true);
       pctx.closePath();
       pctx.stroke();
       pctx.fill();*/


      for ( int i = 0; i < characterNumInThisSeq[seqInc]; i++) {
        character[seqInc][i].display();
      }

      for ( int i = 0; i < numDistractor[seqInc]; i++) {
        distractor[seqInc][i].display();
      }

      //timeElapsed = millis();//round(millis()/1000); 
      printElapsed( millis() );

      //fill(255, 50);
      //rect(100, 100, 400, 300);


      if (isTouch && !finished && !showRoundText && !tutorialMode) {

        for ( int i = 0; i < numDistractor[seqInc]; i++ ) {
          if (distractor[seqInc][i].dist < 30) {
            distractor[seqInc][i].setError();
            wrongSelects++;
            correctSel = false;
            distractSel = 1; 
            symbolTouched = distractor[seqInc][i].symbol; 
            //call saveJson
            saveJson();
          }
        }

        if (character[seqInc][SeqOrder].dist < 30) {
          // set graphic of character to correctly selected
          character[seqInc][SeqOrder].setSelected(); 
          correctSel = true; 
          distractSel = 0; 
          //char tempChar = character[seqInc][SeqOrder].symbol;
          symbolTouched = character[seqInc][SeqOrder].symbol; 

          //println(tempChar); 
          //println(int(tempChar)); 


          //call saveJson
          saveJson(); 

          // since the user is making progess, select all previous letters to correctly selected
          for (int nx = 0; nx < SeqOrder; nx++) {
            character[seqInc][nx].setSelected();
          }
          // set all future letters back to yellow if they are in error state
          if (SeqOrder+1 < characterNumInThisSeq[seqInc]) {
            for (int f = SeqOrder+1; f < characterNumInThisSeq[seqInc]; f++) {
              if (!character[seqInc][f].normal) {
                character[seqInc][f].setNormal();
              }
            }
          }
          // set all distractors to normal
          for ( int i = 0; i < numDistractor[seqInc]; i++ ) {
            distractor[seqInc][i].setNormal();
          }

          // set all distractors to normal?
          //      for (int d = 0; d < numDistractor[seqInc]; d++) {
          //        distractor[seqInc][d].setNormal();
          //      }

          highlighter += seq[seqInc].charAt(incChar);
          if (SeqOrder < characterNumInThisSeq[seqInc]) {
            SeqOrder++;
          }
          if (incChar < seq[seqInc].length() ) {
            incChar++;
          }
        } else {
          // loop through all other character 
          // if is one selected set to x to mark incorrectly selected
          for ( int i = 0; i < characterNumInThisSeq[seqInc]; i++ ) {
            if ( i != SeqOrder ) {
              if (character[seqInc][i].dist < 30) {
                //set incorrect character graphic 
                character[seqInc][i].setError();
                correctSel = false; 
                distractSel = 0; 
                symbolTouched = character[seqInc][i].symbol; 
                //call saveJson
                saveJson(); 
                wrongSelects++;
              }
            }
          }
        }

        isTouch = false;
      }

      // reset for next word and check if finished 
      if (incChar >= seq[seqInc].length() ) {

        if (seqInc == 2) {
          showRoundText = true; 
          roundTracker = 0;
        } else if (seqInc == 6) {
          showRoundText = true; 
          roundTracker = 1;
        } else if (seqInc == 10) {
          showRoundText = true; 
          roundTracker = 2;
        } else if (seqInc == 14) {
          showRoundText = true; 
          roundTracker = 3;
        } else {
          if (timeIsUp == false) {
            if (incChar >= seq[seqInc].length() ) {
              if ( seqInc < seq.length()-1 ) {
                seqInc++; 
                //println("new seq"); 
                endTimer = false; 
                highlighter = "";
                incChar = 0; 
                SeqOrder = 0;
              } else if (seqInc == seq.length()-1 ) {
                finished = true;
              }
            }
          }
        }

        //show 
        if (showRoundText) {
          fill(0, 0, 0, 255);
          noStroke(); 
          rect(0, 0, docSizeX, docSizeY); 
          textAlign(CENTER); 
          fill(#FFFFFF);
          textSize(35); 
          text(actualRoundMessages[roundTracker], docSizeX*0.5f, 200);
          if (roundTracker == 0) {
            if (language == "en" || language == " " || language == null) {
              text("Remember to touch as quickly and accurately as you can.", docSizeX*0.5f, 250);
            }
            if (language == "fi") {
              text("Muista klikata (tai koskettaa) niin nopeasti ja tarkasti kuin pystyt.", docSizeX*0.5f, 250);
            }
            if (language == "da") {
              text("Rember til at klikke så hurtigt og accuarately som du kan.", docSizeX*0.5f, 250);
            }
            if (language == "nl") {
              text("Rember om zo snel en accuarately als je kunt klikken.", docSizeX*0.5f, 250);
            }
            if (language == "it") {
              text("Rember a cliccare più velocemente e accuarately possibile.", docSizeX*0.5f, 250);
            }
          }
          if (roundTracker == 0) {
            if (language == "en" || language == " " || language == null) {
              text("Touch here to start", docSizeX*0.5f, 371);
            }
            if (language == "fi") {
              text("Klikkaa (tai kosketa) tästä aloittaaksesi", docSizeX*0.5f, 371);
            }
            if (language == "da") {
              text("Klik her for at starte", docSizeX*0.5f, 371);
            }
            if (language == "nl") {
              text("Klik hier om te beginnen", docSizeX*0.5f, 371);
            }
            if (language == "it") {
              text("Clicca qui per iniziare", docSizeX*0.5f, 371);
            }

            pushMatrix();
            translate(docSizeX*0.5f, 361); 
            rectMode(CENTER); 
            fill(0, 0, 0, 0);
            stroke(#FFFFFF); 
            rect(0, 0, 600, 50); //300 width of button 
            rectMode(CORNER);
            popMatrix();
          } else {
            text("OK", docSizeX*0.5f, 371);
            pushMatrix();
            translate(docSizeX*0.5f, 358); 
            rectMode(CENTER); 
            fill(0, 0, 0, 0);
            stroke(#FFFFFF); 
            rect(0, 0, 600, 50); //300
            rectMode(CORNER);
            popMatrix();
          }
        }


        if (onMobileDevice) {

          if ( touchPos.dist(okButton) < 300 && showRoundText && isTouch) { 
            showRoundText = false;
            if (!showRoundText) {
              if (incChar >= seq[seqInc].length() ) {
                if ( seqInc < seq.length()-1 ) {
                  seqInc++; 
                  //println("finished level from onMobileDevice"); 

                  highlighter = "";
                  incChar = 0; 
                  SeqOrder = 0;
                } else if (seqInc == seq.length()-1 ) {
                  finished = true;
                }
              }
            }
            isTouch = false;
          }
        }
      }

      if (finished) {

        if (finished && timeIsUp) {

          // black curtain
          fill(0, 0, 0, 255);
          noStroke(); 
          rect(0, 0, docSizeX, docSizeY); 

          textAlign(CENTER); 
          fill(#FFFFFF);
          textSize(39); 
          text("Time is up", docSizeX*0.5f, 300);
          //text("Thank you so much", docSizeX*0.5f, 370);
        } else {

          // black curtain
          fill(0, 0, 0, 255);
          noStroke(); 
          rect(0, 0, docSizeX, docSizeY); 

          textAlign(CENTER); 
          fill(#FFFFFF);
          textSize(39); 

          if (language == "en" || language == " " || language == null) {
            text("Wonderful! You're done", docSizeX*0.5f, 300);
            text("Thank you so much", docSizeX*0.5f, 370);
          }

          if (language == "fi") {
            text("Hienoa! Peli on pelattu loppuun.", docSizeX*0.5f, 300);
            text("Kiitos!", docSizeX*0.5f, 370);
          }

          if (language == "da") {
            text("Vidunderligt! Du er færdig", docSizeX*0.5f, 300);
            text("Tak så meget", docSizeX*0.5f, 370);
          }

          if (language == "nl") {
            text("Geweldig! U bent klaar", docSizeX*0.5f, 300);
            text("Dank je wel", docSizeX*0.5f, 370);
          }

          if (language == "it") {
            text("Meraviglioso ! Il gioco è fatto", docSizeX*0.5f, 300);
            text("Vi ringrazio tanto", docSizeX*0.5f, 370);
          }

          // when game is finished 
          if (sendOnce) {
            sendToServer(); 
            sendOnce = false;
          }

          noFill();

          stroke(#FFFFFF);
          if (isTouch) {
            stroke(#00FF33);
          }
          pushMatrix(); 
          translate(docSizeX*0.5f, 487); 
          rectMode(CENTER); 
          rect(0, 0, 600, 50); 
          rectMode(CORNER); 
          popMatrix();

          if (language == "en") {
            text("Exit", docSizeX*0.5f, 500);
          }
          if (language == "fi") {
            text("Poistu pelistä", docSizeX*0.5f, 500);
          }
          if ( isTouch ) {
            if ( mousePos.dist(exitButton) < 150 ) {
              // go to another page 
              exitJS();
            }
            isTouch = false;
          }
        }
      }

      fill(#FFFFFF); 
      //text(seqInc+1, 30, 50); 
      //text(wrongSelects, 90, 50);

      //drawGrid();


      // hit zones
      //ellipse(500, 371, 50, 50); 

      // show dot to indicate non ipad device
      /*
    if (!onMobileDevice && mousePressedFlag) {
       ellipse( 10, 10, 5, 5 );
       }*/
    }
  } // switched lang
}

void saveJson() {
  gameLevel = seqInc + 1;
  saveToJsonTouches();
}


PVector mousePos = new PVector(mouseX, mouseY); 
PVector okButton = new PVector(500, 371); 
PVector exitButton = new PVector(500, 450); 

void mousePressed() {
  // in mousePressed() for testing on PC 

  if (!onMobileDevice && !showRoundText) {
    mousePressedFlag = true; 
    touchPosX = mouseX;
    touchPosY = mouseY; 
    isTouch = true;
  }

  if (!onMobileDevice) {
    // press ok 
    if ( mousePos.dist(okButton) < 300 && showRoundText ) { //160
      showRoundText = false;
      if (!showRoundText) {
        if (incChar >= seq[seqInc].length() ) {
          if ( seqInc < seq.length-1 ) {
            seqInc++; 
            //println("finished level from mousePressed"); 

            highlighter = "";
            incChar = 0; 
            SeqOrder = 0;
          } else if (seqInc == seq.length-1 ) {
            finished = true;
          }
        }
      }
    }
  }


  //gameLevel = seqInc+1; //js
  //saveToJsonTouches();
}

/*
void setupFixedPos() {
 
 //fixed position of circles
 fixedPos = new PVector[19][19];
 // set from photoshop
 fixedPos[0][0] = new PVector(50, 50); 
 fixedPos[0][1] = new PVector(50, 50);
 fixedPos[0][2] = new PVector(50, 50);
 fixedPos[0][3] = new PVector(50, 50);
 }*/

void setupGridPos() {

  masterPos = new ArrayList[19]; 
  for (int i = 0; i < 19; i++) {
    masterPos[i] = new ArrayList();
  }
  // 40 possible positions
  int startingX = 93;
  int startingY = 205;
  int spacing   = 80;

  for (int i = 0; i < 19; i++) {
    for (int x = 0; x < 10; x++) {
      for (int y = 0; y < 5; y++) {
        masterPos[i].add(new PVector(startingX+(spacing*x), startingY+(spacing*y)));
      }
    }
  }
}

void drawGrid() {

  for (int y = 0; y < masterPos[0].size (); y++) {
    PVector newPos = (PVector)masterPos[0].get(y);
    ellipse(newPos.x, newPos.y, 10, 10);
  }
}

