class Wall{
  int x,y;
  float sizeX,sizeY;
  
  Wall(int co,int ro){
    x = (int(random(0,co))*width/co)+width/(co*2);
    y = (int(random(1,ro))*height/ro)+height/(ro*2);
    sizeX=width/co;
    sizeY=height/ro;
  }
  
  void draw(){
    fill(150,255,150);
    noStroke();
    rectMode(CENTER);
    rect(x,y,sizeX,sizeY);
  }
}

class Robot{
  int x,y;
  float sizeX,sizeY;
  int velX,velY;
  int angle;
  
  Robot(int posX,int posY){
    x = posX;
    y =posY;
    angle =0;
    sizeX = posX*.5;
    sizeY = posY*.5;
    velX = posX*2;
    velY = posY*2;
  }
  
  void draw(){
    strokeWeight(8);
    stroke(255);
    if(abs(angle)==360){angle =0;}
    if(angle == 0){
      line(x+sizeX,y+sizeY,x-sizeX,y+sizeY);
      stroke(255,255,0);
      line(x-sizeX,y+sizeY,x,y-sizeY);
      line(x,y-sizeY,x+sizeX,y+sizeY);  
    }
    if(angle == 90 || angle ==-270){
      line(x+sizeX,y+sizeY,x+sizeX,y-sizeY);
      stroke(255,255,0);
      line(x+sizeX,y-sizeY,x-sizeX,y); 
      line(x-sizeX,y,x+sizeX,y+sizeY);
    }
    if(abs(angle) == 180){
      line(x-sizeX,y-sizeY,x+sizeX,y-sizeY);
      stroke(255,255,0);
       line(x,y+sizeY,x-sizeX,y-sizeY); 
       line(x+sizeX,y-sizeY,x,y+sizeY);
    }
    if(angle == 270 || angle==-90){
      line(x-sizeX,y-sizeY,x-sizeX,y+sizeY);
      stroke(255,255,0);
       line(x+sizeX,y,x-sizeX,y-sizeY); 
       line(x-sizeX,y+sizeY,x+sizeX,y);
    }
  }
  void moveForward(){
    if(angle==0){y -= velY;}
    if(abs(angle)==180){y+=velY;}
    if(angle == 270 || angle==-90){x+=velX;}
    if(angle == 90 || angle ==-270){x-=velX;}
     
    if(x<width/(w.column*2)){x = width/(w.column*2);}
    if(x>width-(width/(w.column*2))){x = width-(width/(2*w.column));}
    if(y<height/(w.row*2)){y =height/(w.row*2);}
    if(y>height-(height/(w.row*2))){ y = height-(height/(w.row*2));}
  }
  void moveBackward(){
    if(angle==0){y += velY;}
    if(abs(angle)==180){y-=velY;}
    if(angle == 270 || angle==-90){x-=velX;}
    if(angle == 90 || angle ==-270){x+=velX;}
    
    if(x<width/(w.column*2)){x = width/(w.column*2);}
    if(x>width-(width/(w.column*2))){x = width-(width/(2*w.column));}
    if(y<height/(w.row*2)){y =height/(w.row*2);}
    if(y>height-(height/(w.row*2))){ y = height-(height/(w.row*2));}
  }
  void turnLeft(){
    angle+=90;
  }
  void turnRight(){
    angle-=90;
  }
  boolean checkWall(Wall wall){
    if(dist(x,y,wall.x,wall.y)==0){return true;}
    else{return false;}
  }
  
  void bounce(int key){
    if(key == CODED){
    if(keyCode == DOWN){
       if(angle==0){y -= velY;}
       if(abs(angle)==180){y+=velY;}
       if(angle == 270 || angle==-90){x+=velX;}
       if(angle == 90 || angle ==-270){x-=velX;}
     }
     if(keyCode == UP){
       if(angle==0){y += velY;}
       if(abs(angle)==180){y-=velY;}
       if(angle == 270 || angle==-90){x-=velX;}
       if(angle == 90 || angle ==-270){x+=velX;}
     }
  }
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
  
  boolean checkWall(Wall wall){
    if(dist(x,y,wall.x,wall.y)==0){return true;}
    else{return false;}
  }
}

class World{
  int column,row;
  Target t;
  Robot r;
  InputProcessor input;
  int robotDelay,maxRobotDelay;
  ArrayList<Wall> wall = new ArrayList<Wall>();
  
  World(int co,int ro,int numWall){
    column = co;
    row =ro;
    maxRobotDelay = 7;
    robotDelay = maxRobotDelay;
    
    r = new Robot(width/(co*2),height/(row*2));
    
    t = new Target(column,row);
    
    input = new InputProcessor(38,40,37,39);
    
    for(int  i=0;i<numWall;i++){
      wall.add(new Wall(column,row));
    }
  }
  
  void draw(){
    strokeWeight(1);
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
    for(Wall temp:wall){
      if(t.checkWall(temp)){t.randomPosition();}
    }
    t.draw();
    
    for(Wall wall:wall){
      wall.draw();
    }
    
    r.draw();
    
    if(keyPressed&&robotDelay>maxRobotDelay){
        input.robotMove(key,r);
        robotDelay =0;
        for(Wall tempWall:wall){
          if(r.checkWall(tempWall)){r.bounce(key);}
        }
    }
    robotDelay++;
    
    if(dist(r.x,r.y,t.x,t.y)==0){t.randomPosition();}
  }
}

class InputProcessor{
  int forward,backward,left,right;
  InputProcessor(int forwardKey,int backwardKey,int leftKey,int rightKey){
    forward = forwardKey;
    backward = backwardKey;
    left = leftKey;
    right = rightKey;
  }
  
  void robotMove(int key,Robot ro){
    if(key == CODED){
      if(keyCode==forward){ro.moveForward();}
      if(keyCode==backward){ro.moveBackward();}
      if(keyCode==left){ro.turnLeft();}
      if(keyCode==right){ro.turnRight();}
    }
  }
}

World w;
void setup(){
  size(600,600);
  w = new World(6,6,5);
}
void draw(){
  background(0);
  w.draw();
  w.update();
}
