class Xian {
  int name;
  float headX,headY,tailX,tailY,a,l,r;
  float dia; // diameter of xian
  float angle; // control amplitude;
  float time; // vibrate time length in seconds;
  float hz;
  String soundfile;
  int status;//0:stable, 1:san yin, 2 an yin, 3 fan yin, 20 an yin continue...
  
  int tunesNum;
  AudioPlayer[] tunes; // san, an, fan
  // Constructor
  Xian(int name, float headX,float headY,float tailX,float tailY,int dia){
    this.name = name;
    this.headX = headX;
    this.headY = headY;
    this.tailX = tailX;
    this.tailY = tailY;
    a=0;
    l=tailX;
    r=headX;
    this.dia=dia;
    hz = 200;
    tunesNum = 7; //0: san, 1: a7, 2: f7, 3:an-left, 4: an-right, 5: f9, 6: f4,  
    time = DEFAULT_PLAY_TIME;
    tunes = new AudioPlayer[tunesNum]; 
    loadSoundFile();
  }
  void loadSoundFile(){
    for (int i =0;i<tunesNum;i++){
      String fn = str(name)+"-"+str(i)+".mp3";
      println("load:"+fn);
      tunes[i] = minim.loadFile(fn);
    }
  }
  void playTunes(int h){
    int i=0;
    switch (h){
      case 0:
        i = 0;
        break;
      case 1:
        if(l<tailX+0.333*(headX-tailX)){
          i=3;
        }else if(l<tailX+0666*(headX-tailX)){
          i=1;
        }else {
          i=4;
        }
        break;
      case 2:
        if(l<tailX+0.333*(headX-tailX)){
          i=5;
        }else if(l<tailX+0666*(headX-tailX)){
          i=2;
        }else {
          i=6;
        }
        break;
    }
    tunes[i].rewind();
    tunes[i].play();
  }
  void play(int status,float a, float l, float r){
    this.status = status;
    vibrate(a,l,r);

    if(mode==1){
    switch (status){
      case 0:  // silent
        break;
      case 1:  //san yin
        playTunes(0);
        break;
      case 2:  // an yin
        playTunes(1);
        //until mouse up
        break;
      case 3: // fan yin
        playTunes(2);
    }
    }
    if(status==2)this.status = 20;
  }
  void draw(){
    stroke(255);
    strokeWeight(dia);
    float totalAngle = time*hz*2*PI;
    float curA = a*(1-angle/totalAngle)*cos(angle);
    switch (status) {
      case 0:
        line(tailX,tailY,headX,headY);
        break;
      case 1: // vibrate around right hand position

      case 2: // vibrate from left hand postion to head, around right hand position
      case 20:
        line(tailX,tailY,l,tailY); //tail to left position
        line(l,tailY,r,headY+curA);   // left hand to right hand
        line(r,headY+curA,headX,headY); // right hand to head
        break;
      case 3: // vibrate around left hand position.
        line(tailX,tailY,l,tailY+curA);
        line(l,tailY+curA,headX,headY);
        break;
    }
  }
  boolean crossed(int px, int py, int x,int y){
      if(py==y) return false; // no y direction move;
      if(py==headY) return false; // already played.
      if((py-headY)*(headY-y)>=0) {
        //println("cross: "+ name+py+headY+y);
        return true;
      }
      else return false;
  }
  boolean near(int x, int y){
    if(abs(y-headY)<EPS) return true;
    else return false;
  }
  void update(){
    if(status>0){
      float tA=time*hz*2*PI;
      angle+=2*PI*hz/FrameRate;
      if (angle > tA){
        status=0;
        angle =0; 
      }
    }
    draw();
  }
  
  boolean isVibrate(){
    return boolean(status);
  }
  
  void vibrate (float a, float l, float r){ //Amplitude, lefthand position, righthand position
    this.a=a;
    this.l=l;
    this.r=r;
    angle = 0;
  }
  
  void stop(){
    for (int i = 0; i<tunes.length; i++) {
      tunes[i].close();
    }
  }
}


