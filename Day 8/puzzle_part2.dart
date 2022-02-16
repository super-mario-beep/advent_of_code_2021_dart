//https://adventofcode.com/2021/day/8#part2
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
    String total = "";
    for(String item in act){
      print(item);
      if(getDigit(item) != -1){
        print(getDigit(item));
        total+= getDigit(item).toString();
      }
    }
    if(total.length == act.length){
      count+= int.parse(total);
      print(total);
    }
    //print(act.length);
    break;
  }
  print(count);
}

int getDigit(String digit){
  if(digit == "abcdeg"){
    return 0;
  }else if(digit == "abcdeg"){
    return 1;
  }else if(digit == "acdfg"){
    return 2;
  }else if(digit == "abcdf"){
    return 3;
  }else if(digit == "abef"){
    return 4;
  }else if(digit == "bcdef"){
    return 5;
  }else if(digit == "bcdefg"){
    return 6;
  }else if(digit == "abd"){
    return 7;
  }else if(digit == "abcdefg"){
    return 8;
  }else if(digit == "abcdef"){
    return 9;
  }
  return -1;
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
