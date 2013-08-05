class Note{
  String name;
  int xianName;
  int status;
  float a;
  float l; //lefthand postion: mouseX when clicked or pressed.
  float r; //righthand postion: mouseX when crossed.
  int startTime; 
 
  
  Note(int xianName,int status, float a, float l, float r,int startTime){
    name = null;
    this.xianName = xianName;
    this.a = a;
    this.l = l;
    this.r = r;
    this.startTime = startTime;
    this.status = status;
  }
  String toString(){
    return "("+name+" "+xianName+" "+status+" "+l+"--"+r + " " + startTime+") ";
  }
}
