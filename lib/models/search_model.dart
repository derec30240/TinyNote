import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:tiny_note/controllers/notes_controller.dart';
import 'package:tiny_note/pages/home_page.dart';



class DataSearch extends SearchDelegate<String>{


  //get title at here
  final alltitle  = getAlltitle();
  // = NotesController().notes;
  /*final alltitle= [
    "Null",
    "Nul",
    ];*/
  
  final recentSearch = [
    "Null",
    "Nul",
    ];
  
  
  

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query = '';
          print(NotesController().notes);
        }, 
        icon: const Icon(Icons.clear),
        )
    ];
  }

  @override
  //close the srearch collum
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed:(){
        //Get.to(const MyHomePage(title: 'Flutter Demo Home Page'));
        Navigator.pop( context);
      }, 
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
      ? recentSearch 
      : alltitle.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.note),
        onTap: (){
          showResults( context);
        },
        title: TextButton(
          onPressed: (){
            //
            Navigator.pop( context);
          },
          //matched text, ues bold
          child: Text.rich(
            TextSpan(
              text: suggestionList[index].substring(0,query.length),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                
              ),
              children: [
                TextSpan(
                  //the text not matched, so the font colot is grey
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(
                    color: Colors.grey
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap =(){
                     // Get.to(Placeholder());
                    }
                )
              ]
            ),
          textAlign: TextAlign.left, 
          )
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

List<String> getAlltitle() {
  List<String> gettitle = List.empty();
  for (var element in NotesController().notes) {
    gettitle.add(element.title);
  }
  return gettitle;
}