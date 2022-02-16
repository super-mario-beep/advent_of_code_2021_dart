//https://adventofcode.com/2021/day/4#part2
import 'dart:io';
import 'dart:convert';
import 'dart:core';

main() async{
  File file = new File('input.txt');
  List<List<List<int>>> bingo = [];
  List<List<int>> array2D = [];
  List<int> numbers = [];
  List<int> used_numbers = [];

  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      if(numbers.length == 0){
        numbers = getBingoNumbers(line)
      }else if(line != ""){
        array2D.add(getLineNumbersAsList(line)),
        if(array2D.length == 5){
          bingo.add(array2D),
          array2D = [],
        }
      }
    });

  List<List<List<int>>> lastBoard = [];
  int lastNumber = 0;
  List<int> lastUsedNumbers = [];
  for(int number in numbers){
    used_numbers.add(number);
    List<List<int>> winHorizontal = checkIsBingoHorizontal(bingo, used_numbers);
    List<List<int>> winVertical = checkIsBingoVertical(bingo, used_numbers);
    if(!winVertical.isEmpty && !lastBoard.contains(winVertical)){
      lastBoard.add(winVertical);
      lastNumber = number;
    }else if(!winHorizontal.isEmpty && !lastBoard.contains(winHorizontal)){
      lastBoard.add(winHorizontal);
      lastNumber = number;
    }
  }//4920
  lastUsedNumbers = used_numbers.sublist(0,used_numbers.indexOf(lastNumber)+1);
  print(lastBoard.last);
  print(lastUsedNumbers.last);
  print(used_numbers.length);
  calculateResult(lastBoard.last, lastUsedNumbers, lastNumber);
}

calculateResult(List<List<int>> lists, List<int> used_numbers, int final_number){
  if(lists.isEmpty){
    return;
  }
  List<int> all = [];
  for(int i = 0; i < 5; i++){
    for(int j = 0; j < 5; j++){
      all.add(lists[i][j]);
    }
  }
  int total = 0;
  for(int i in all){
    if(!used_numbers.contains(i))
      total += i;
  }
  print(total * final_number);
}

List<List<int>> checkIsBingoHorizontal(List<List<List<int>>> bingo, List<int> used_numbers){
  for(List<List<int>> list2D in bingo){
    for(List<int> row in list2D){
      if(used_numbers.toSet().intersection(row.toSet()).length == 5)
        return list2D;
    }
  }
  return [];
}

List<List<int>> checkIsBingoVertical(List<List<List<int>>> bingo, List<int> used_numbers){
  for(List<List<int>> list2D in bingo){
    for(int i = 0; i < 5; i++){
      List<int> column = [];
      for(int j = 0; j < 5; j++){
        column.add(list2D[j][i]);
      }
      if(used_numbers.toSet().intersection(column.toSet()).length == 5)
        return list2D;
    }
  }
  return [];
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

List<int> getBingoNumbers(String line){
  List<int> result = [];
  RegExp exp = new RegExp(r'(\d+)');
  Iterable<RegExpMatch> matches = exp.allMatches(line);
  for(RegExpMatch m in matches){
    result.add(int.parse(m.group(0)??"0"));
  }
  return result;
}