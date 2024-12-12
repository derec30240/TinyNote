
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tiny_note/controllers/task_conotroller.dart';
import 'package:tiny_note/models/task_model.dart';
import 'package:tiny_note/pages/addtask_page.dart';

//backgroundColor: Theme.of(context).colorScheme.primary,
//foregroundColor: Theme.of(context).colorScheme.onPrimary,

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
   final TaskController taskController = Get.put(TaskController());


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text(
          'My tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
        //响应式编程，具体原理没明白，反正很有用
        child: Obx((){
          return TaskController.taskList.isEmpty ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.article_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 80,
                ),
                SizedBox(height: 10,),
                Text("No Tasks Yet!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),)
              ],
            ),
            //应该是这个代码实现了添加各种任务菜单
          ):ListView.builder(
            itemCount: TaskController.taskList.length,
            itemBuilder: (context, index) {
              var task = TaskController.taskList[index];
              return Slidable(
                key: ValueKey(index),
                //向右划打开编辑页面
                startActionPane: ActionPane(
                  motion: DrawerMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      borderRadius: BorderRadius.circular(15),
                      autoClose: true,
                      onPressed:(context) =>Get.to(()=>
                      AddTaskScreen(
                        task: task,
                        index: index,
                      )),
                      //onPressed: (v){},
                      backgroundColor:  Theme.of(context).colorScheme.primary,
                      icon:Icons.edit,
                      label: 'Edit',
                    )
                  ],
                ), 
                //silde to the lift and open the delete button
                endActionPane: ActionPane(
                  motion: DrawerMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      borderRadius: BorderRadius.circular(15),
                      autoClose: true,
                      onPressed: (context) => TaskController.deleteTask(index),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon:Icons.delete,
                      label: 'Delete',
                    )
                  ],
                ), 
                child: taskCard(task , index),
              ).animate().fade().slide(duration : 300.ms);
            },
          );
        }),
      ),
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: Theme.of(context).colorScheme.primary,
//        foregroundColor: Colors.white,
//        onPressed: (){
//          //turn to edit page
//          Get.to(() => AddTaskScreen());
//        },
//        child: Icon(Icons.add),
//      ),
    ); 
  }
  //every task have its owm card showed on the page
  Widget taskCard(Task task, int index) {
    return Card(
      elevation: 7,//set the size of shade
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: Icon(
          Icons.task_alt,
          color: task.isCompleted 
            ? Colors.green 
            : Colors.grey,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: 
              task.isCompleted
              ? TextDecoration.lineThrough
              : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            Text(
              task.description,
              style: TextStyle(
                color: Colors.grey.shade600,
                decoration: 
                  task.isCompleted
                  ? TextDecoration.lineThrough
                  : null,
              ),
            ),
            Divider(),
            Text(
              '${task.dueDate!.toLocal()}'.split(' ')[0],//spilt the datedata
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
                decoration: 
                  task.isCompleted
                  ? TextDecoration.lineThrough
                  : null,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () => taskController.toggleTaskCompletion(index , task),
          icon: Icon(
            task.isCompleted
              ? Icons.check_circle
              : Icons.circle_outlined,
            color: task.isCompleted
              ? Colors.green
              : Colors.grey,
          )
        ),
      ),
    );
  }
}

//class TasksPage extends StatelessWidget {
// TasksPage({super.key});
//}
