import 'package:flutter/material.dart';
import '../todo.dart';
import '../colors.dart';
import '../todo_element.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  final todosList = ToDo.todolist();
  List<ToDo> foundToDo = [];
  final todoController = TextEditingController();

  @override
  void initState() {
    foundToDo =
        todosList; //accessing the todosList in order to iterate and find the searched todo
    super.initState();
  }

  @override
  Widget build(BuildContext elements) {
    return Scaffold(
      backgroundColor: bgColor, //create file with these already defined colors
      appBar: buildAB(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBar(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'Your Tasks',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: teal8,
                          ),
                        ),
                      ),
                      for (ToDo todo2 in foundToDo.reversed)
                        ToDoElement(
                          todo: todo2,
                          whenChanged: handleChange,
                          whenDeleted: deleteElement,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            //create the add new task feature on the bottom
            alignment: Alignment.bottomCenter,
            child: Row(//create row because two items
                children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                        hintText: 'Add new task', border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                //creates the add button
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  onPressed: () {
                    addTask(todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: teal3,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void handleChange(ToDo todo) {
    setState(() {
      todo.isFinished =
          !todo.isFinished; //this handles the changing of the state of the task
    });
  }

  void deleteElement(String id) {
    setState(() {
      todosList.removeWhere((item) => item.element == id); //
    });
  }

  void addTask(String toDo) {
    setState(() {
      todosList.add(ToDo(
        element: DateTime.now()
            .millisecondsSinceEpoch
            .toString(), //creates new element by creating a new timestamp to distinguish each task
        todoText: toDo,
      ));
    });
    todoController.clear(); //after adding the item clear the text page
  }

  void search(String keyWord) {
    List<ToDo> results = [];
    if (keyWord.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((element) =>
              element.todoText!.toLowerCase().contains(keyWord.toLowerCase()))
          .toList();
      //this is where we provide the search functionality
    }

    setState(() {
      foundToDo = results;
    });
  }

  Widget searchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: teal8,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => search(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: grey),
        ),
      ),
    );
  }

  AppBar buildAB() {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      title: Row(children: [
        Icon(
          Icons.menu,
          color: teal8,
          size: 30,
        ), //creates Top Left Icon
      ]),
    );
  }
}
