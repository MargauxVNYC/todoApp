import 'package:flutter/material.dart';
import '../todo.dart';
import '../colors.dart';

class ToDoElement extends StatelessWidget {
  final ToDo todo;
  final whenChanged;
  final whenDeleted;

  const ToDoElement({
    Key? key,
    required this.todo,
    required this.whenChanged,
    required this.whenDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
          whenChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: teal8,
        leading: Icon( //creates the checkbox
          todo.isFinished ? Icons.check_box : Icons.check_box_outline_blank, //if it has been done the icon will be checked otherwise it will be outline blank
          color: teal3,
        ),
        title: Text( //creates the text of the task 
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: black,
            decoration: todo.isFinished ? TextDecoration.lineThrough : null, 
          ),// if todo is finished is true, there will be a line through other wise it will be null
        ),
        trailing: Container( //creates the delete icon
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton( //creates the trash icon which is a child of the red button icon
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: (){
              whenDeleted(todo.element);
            },
          ),
        ),
      ),
    );
  }
}
