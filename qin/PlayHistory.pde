class PlayHistory{
  Note[] notes;
  int  historyBufferSize;
  int  last;
  int  total;
  
  PlayHistory(){
    historyBufferSize = 10;
    notes = new Note[historyBufferSize];
    last=-1;
    total = 0;
  }
  PlayHistory(int size){
    historyBufferSize = size;
    notes = new Note[historyBufferSize];
    last=0;
    total = 0;
  }
  void addNote(Note n){
    total++;
    last=(last+1)%historyBufferSize;
    notes[last]=n;
  }
  
  void printHistory(){
    int head = 0;
    int len = last+1;
    if(total>last+1){
      head = last+1;
      len = historyBufferSize;
    }
    for(int i = 0; i< len; i++){
      println(notes[(head+i)%historyBufferSize]);
    }
  }
}
