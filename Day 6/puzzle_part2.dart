//https://adventofcode.com/2021/day/6#part2
import 'dart:io';
import 'dart:convert';
import 'dart:core';

main() async{
  File file = new File('input.txt');
  Map<int,int> fishes = {};
  int days = 5;


  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      fishes = getLineNumbersAsList(line)
    });

  print(fishes);
  for(int i = 0; i < days;i++){
    print(i.toString());
    fishes = passDay(fishes);
    print(fishes);
  }
}

Map<int, int> passDay(Map<int, int> map){
  Map<int, int> result = {};
  map.forEach((key, value) {
    if(key == 0){
      result[6] = (map[0]??0) + (result[6]??0);
      result[8] = map[0]??0 + (result[8]??0);
    }else if(key == 7){
      result[6] = (map[7]??0 + (map[0]??0) + (result[6]??0));
    }else{
      result[key - 1] = map[key]??0;
    }
  });
  return result;
}

Map<int, int> getLineNumbersAsList(String line){
  Map<int, int> result = {};
  RegExp exp = new RegExp(r'(\d+)');
  Iterable<RegExpMatch> matches = exp.allMatches(line);
  for(RegExpMatch m in matches){
    int num = int.parse(m.group(0)??"0");
    if(result.containsKey(num)){
      int test = result[num]??0;
      result[num] = test + 1;
    }else{
      result[num] = 1;
    }
  }
  return result;
}
