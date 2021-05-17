
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

void main() {
  runApp(MyApp());
}

Color resetColor = Colors.grey;


void updateColor(int change) {
  if (change == 2) {
    if (resetColor == Colors.grey) {
      resetColor = Colors.blue;
    }
    else {
      resetColor = Colors.grey;
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DAVIES TO-D0 App',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
var currentDate = Jiffy().format('EEE, do');
String deadlineDate=Jiffy().format('EEE, do');




class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();



  List<TodoModelClass> todos = [];

  void _removeTodoItem(int index) {
    setState(() => todos.removeAt(index));
  }


  void _showInputFieldWidget(BuildContext context) {


    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 14),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors. white70,
            ),
            width: MediaQuery.of(context).size.width * 1.5,
            child: Row(
              children: <Widget>[
                Text(
                  "Create A Task",
                  style: GoogleFonts.lateef(
                    color: Colors.black45,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: IconButton(
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.lightBlueAccent,
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        }
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),
          TextFormField(
            controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter Task Title',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.black45,),
                ),
          const SizedBox(height: 24),
          Text(
              'Set Deadline',
              style: GoogleFonts.lateef(
                color: Colors.grey,
                fontSize: 22,
                fontWeight: FontWeight.normal,
              )
          ),

          Container(
            height: 50,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                //deadlineDate = newDateTime.toString();
                deadlineDate = Jiffy(newDateTime).format('EEE, do');
              },
              use24hFormat: false,
              minuteInterval: 1,
            ),
          ),

          const SizedBox(height: 24),
          TextFormField(
            controller: descController,
            maxLines: 5,
                decoration: InputDecoration(
                hintText: 'Enter Task Description',
                border: InputBorder.none,
                ),
            ),
          SizedBox(height: 20),

            Center(
              child: FloatingActionButton(
                child: Icon(Icons.add),
                 onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      descController.text.isNotEmpty) {
                    setState(() {
                      todos.add(TodoModelClass(
                        title: titleController.text,
                        description: descController.text,
                        dateTime: DateTime.now(),
                      ));
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Media query helps us get the device SIZE (height, width) property
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Task Calender', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        leading: InkWell(child: Icon(Icons.menu, color: Colors.white70),),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors. deepOrange,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                height: size.height/6,
                color: Colors.transparent,
                     child:  Column(
                        children: [
                       Text('YOUR ROAD TO GREATNESS',
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: 14,
                       fontWeight: FontWeight.w900,
                     ),
                        ),
                      SizedBox( height: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          height: size.height /4,
                          width: double.infinity,
                          child: CircleAvatar(radius: 30.0, backgroundImage: ExactAssetImage('assets/image/jazz.jpeg',)),
                        ),
                      ),
                        ],
                    ),
                    ),
              SizedBox( height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return new AlertDialog(
                                  title: new Text('Do you want  "${todos[index].title}" deleted? '),
                                  actions: <Widget>[
                                    IconButton(
                                        icon: new Icon(Icons.delete, color:  Colors.red,),
                                        onPressed: () {
                                          _removeTodoItem(index);
                                          Navigator.of(context).pop();}
                                    ),
                                  ],
                              );
                            }
                        );
                      },
                      onLongPress: () {
                        showDialogFunc(context, todos[index].title, todos[index].description,);
                      },

                      //Add a title
                      child: Card(
                        //elevation: 4,
                        shadowColor: Colors.black87,
                        child: SizedBox(
                          height:50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
                                      child: IconButton(
                                       icon: Icon(Icons.verified,
                                        size: 20,
                                         color: resetColor,
                                      ),
                                        onPressed: (){
                                            setState(() {
                                              updateColor(2);

                                            });
                                        },
                                    ),
                                    ),

                                    Text(
                                      todos[index].title,
                                      style: GoogleFonts.lateef(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Spacer(),

                                    Text(
                                      //currentDate,
                                      deadlineDate,
                                      style: GoogleFonts.lateef(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        elevation: 14,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        onPressed: () {
          // clear the controller value as soon as you tap on the FAB
          titleController.clear();
          descController.clear();
          _showInputFieldWidget(context);
        },
        tooltip: 'Add Todo',
        child: Icon(
          Icons.edit,
          size: 35,
          color: Colors.black,
        ),
      ),
    );
  }
}


showDialogFunc(context, titleController, descController) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.width * 1.5,
            width: MediaQuery.of(context).size.width * 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.redAccent,
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      }
                  ),
                ),

                Text(
                  titleController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10.0),

                RichText(
                  text: TextSpan(
                    text: 'Date Created: ',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                      //fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${currentDate}\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      TextSpan(
                        text: 'Deadline Date: ',
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 14,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),

                      TextSpan(
                        text: '${deadlineDate}\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                Row(
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    Spacer(),

                    Text(
                      'to be completed',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Center(
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    padding: EdgeInsets.all(14.0),
                    //height: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      //boxShadow: BoxShadow[12,10],
                    ),
                    child: Text(
                      descController,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.purpleAccent,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: FloatingActionButton(
                    backgroundColor: Colors.black45,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                       Icons.save,
                        color: Colors.deepPurple
                      )
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    },
  );
}

class TodoModelClass {
  final String title;
  final String description;
  final DateTime dateTime;
  final bool doneState;
  final DateFormat dateFormat;

  TodoModelClass({
    this.title,
    this.description,
    this.dateTime,
    this.dateFormat,
    this.doneState = false,
  });

}