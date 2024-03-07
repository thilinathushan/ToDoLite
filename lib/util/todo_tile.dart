import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../Styles/styles.dart';

// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 18.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: deleteRedColor,
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
          ],
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              //checkbox
              Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: blackColor),
              //task name
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
