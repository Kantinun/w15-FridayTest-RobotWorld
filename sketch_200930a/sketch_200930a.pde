class Wall{
  int x,y;
  Wall(){
  }
  void draw(){
  }
}
class Robot{
  int x,y;
  Robot(int posX,int posY){
    x = posX;
    y =posY;
  }
  void draw(){
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
  World(int co,int ro){
    column = co;
    row =ro;
  }
  void draw(){
  }
}
