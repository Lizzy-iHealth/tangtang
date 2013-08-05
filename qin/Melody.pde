Class Melody{
  int[]id; // default 5 notes' xian name;
  int idLen; // default 5;
  String name;
  String soundFile;
  int status; // 0 : not started,  1:played,  2: paused, 3: stoped (?)
  AudioPlayer player;
  
  Melody(int[]id, String name, String fn){
    this.id = id;
    idLen = id.length();
    this.name = name;
    soundFile = fn;
  }
  
  void loadFile(){
    player = minim.loadfile(soundFile);
  }
  
  boolean matched(int[] his){
    if (his.length!=idLen){
      return false;
    }
    for (int i = 0; i< id.length; i++){
      if (his[i]!=id[i]){
        return false;
      }
    }
    return true;
  }
  
  void play(){
    if (player==null){
      loadFile();
    }
    player.play();
  }
}
