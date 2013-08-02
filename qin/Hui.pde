class Hui{
  float name;
  float centerX;
  float centerY;
  float radias;
  color c;
 
  
  Hui(float n, float x, float y, float r){
   name = n;
   centerX = x;
   centerY = y;
   radias = r;
   c=#F0F0F0;
  }
  
  void draw(){
    fill(c);
    ellipse(centerX,centerY,radias,radias);
  }
}
