//https://adventofcode.com/2021/day/7
import 'dart:io';
import 'dart:convert';
import 'dart:core';

main() async{
  File file = new File('input.txt');
  List<int> numbers = [];
  int max = 30000;

  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      numbers = getLineNumbersAsList(line)
    });

  List<int> total = [];
  for(int i = 0; i < max; i++){
    int _total = 0;
    for(int x in numbers){
      _total += (x - i).abs();
    }
    total.add(_total);
  }
  //print(numbers);
  total.sort();
  print(total.last);
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
