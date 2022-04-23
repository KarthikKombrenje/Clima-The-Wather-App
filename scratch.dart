import 'dart:io';
void main() {
  performTasks();
}

Future<void> performTasks()  async {
  task1();
  String task2Result =  await task2();
  task3(task2Result);
}

String task1() {
  print('task 1 complete');
}

Future task2()  async {
  Duration ob = new Duration(seconds:5);
  String result;
  await Future.delayed(ob,(){
    result = 'task 2 data';
    print('Task 2 complete');
  });//sleep(ob);
  return result;
}

void task3(String task2result) {
  String result = 'Task 3 data';
  print('Task 3 is completed  with $task2result');
}