import ddf.minim.*;

int DEFAULT_XIAN_NUM =7;
Xian[] xian;
Hui[] hui;
int DEFAULT_HUI_NUM = 13;
float[] xianHight;
int FrameRate = 30;
int DEFAULT_PLAY_TIME = 2 ;// 2s play time
float DEFAULT_AMP=6;
float EPS = 5;
Minim minim;
PlayHistory history;
MelodyManager melodyManager;

void setup(){
  size(1200,360);
  frameRate(FrameRate);
  minim = new Minim(this);
  
  history = new PlayHistory();
  // draw static Xian 
  float xianHead=width;
  float xianTail=0;
  float xianTop = height*0.2;
  float xianBottom = height*0.95;
  
  float xianOffset=(xianBottom-xianTop)/(DEFAULT_XIAN_NUM-1);
  EPS=xianOffset*0.3;
  xian = new Xian[DEFAULT_XIAN_NUM];
  float [] xianHeight = new float[DEFAULT_XIAN_NUM];
  for(int i = 0; i<DEFAULT_XIAN_NUM; ++i){
     
     float currentXianHeight = xianTop + xianOffset * i;
     xianHeight[i] = currentXianHeight;
     xian[i]= new Xian(i+1,xianHead,currentXianHeight,xianTail,currentXianHeight);
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
  melodyManager = new MelodyManager("playlist.txt");
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
                   play(i,status,DEFAULT_AMP,mouseX,mouseX);
                 }
               }
         }
     }else{
       for(int i = 0; i<DEFAULT_XIAN_NUM;i++){
         if(xian[i].crossed(pmouseX,pmouseY,mouseX,mouseY)){
         int status = 1;
         play(i,status,DEFAULT_AMP,0,mouseX);
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

void mouseMoved(){
  
   for(int i = 0; i<DEFAULT_XIAN_NUM;i++){
     if(xian[i].crossed(pmouseX,pmouseY,mouseX,mouseY)){
       int status = 1;
       
       play(i,status,DEFAULT_AMP,0,mouseX);
     }
   }
  // println("("+mouseX+" , "+mouseY+" )");
       
}

void mouseClicked(){
  
   for(int i = 0; i<DEFAULT_XIAN_NUM;i++){
     if(xian[i].near(mouseX,mouseY)){
       int status = 3;
       play(i,status,DEFAULT_AMP*0.3,0,mouseX);
     }
   }
       
}
void play (int i,int status,float a, float l, float r){ // xian index, vibrate status(0 still,1 san,2 an,3 fan), amplitude, lefthand position, right hand position, amplitude
    xian[i].play(status,a,l,r);
    Note n = new Note(xian[i].name,status,a,l,r,millis());

    history.addNote(n);
    
    int[] id = history.getXianHistory(5);
    println(join(nf(id,0)," "));
//    history.printHistory();
//    println("------------------------");
 // audioTest();
}




void draw(){
  
  background(0);
  for(int i =0; i< DEFAULT_HUI_NUM; i++){
    hui[i].draw();
  }
  for (int i = 0; i < DEFAULT_XIAN_NUM; ++i){
    xian[i].update();
  }
}

void stop(){
  for(int i =0;i<DEFAULT_XIAN_NUM;i++){
    xian[i].stop();
  }
  minim.stop();
  super.stop();
}
