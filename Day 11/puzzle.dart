//https://adventofcode.com/2021/day/11
import 'dart:io';
import 'dart:convert';
import 'dart:core';

int totalFlash = 0;
main() async{
  File file = new File('input.txt');
  List<List<Map<String, dynamic>>> input = [];

  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      input.add(getLineNumbersAsListObjects(line)),
    });
  
  int steps = 100;
  for(int i = 0; i < steps; i++){
    input = flash(input);
  }
  print("After " + steps.toString() + " steps:");
  printMap(input);
  print("Total flash: " + totalFlash.toString());
}

List<Map<String, dynamic>> getLineNumbersAsListObjects(String line){
  List<Map<String, dynamic>> result = [];
  line.split('').forEach((element) {
    Map<String, dynamic> map = {};
    map["level"] = int.parse(element);
    result.add(map);
  });
  return result;
}

List<List<Map<String, dynamic>>> flash(List<List<Map<String, dynamic>>> list){
  for(List<Map<String, dynamic>> line in list){
    for(Map<String, dynamic> obj in line){
      obj["level"] += 1;
    }
  }

  int safe = 0;
  while(true){
    if(safe++ > 100){
      print("error happed at " + safe.toString());
      return list;
    }
    for(int y = 0;y < list.length;y++){
      List<Map<String, dynamic>> line  = list[y];
      for(int x = 0;x < line.length;x++){
        Map<String, dynamic> obj = line[x];
        if(obj["level"] > 9){
          totalFlash += 1;
          obj["level"] = 0;
          obj["flash"] = true;
          if(y != 0){//up
            Map<String, dynamic> z = list[y-1][x];
            if(z["flash"] != true){
              z["level"] += 1;
            }
          }
          if(y != list.length - 1){//down
            Map<String, dynamic> z = list[y+1][x];
            if(z["flash"] != true){
              z["level"] += 1;
            }
          }
          if(x != 0){//left
            Map<String, dynamic> z = list[y][x-1];
            if(z["flash"] != true){
              z["level"] += 1;
            }
          }
          if(x != line.length - 1){//right
            Map<String, dynamic> z = list[y][x+1];
            if(z["flash"] != true){
              z["level"] += 1;
            }
          }

          if(y != 0 && x != 0){//up-left
            Map<String, dynamic> z = list[y-1][x-1];
            if(z["flash"] != true){
              z["level"] += 1;
            }
          }
          if(y != 0 && x != line.length - 1){//up-right
            Map<String, dynamic> z = list[y-1][x+1];
            if(z["flash"] != true){
              z["level"] += 1;
            }
          }
          if(y != list.length - 1 && x != 0){//down-left
            Map<String, dynamic> z = list[y+1][x-1];
            if(z["flash"] != true){
              z["level"] += 1;
            }
          }
          if(y != list.length - 1 && x != line.length - 1){//down-right
            Map<String, dynamic> z = list[y+1][x+1];
            if(z["flash"] != true){
              z["level"] += 1;
            }
          }
        }
      }
    }
    if(checkIsMapFlashed(list)){
      break;
    }
  }

  for(List<Map<String, dynamic>> line in list){
    for(Map<String, dynamic> obj in line){
      obj["flash"] = false;
    }
  }

  return list;
}

bool checkIsMapFlashed(List<List<Map<String, dynamic>>> list){
  for(List<Map<String, dynamic>> line in list){
    for(Map<String, dynamic> obj in line){
      if(obj["level"] > 9){
        return false;
      }
    }
  }
  return true;
}

printMap(List<List<Map<String, dynamic>>> list){
  for(List<Map<String, dynamic>> line in list){
    String total = "";
    for(Map<String, dynamic> obj in line){
      total += obj["level"].toString();
    }
    print(total);
  }
  print("------------------------");
}