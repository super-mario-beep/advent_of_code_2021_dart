//https://adventofcode.com/2021/day/9
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

  List<List<int>> height = [];
  for(int i = 0;i < input.length;i++){
    if(i == 0){
      height.add(getLowPoint("0", input[0], input[1]));
    }else if(i == input.length - 1){
      height.add(getLowPoint(input[i - 1], input[i], "0"));
    }else{
      height.add(getLowPoint(input[i-1], input[i], input[i+1]));
    }
  }

  int total = 0;
  //add 1, calculate sum
  for(List<int> list in height){
    for(int number in list){
      total += number +1;
    }
  }
  print(total);
}

List<int> getLowPoint(String up, String line, String down){
  List<int> upList = [];
  List<int> lineList = [];
  List<int> downList = [];
  up.split('').forEach((element) { upList.add(int.parse(element)); });
  line.split('').forEach((element) { lineList.add(int.parse(element)); });
  down.split('').forEach((element) { downList.add(int.parse(element)); });

  List<int> results = [];
  for(int i = 0;i < lineList.length;i++){
    int number = lineList[i];
    List<bool> isValid = [];
    if(i != 0){//left
      if(number < lineList[i-1]){
        isValid.add(true);
      }else{
        isValid.add(false);
      }
    }
    if(i != lineList.length-1){//right
      if(number < lineList[i+1]){
        isValid.add(true);
      }else{
        isValid.add(false);
      }
    }
    if(upList.length != 1){//top
      if(number < upList[i]){
        isValid.add(true);
      }else{
        isValid.add(false);
      }
    }
    if(downList.length != 1){//down
      if(number < downList[i]){
        isValid.add(true);
      }else{
        isValid.add(false);
      }
    }

    if(isValid.where((item) => item == true).length == isValid.length){
      results.add(number);
    }
  }
  
  return results;
}
