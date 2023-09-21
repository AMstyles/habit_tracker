import 'package:flutter/material.dart';
import 'package:habit_tracker/database/database.dart';
import '../Models/task.dart';


class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {

  String _taskName = '';
  String _taskNote = '';
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius:  const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
       children :  [
          const SizedBox(height: 10,),
          const Text('Add Task', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          TextField(
            autofocus: true,
            controller: _taskNameController,
            decoration: const InputDecoration(

              hintText: 'Task Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
            onChanged: (value){
              setState(() {
                _taskName = value;
              });
            },
          ),

          const SizedBox(height: 10,),

         TextField(
           maxLines: 3,
           minLines: 2,
           controller: _taskNoteController,
           decoration: const InputDecoration(
               hintText: 'Note... (Optional)',
               border: OutlineInputBorder(
                   borderRadius: BorderRadius.all(Radius.circular(10))
               )
           ),
           onChanged: (value){
             setState(() {
               _taskName = value;
             });
           },
         ),

          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: (){
              Task task = Task(name: _taskName, note: _taskNote, time: DateTime.now(), isCompleted: false, color: 7);
              Database.addTask(task);
              setState(() {
                //print everything in the tasks hive box
                tasks.add(task);
              });
              Navigator.pop(context, _taskNameController.text);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
            child: const Text('Add Task'),
          )
          ],
      ),


    ),);
  }
}