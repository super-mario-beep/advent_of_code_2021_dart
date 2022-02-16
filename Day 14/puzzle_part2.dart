//https://adventofcode.com/2021/day/14#part2
import 'dart:io';
import 'dart:convert';
import 'dart:core';

main() async{
  File file = new File('input.txt');
  String input = "";
  List<List<String>> formulas = [];

  bool isLocationInput = true;
  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      if(isLocationInput && input.length == 0){
        input = line,
      }else{
        formulas.add(getLineAsList(line))
      },

      if(line.length == 0){
        isLocationInput = false,
        formulas = []
      }
    });

  print(input);
  int steps = 13;
  for(int i = 0; i < steps; i++){
    print(i);
    input = takeStep(input, formulas);
  }
  print("After " + steps.toString() + " steps length is " + input.length.toString());
  print(getResult(input));
}

String getResult(String formula){
  String result = "";
  Map<String, int> results = {};
  
  formula.split('').forEach((element) {
    if(!results.containsKey(element)){
      results[element] = 1;
    }else{
      results[element] = ((results[element]??0) + 1);
    }
  });

  print(results);//B - 3523 , C - 755
  //result = ((results["B"]??0) - (results["C"]??0)).toString();

  return result;
}

String takeStep(String formula, List<List<String>> formulas){
  List<String> formulaAsList = [];
  String result = "";
  formula.split('').forEach((char) { 
    formulaAsList.add(char);
  });

  for(int i = 0; i < formulaAsList.length -1; i++){
    String char = formulaAsList[i];
    result += char;
    result += getStringForFormula(char + formulaAsList[i+1], formulas);
    if(i == formulaAsList.length - 2){
      result += formulaAsList[i+1];
    }
  }
  return result;
}

String getStringForFormula(String entry, List<List<String>> formulas){
  for(List<String> list in formulas){
    if(entry== list[0]){
      return list[1];
    }
  }
  return "";
}

List<String> getLineAsList(String line){
  List<String> result = [];
  RegExp exp = new RegExp(r'(\w+)');
  Iterable<RegExpMatch> matches = exp.allMatches(line);
  for(RegExpMatch m in matches){
    result.add(m.group(0)??"0");
  }
  return result;
}
