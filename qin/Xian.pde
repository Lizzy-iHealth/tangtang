class Xian {
  int name;
  float headX,headY,tailX,tailY,a,l,r;
  float dia; // diameter of xian
  float angle; // control amplitude;
  float time; // vibrate time length in seconds;
  float hz;
  String soundfile;
  int status;//0:stable, 1:san yin,...
  
  AudioPlayer[] tunes; // san, an, fan
  // Constructor
  Xian(int name, float headX,float headY,float tailX,float tailY){
    this.name = name;
    this.headX = headX;
    this.headY = headY;
    this.tailX = tailX;
    this.tailY = tailY;
    a=0;
    l=tailX;
    r=headX;
    dia=3;
    hz = 200;
    time = DEFAULT_PLAY_TIME;
    tunes = new AudioPlayer[3]; 
    loadSoundFile();
  }
  void loadSoundFile(){
    for (int i =0;i<3;i++){
      String fn = str(name)+"-"+str(i)+".mp3";
      println("load:"+fn);
      tunes[i] = minim.loadFile(fn,2048);
    }
  }
  void playTunes(int h){
    tunes[h].rewind();
    tunes[h].play();
  }
  void play(int status,float a, float l, float r){
    Note n = new Note(name,a,l,r,millis());
    history.addNote(n);
    history.printHistory();
    this.status = status;
    if(status==2){
      vibrate(a,l,headX);
      playTunes(1);
      //until mouse up
      this.status = 20;
    }else{
      vibrate(a,l,r);
    }
    switch (status){
      case 0:  // silent
        break;
      case 1:  //san yin
        playTunes(0);
        break;
      case 2:  // an yin

        //until mouse up
        break;
      case 3: // fan yin
        playTunes(2);
    }
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
      case 1:

      case 2:
      case 20:
      case 3:
        line(tailX,tailY,l,tailY); //tail to left position
        line(l,tailY,r,headY+curA);   // left hand to right hand
        line(r,headY+curA,headX,headY); // right hand to head
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
