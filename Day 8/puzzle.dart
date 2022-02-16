//https://adventofcode.com/2021/day/8
import 'dart:io';
import 'dart:convert';
import 'dart:core';

main() async{
  File file = new File('input.txt');
  List<List<String>> input = [];
  List<List<String>> active = [];
  List<String> full_line = [];

  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      full_line = getLineNumbersAsList(line),
      active.add(full_line.sublist(full_line.length - 4)),
      input.add(full_line.sublist(0, full_line.length - 4)),
      full_line = [],
    });
  
  List<List<String>> full_input = [];
  for(List<String> list in input){
    full_input.add(sortListItems(list));
  }
  List<List<String>> full_active = [];
  for(List<String> list in active){
    full_active.add(sortListItems(list));
  }

  int count = 0;
  for(int i = 0; i < input.length; i++){
    List<String> inp = full_input[i];
    List<String> act = full_active[i];
    for(String item in act){
      if(isEasyDigit(item)){
        count++;
      }
    }
  }
  print(count);
}

bool isEasyDigit(String digit){
  int length = digit.length;
  if(length == 2 || length == 3 || length == 4 || length == 7){
    return true;
  }
  return false;
}

List<String> sortListItems(List<String> items){
  List<String> result = [];
  for(String item in items){
    List<dynamic> chars = [];
    item.split('').forEach((element) { chars.add(element); });
    chars.sort();
    result.add(chars.join(''));
  }
  return result;
}

List<String> getLineNumbersAsList(String line){
  List<String> result = [];
  RegExp exp = new RegExp(r'(\w+)');
  Iterable<RegExpMatch> matches = exp.allMatches(line);
  for(RegExpMatch m in matches){
    result.add(m.group(0)??"0");
  }
  return result;
}
