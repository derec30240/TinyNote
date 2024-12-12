


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tiny_note/controllers/task_conotroller.dart';
import 'package:tiny_note/models/task_model.dart';
import 'package:tiny_note/pages/home_page.dart';
import 'package:tiny_note/pages/tasks_page.dart';



class AddTaskScreen extends StatefulWidget {

  final Task ? task;
  final int ? index;
  const AddTaskScreen({
    super.key,
    this.index,
    this.task
    });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  
  final TaskController taskController = Get.find();

  final TextEditingController  titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? selectedDate;

  @override
  void initState() {
    // TODO: implement reassemble
    super.initState();
    if(widget.task != null){
      titleController.text = widget.task!.title; 
      descriptionController.text = widget.task!.description;
      selectedDate = widget.task!.dueDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    //one page, two fuction
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        title: Text(
          widget.task != null ? "Edit Task" : "Add New Task",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Task Title",
              style:  TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            //set the region of typing information
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Task Title",
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Task Description",
              style:  TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            //set the region of typing information
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Task Descrption",
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Due Date",
              style: TextStyle(fontWeight: FontWeight.w500,),
            ),
            SizedBox(height: 10),
            TextButton.icon(
              label:Text(
                selectedDate == null 
                  ? "Pick a Due Date" 
                  : '${selectedDate!.toLocal()}'.split(' ')[0],
                ), 
              icon: Icon(
                Icons.calendar_month_rounded,
                color: Theme.of(context).colorScheme.primary,
                ),
               onPressed: () async{
                selectedDate = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024), 
                  lastDate: DateTime(2100)
                );
                setState(() {
                });
              },
            ),
            SizedBox(height: 30,),
            //set "add task" button
            Center(
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 50 , 
                    vertical: 15
                    ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                ) ,
                child: Text(
                  widget.task != null
                    ? "Uptade Task"
                    : "Add Task"
                  ),
                onPressed:() {
                  //检测输入框里内容是否为空
                  if(titleController.text.isEmpty || descriptionController.text.isEmpty || selectedDate == null){
                    Get.snackbar(
                      "Error" , "Please fill in all fields",
                      backgroundColor: Colors.redAccent,
                  //foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      colorText: Colors.black,
                    );
                    return;
                  }
                  //编辑/更新任务
                  if(widget.task != null){
                    var updateTask = Task(
                      title: titleController.text,
                      description: descriptionController.text ,
                      dueDate: selectedDate!,
                      isCompleted: widget.task!.isCompleted,
                      );
                    taskController.editTask(widget.index!, updateTask );
                    Get.back();
                    Get.snackbar(
                      "Success", "Task Added Successfully",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  }else{
                    //添加新任务
                    
                    var newTask = Task(
                      title: titleController.text,
                      description: descriptionController.text ,
                      dueDate: selectedDate!,
                      //isCompleted: widget.task!.isCompleted,
                      );
                    taskController.addTask(newTask);                   
                    Get.back();
                    Get.snackbar(
                      "Success", "Task Added Successfully",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );

                  }
                },
              ),
            )
          ],
        )
      ),
      
    );
  }
}