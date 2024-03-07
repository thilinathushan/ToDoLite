import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../Styles/light_theme.dart';
import '../Styles/styles.dart';
import '../data/database.dart';
import '../provider/theme_provider.dart';
import '../util/custom_app_bar.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

// ignore: must_be_immutable
class GradientFloatingActionBar extends StatelessWidget {
  GradientFloatingActionBar({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  void Function()? onPressed;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 66, 133, 244),
              Color.fromARGB(255, 155, 114, 203),
              Color.fromARGB(255, 217, 101, 112),
            ],
          ),
        ),
        child: icon,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //if this is the first time ever opening the app, then create the data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //already exists data
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  //method
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            _controller.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color selectTextColor(ThemeData themeData) {
    Color textColor;
    if (themeData == lighttheme) {
      textColor = blackColor;
    } else {
      textColor = primaryWhite;
    }
    return textColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(),
      floatingActionButton: GradientFloatingActionBar(
        onPressed: createNewTask,
        icon: Icon(
          Icons.add,
          color: selectTextColor(Provider.of<ThemeProvider>(context).themeData),
        ),
      ),
      body: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
