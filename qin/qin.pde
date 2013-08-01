import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

int DEFAULT_XIAN_NUM =7;
Xian[] xian;
float[] xianHight;
float vibOffset[]={10,-9,8,-7,6,-5,4,-3,2,-1,0,0};
int FrameRate = 30;
int DEFAULT_PLAY_TIME = 2 ;// 2s play time
float EPS = 3;
float DEFAULT_AMP=6;
void setup(){
  size(640,360);
  frameRate(FrameRate);
  // draw static Xian 
  xianHead=width;
  xianTail=0;
  xianTop = height*0.2;
  xianBottom = height*0.95;
  
  xianOffset=(xianBottom-xianTop)/(DEFAULT_XIAN_NUM-1);
  xian = new Xian[DEFAULT_XIAN_NUM];
  xianHeight = new float[DEFAULT_XIAN_NUM];
  for(int i = 0; i<DEFAULT_XIAN_NUM; ++i){
     
     currentXianHeight = xianTop + xianOffset * i;
     xianHeight[i] = currentXianHeight;
     xian[i]= new Xian(i+1,xianHead,currentXianHeight,xianTail,currentXianHeight);
  }
  
  fCount = 0;
  vibCount = 0;
 // xian[1].vibrate(8,50,150);
  
}
  
// Drag (click and hold) your mouse across the 
// image to change the value of the rectangle
void mouseDragged() {
}

void mouseMoved(){
   for(int i = 0; i<DEFAULT_XIAN_NUM;i++){
     if(xian[i].crossed(pmouseX,pmouseY,mouseX,mouseY)){
       play(xian[i],0,mouseX);
     }
   }
       
}
void play (Xian x, float l, float r){ // xian, lefthand position, right hand position, amplitude
  x.vibrate(DEFAULT_AMP,l,r);
}
void draw(){
  
  background(0);
  for (int i = 0; i < DEFAULT_XIAN_NUM; ++i){
    xian[i].update();
    xian[i].draw();
  }
}
