class ToDo {
  String? element; //string type
  String? todoText; //task inputted
  bool isFinished; //task status

  ToDo({
    required this.element,
    required this.todoText,
    this.isFinished = false, //by default the value will be false
  });

  static List<ToDo> todolist(){
    return[
      ToDo(element: '01', todoText: 'Math Homework', isFinished: true),
      ToDo(element: '02', todoText: 'Make Bed', isFinished: true),
      ToDo(element: '03', todoText: 'Grocery Shopping', ),
      ToDo(element: '04', todoText: 'Work on Ms. Qius ToDo App!', isFinished: true),
      ToDo(element: '05', todoText: 'Zoom Meeting @ 10 AM', ),
      ToDo(element: '06', todoText: 'Buy Christmas Gifts', ),
    ];
  }
}
