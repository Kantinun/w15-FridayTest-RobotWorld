class Wall{
  int x,y;
  Wall(){
  }
  void draw(){
  }
}

class Robot{
  int x,y;
  float sizeX,sizeY;
  Robot(int posX,int posY){
    x = posX;
    y =posY;
    sizeX = posX*2*0.5;
    sizeY = posY*2*0.5;
  }
  void draw(){
    fill(255,255,0);
    noStroke();
    ellipseMode(CENTER);
    ellipse(x,y,sizeX,sizeY);
  }
  void move(char direction){
  }
  boolean checkWall(Wall wall){
    return true;
  }
}

class Target{
  int x,y;
  Target(){
  }
  void randomPosition(){
  }
  void draw(){
  }
}
class World{
  int column,row;
  Robot r;
  
  World(int co,int ro){
    column = co;
    row =ro;
    
    r = new Robot(width/(co*2),height/(row*2));
  }
  void draw(){
    for(int i=1;i<column;i++){  // draw column
      stroke(0,0,255);
      line(i*width/column,0,i*width/column,height);
    }
    for(int i=1;i<row;i++){  // draw row
      stroke(0,0,255);
      line(0,i*height/row,width,i*height/row);
    }
  }
  
  void update(){
    r.draw();
  }
}

World w;



void setup(){
  size(600,600);
  w = new World(6,6);
}
void draw(){
  background(0);
  w.draw();
  w.update();
}
