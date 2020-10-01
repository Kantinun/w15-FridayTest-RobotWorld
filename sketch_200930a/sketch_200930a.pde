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
  int velX,velY;
  
  Robot(int posX,int posY){
    x = posX;
    y =posY;
    sizeX = posX*2*0.5;
    sizeY = posY*2*0.5;
    velX = posX*2;
    velY = posY*2;
    
  }
  void draw(){
    fill(255,255,0);
    noStroke();
    ellipseMode(CENTER);
    ellipse(x,y,sizeX,sizeY);
  }
  void move(int  key){
     if(key== UP){y -= velY;}
     if(key== DOWN){y += velY;}
     if(key== LEFT){x -= velX;}
     if(key== RIGHT){x += velX;}
     if(x<width/(w.column*2)){x = width/(w.column*2);}
     if(x>width-(width/(w.column*2))){x = width-(width/(2*w.column));}
     if(y<height/(w.row*2)){y =height/(w.row*2);}
     if(y>height-(height/(w.row*2))){ y = height-(height/(w.row*2));}
  }
  boolean checkWall(Wall wall){
    return true;
  }
}

class Target{
  int x,y;
  
  Target(int co,int ro){
    x = (int(random(0,co))*width/co)+width/(co*2);
    y = (int(random(0,ro))*height/ro)+height/(ro*2);
  }
  
  void randomPosition(){
    x = (int(random(0,w.column))*width/w.column)+width/(w.column*2);
    y = (int(random(0,w.row))*height/w.row)+height/(w.row*2);
  }
  
  void draw(){
    fill(255,0,0);
    noStroke();
    rectMode(CENTER);
    rect(x,y,0.25*width/w.column,0.25*height/w.row);
  }
}

class World{
  int column,row;
  Target t;
  Robot r;
  int robotDelay,maxRobotDelay;
  
  World(int co,int ro){
    column = co;
    row =ro;
    maxRobotDelay = 7;
    robotDelay = maxRobotDelay;
    
    r = new Robot(width/(co*2),height/(row*2));
    
    t = new Target(column,row);
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
    t.draw();
    
    r.draw();
    
    if(keyPressed&&robotDelay>maxRobotDelay){
      if(key==CODED){
        r.move(keyCode);
        robotDelay =0;
      }
    }
    robotDelay++;
    
    if(dist(r.x,r.y,t.x,t.y)==0){t.randomPosition();}
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
