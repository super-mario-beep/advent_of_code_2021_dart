//https://adventofcode.com/2021/day/11
import 'dart:io';
import 'dart:convert';
import 'dart:core';

int totalFlash = 0;
main() async{
  File file = new File('input.txt');
  List<List<int>> input = [];
  List<Map<String, dynamic>> folds = [];

  bool isLocationInput = true;
  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      if(isLocationInput){
        input.add(getLineNumbersAsListObjects(line))
      }else{
        folds.add(getLineFoldsAsMap(line))
      },

      if(line.length == 0){
        isLocationInput = false
      }
    });

  input.removeAt(input.length-1);//empty line as input
  List<int> biggest = getBiggestNumbers(input);
  int maxX = biggest[0] +2;
  int maxY = biggest[1] +1;
  List<List<String>> map = [];
  for(int i = 0; i < maxY; i++){
    List<String> dots = [];
    for(int j = 0; j < maxX; j++){
      dots.add(".");
    }
    map.add(dots);
  }

  
  //print(maxX);
  //print(maxY);
  map = fillMap(map, input);
  map = foldMap(map, folds[0]["key"], folds[0]["pos"]);
  //map = foldMap(map, folds[1]["key"], folds[1]["pos"]);
  //printMap(map);
  print("Dots after first step: " + getDotsCount(map).toString());
}

List<List<String>> fillMap(List<List<String>> map, List<List<int>> dots){
  for(List<int> dot in dots){
    int x = dot[0];
    int y = dot[1];
    map[y][x] = "#";
  }
  return map;
}

List<List<String>> foldMap(List<List<String>> map, String os, int position){
  List<List<String>> originalMap = [];
  List<List<String>> foldedMap = [];
  if(os == "y"){
    for(int y = 0; y < position; y++){
      List<String> line = map[y];
      originalMap.add(line);
    }
  }else{
    for(int y = 0; y < map.length; y++){
      List<String> line = [];
      for(int x = 0; x < position;x++){
        line.add(map[y][x]);
      }
      originalMap.add(line);
    }
  }
  
  if(os == "y"){
    for(int y = position +1; y < map.length; y++){
      List<String> line = map[y];
      foldedMap.add(line);
    }
  }else{
    for(int y = 0; y < map.length; y++){
      List<String> line = [];
      for(int x = position +1; x < map.first.length;x++){
        line.add(map[y][x]);
      }
      foldedMap.add(line);
    }
  }

  List<List<String>> reversedMap = [];

  if(os == "y"){
    reversedMap = foldedMap.reversed.toList();
    int y = 0;
    for(List<String> line in reversedMap){
      int x = 0;
      for(String obj in line){
        if(obj == "#"){
          originalMap[y][x] = "#";
        }
        x++;
      }
      y++;
    }
  }else{
    for(List<String> line in foldedMap){
      reversedMap.add(line.reversed.toList());
    }
    int y = 0;
    for(List<String> line in reversedMap){
      int x = 0;
      for(String obj in line){
        if(obj == "#"){
          originalMap[y][x] = "#";
        }
        x++;
      }
      y++;
    }
  }

  return originalMap;
}

Map<String, dynamic> getLineFoldsAsMap(String line){
  Map<String, dynamic> result = {};
  result["pos"] = "";
  bool isValue = false;
  line.split('').forEach((element) {
    if(element == 'x'){
      result["key"] = "x";
    }else if(element == "y"){
      result["key"] = "y";
    }else if(element == "="){
      isValue = true;
    }else if(isValue){
      result["pos"] += element;
    }
  });

  result["pos"] = int.parse(result["pos"]);
  return result;
}

List<int> getLineNumbersAsListObjects(String line){
  List<int> result = [];
  RegExp exp = new RegExp(r'(\w+)');
  Iterable<RegExpMatch> matches = exp.allMatches(line);
  for(RegExpMatch m in matches){
    result.add(int.parse(m.group(0)??"0"));
  }
  return result;
}

int getDotsCount(List<List<String>> map){
  int count = 0;
  for(List<String> line in map){
    for(String obj in line){
      if(obj == "#"){
        count++;
      }
    }
  }
  return count;
}

void printMap(List<List<String>> map){
  for(List<String> line in map){
    String full = "";
    for(String obj in line){
      full += obj;
    }
    print(full);
  }
}

List<int> getBiggestNumbers(List<List<int>> list){
  List<int> value = [0, 0];
  for(List<int> dot in list){
    if(dot.length == 2){
      if(dot[0] > value[0]){
        value[0] = dot[0];
      }
      if(dot[1] > value[1]){
        value[1] = dot[1];
      }
    }
  }
  return value;
}