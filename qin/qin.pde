import ddf.minim.*;

int DEFAULT_XIAN_NUM =7;
Xian[] xian;
Hui[] hui;
int DEFAULT_HUI_NUM = 13;
float[] xianHight;
int FrameRate = 30;
int DEFAULT_PLAY_TIME = 3 ;// 2s play time
float DEFAULT_AMP=6;
float EPS = 5;
float xianHead;
float xianTail=0;
Minim minim;
PlayHistory history;
//MelodyManager melodyManager;
int mode; //1: nomal, 2:Melody

void setup(){
  size(1000,360);
  frameRate(FrameRate);
  minim = new Minim(this);
  
  history = new PlayHistory();
  // draw static Xian 
  xianHead=width;
  xianTail=0;
  float xianTop = height*0.2;
  float xianBottom = height*0.95;
  
  float xianOffset=(xianBottom-xianTop)/(DEFAULT_XIAN_NUM-1);
  EPS=xianOffset*0.3;
  xian = new Xian[DEFAULT_XIAN_NUM];
  float [] xianHeight = new float[DEFAULT_XIAN_NUM];
  for(int i = 0; i<DEFAULT_XIAN_NUM; ++i){
     
     float currentXianHeight = xianTop + xianOffset * i;
     xianHeight[i] = currentXianHeight;
     xian[i]= new Xian(i+1,xianHead,currentXianHeight,xianTail,currentXianHeight,ceil((9-i)/2));
  }
  ellipseMode(RADIUS);
  // initHui;
  
  float huiHeight = height*0.1;
  float cr = (xianTop-huiHeight)*0.2;
  float[] hr = new float[DEFAULT_HUI_NUM];
  float[] hxRate={ 0.125 , 0.166 , 0.2 , 0.25, 0.333 , 0.4 , 0.5, 0.6 , 0.666 , 0.75, 0.8, 0.833 ,0.875  } ;
  float HuiZoomRate = 0.9;
  float mr = cr * pow(HuiZoomRate,floor(DEFAULT_HUI_NUM/2));
  for(int i =0; i<= DEFAULT_HUI_NUM/2; i++){
    hr[i]=mr;
    hr[DEFAULT_HUI_NUM-1-i]=mr;
    mr=mr/HuiZoomRate;
  }
  float xianLen=xianHead-xianTail;
  hui = new Hui[DEFAULT_HUI_NUM];
  for(int i =0; i< DEFAULT_HUI_NUM; i++){
    hui[i]=new Hui(DEFAULT_HUI_NUM-i,xianTail+xianLen*hxRate[i],huiHeight,hr[i]);
  }
  
  //initMelody();
  //melodyManager = new MelodyManager("playlist.txt");
  mode=1;
}

boolean moveAlongX(int px, int py, int x, int y){
  
  if( abs(px-x)>abs(py-y)) return true;
  else return false;
}  
// Drag (click and hold) your mouse across the 
// image to change the value of the rectangle
void mouseDragged() {
     if(moveAlongX(pmouseX,pmouseY,mouseX,mouseY)){
              for(int i = 0; i<DEFAULT_XIAN_NUM;i++){
               if(xian[i].near(mouseX,mouseY)){
                 int status = 2;
                 if(xian[i].status!=20){ //not already played.
                   play(i,status,DEFAULT_AMP,mouseX,xianHead);
                 }
               }
         }
     }else{
       for(int i = 0; i<DEFAULT_XIAN_NUM;i++){
         if(xian[i].crossed(pmouseX,pmouseY,mouseX,mouseY)){
         int status = 1;
         play(i,status,DEFAULT_AMP,xianTail,mouseX);
       }
     }
     }
}
void mouseReleased(){
     for(int i = 0; i<DEFAULT_XIAN_NUM;i++){
     if(xian[i].near(mouseX,mouseY)&&xian[i].status==20){
        xian[i].status=0;
     }
   }
}

/*
void mouseMoved(){
  
   for(int i = 0; i<DEFAULT_XIAN_NUM;i++){
     if(xian[i].crossed(pmouseX,pmouseY,mouseX,mouseY)){
       int status = 1;
       
       play(i,status,DEFAULT_AMP,0,mouseX);
     }
   }

       
}
*/
void mouseClicked(){
  
   for(int i = 0; i<DEFAULT_XIAN_NUM;i++){
     if(xian[i].near(mouseX,mouseY)){
       int status = 3;
       play(i,status,DEFAULT_AMP*0.3,mouseX,xianHead);
     }
   }
       
}
void play (int i,int status,float a, float l, float r){ // xian index, vibrate status(0 still,1 san,2 an,3 fan), amplitude, lefthand position, right hand position, amplitude
    xian[i].play(status,a,l,r);
    Note n = new Note(xian[i].name,status,a,l,r,millis());

    history.addNote(n);
    
    /*
    if(mode != 2){
      int[] id = history.getXianHistory(5);
      int mIndex = melodyManager.findMelodyById(id);
      if(mIndex>=0){
        mode = 2;
        melodyManager.play(mIndex);
      }
    }else{
      melodyManager.play();
    }
    */

}




void draw(){
  
  background(0);
  for(int i =0; i< DEFAULT_HUI_NUM; i++){
    hui[i].draw();
  }
  
  for (int i = 0; i < DEFAULT_XIAN_NUM; ++i){
    xian[i].update();
  }
  /*
  if(mode==2) {melodyManager.update();}
  */
}

void stop(){
  for(int i =0;i<DEFAULT_XIAN_NUM;i++){
    xian[i].stop();
  }
/*  melodyManager.stop();*/
  minim.stop();
  super.stop();
}
