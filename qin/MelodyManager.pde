class MelodyManager{
  
  String playList; // a file name, in which each line is an 5 decimal id,a melody name,a file name: x x x x x,melody name,file name 
  String[] mp3Names;
  Melody[] melodies;
  int melodyNum;
  
  MelodyManager(String playList){
    this.playList = playList;
    String[] lines = loadStrings(playList);
    if (lines == null){
      mp3Names = null;
      melodies = null;
      melodyNum = 0;
      println("empty play list.");
    } else{
      melodyNum = lines.length;
      melodies = new Melody[melodyNum];
      for (int i = 0; i< melodyNum; i++){
        String[] info = split(lines[i],',');
        if(info.length!=3){
          println("play list format:x x x x x,Melody Name,mp3 file name");
          return;
        }
        int[] id = int(split(info[0],' ')); //id
        melodies[i] = new Melody(id,info[1],info[2]);
      }       
    }
  }
  
  int findMelodyById(int[] id){
    for(int i =0; i<melodyNum; i++){
      if(melodies[i].matched(id)){
        return i; // return first match. TODO: random select from multiple match
      }
    }
    return -1;  // not found
  }
  
  void play(int index){
    melodies[index].play();
  }
}
