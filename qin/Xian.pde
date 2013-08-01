class Xian {
  int name;
  float headX,headY,tailX,tailY,a,l,r;
  float dia; // diameter of xian
  float angle; // control amplitude;
  float time; // vibrate time length in seconds;
  float hz;
  String soundfile;
  int status;//0:stable, 1:san yin,...
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
  }
  
  void draw(){
    stroke(255);
    strokeWeight(dia);
    int totalAngle = time*hz*2*PI;
    curA = a*(1-angle/totalAngle)*cos(angle);
    switch (status) {
      case 0:
        line(tailX,tailY,headX,headY);
        break;
      case 1:
        line(tailX,tailY,l,tailY); //tail to left position
        line(l,tailY,r,headY+curA);   // left hand to right hand
        line(r,headY+curA,headX,headY); // right hand to head
        break;
    }
   // line(headX,headY,tailX,tailY);
  }
  boolean crossed(int px, int py, int x,int y){
      if((py-headY)*(headY-y)>0) return true;
      else return false;
  }
  void update(){
    if(status==1){
      float tA=time*hz*2*PI;
      angle+=2*PI*hz/FrameRate;
      if (angle > tA){
        status=0;
        angle =0;  
      }
    }
  }
  void vibrate (float a, float l, float r){ //Amplitude, lefthand position, righthand position
    this.a=a;
    this.l=l;
    this.r=r;
    angle = 0;
    status = 1;
  }
}
