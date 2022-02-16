//https://adventofcode.com/2021/day/10
import 'dart:io';
import 'dart:convert';
import 'dart:core';

main() async{
  File file = new File('input.txt');
  List<String> input = [];

  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      input.add(line),
    });
  
  double total = 0;
  for(String line in input){
    total += getPointsForLine(line);
  }
  //print(getPointsForLine(input.last));
  print(total.round());
}

int getPointsForLine(String line){
  List<String> list = [];
  List<int> results = [];
  line.split('').forEach((element) {
    if(element == "(" || element == "[" || element == "{" || element == "<"){
      list.add(element);
    }else{
      if(isValidChar(element, list.last)){
        list.removeAt(list.length -1);
      }else{
        //print(list);
        //print("error at " + element);
        if(element == ")"){
          results.add(3);
        }else if(element == "]"){
          results.add(57);
        }else if(element == "}"){
          results.add(1197);
        }else if(element == ">"){
          results.add(25137);
        }
        return;
      }
    }
  });
  return results.length == 0 ? 0 : results.first;
}

bool isValidChar(String char, String lastChar){
  if(lastChar == "(" && char == ")"){
    return true;
  }else if(lastChar == "[" && char == "]"){
    return true;
  }else if(lastChar == "{" && char == "}"){
    return true;
  }else if(lastChar == "<" && char == ">"){
    return true;
  }
  return false;
}