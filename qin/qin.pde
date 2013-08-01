int xianNum =7;
Xian[] xian;
float vibOffset[]={10,-9,8,-7,6,-5,4,-3,2,-1,0,0};
int fCount;
int vibCount;
int FrameRate = 30;
int time = 2 ;// 2s play time
void setup(){
  size(640,360);
  
  // draw static Xian 
  xianHead=width;
  xianTail=0;
  xianTop = height*0.2;
  xianBottom = height*0.95;
  
  xianOffset=(xianBottom-xianTop)/(xianNum-1);
  xian = new Xian[xianNum];
  for(int i = 0; i<xianNum; ++i){
     currentXianHeight = xianTop + xianOffset * i;
     xian[i]= new Xian(i+1,xianHead,currentXianHeight,xianTail,currentXianHeight);
  }
  
  fCount = 0;
  vibCount = 0;
  xian[1].vibrate(8,50,150);
  
}

void play (Xian x, float l, float r, float a){ // xian, lefthand position, right hand position, amplitude

}
void draw(){
  
  background(0);
  for (int i = 0; i < xianNum; ++i){
    xian[i].update();
    xian[i].draw();
  }
  
  fCount++;
  fCount=fCount%180;
}
