//https://adventofcode.com/2021/day/5#part2
import 'dart:io';
import 'dart:convert';
import 'dart:core';

List<List<int>> map = [];
main() async{
  File file = new File('input.txt');
  List<List<int>> inputs = [];
  fillMap();

  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      inputs.add(getLineNumbersAsList(line))
    });
  for(List<int> input in inputs){
    addLineToMap(input);
    addLineToMapDiagonal(input);
  }
  print(countOverlap());
  printMap();
}

void addLineToMapDiagonal(List<int> cordinates){
  int x1 = cordinates[0];
  int y1 = cordinates[1];
  int x2 = cordinates[2];
  int y2 = cordinates[3];

  if(x1 == x2 || y1 == y2){
    return;
  }

  if(x1 > x2){
    if(y1 > y2){
      for(int i = 0; i <= y1 - y2;i++){
        map[y2 + i][x2 + i] += 1;
      }
    }else{
      for(int i = 0; i <= y2 - y1;i++){
        map[y1 + i][x1 - i] += 1;
      }
    }
  }else{
    if(y1 > y2){
      for(int i = 0; i <= y1 - y2;i++){
        map[y2 + i][x2 - i] += 1;
      }
    }else{
      for(int i = 0; i <= y2 - y1;i++){
        map[y1 + i][x1 + i] += 1;
      }
    }
  }
  print(cordinates);

}

void addLineToMap(List<int> cordinates){
  if(cordinates.length == 0)
    return;

  int x1 = cordinates[0];
  int y1 = cordinates[1];
  int x2 = cordinates[2];
  int y2 = cordinates[3];

  if(x1 == x2){
    int big = y1 > y2 ? y1 : y2;
    int small = y1 > y2 ? y2 : y1;
    for(int i = small; i <= big; i++){
      map[i][x1] += 1;
    }
  }else{
    int big = x1 > x2 ? x1 : x2;
    int small = x1 > x2 ? x2 : x1;
    for(int i = small; i <= big; i++){
      map[y1][i] += 1;
    }
  }
}

int countOverlap(){
  int count = 0;
  for(List<int> list in map){
    for(int i in list){
      if(i >= 2){
        count++;
      }
    }
  }
  return count;
}

List<int> getLineNumbersAsList(String line){
  List<int> result = [];
  RegExp exp = new RegExp(r'(\d+)');
  Iterable<RegExpMatch> matches = exp.allMatches(line);
  for(RegExpMatch m in matches){
    result.add(int.parse(m.group(0)??"0"));
  }
  return result;
}

void fillMap(){
  int size = 10;
  for(int i = 0;i < size;i++){
    List<int> tmp = [];
    for(int j = 0;j < size;j++){
      tmp.add(0);
    }
    map.add(tmp);
  }
}

void printMap(){
  for(List<int> i in map){
    print(i);
  }
}