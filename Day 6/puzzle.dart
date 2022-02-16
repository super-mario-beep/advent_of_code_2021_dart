//https://adventofcode.com/2021/day/6
import 'dart:io';
import 'dart:convert';
import 'dart:core';

main() async{
  File file = new File('input.txt');
  List<int> fishes = [];
  int days = 80;


  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      fishes = getLineNumbersAsList(line)
    });

  print(fishes);
  for(int i = 0; i < days;i++){
    fishes = passDay(fishes);
  }
  print(fishes.length);
}

List<int> passDay(List<int> list){
  List<int> result = [];
  for(int i in list){
    if(i == 0){
      result.add(6);
      result.add(8);
    }else{
      result.add(i - 1);
    }
  }
  return result;
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
