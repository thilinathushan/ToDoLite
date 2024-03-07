// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'my_button.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      content: Container(
        height: _isExpanded ? MediaQuery.of(context).size.height * 0.25 : 120.0,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Get user input
            Expanded(
              child: TextField(
                controller: widget.controller,
                showCursor: true,
                autofocus: true,
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  hintText: "Add a new task",
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true,
                ),
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (text) {
                  setState(() {
                    _isExpanded = text.isNotEmpty;
                  });
                },
              ),
            ),
            // Buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save
                MyButton(text: "Save", onPressed: widget.onSave),
                const SizedBox(width: 10),
                // Cancel
                MyButton(text: "Cancel", onPressed: widget.onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
