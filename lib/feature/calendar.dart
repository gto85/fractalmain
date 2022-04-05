
import 'dart:collection';
import 'package:flutter/material.dart';

class MyCalendarPage extends StatefulWidget {
  @override
  _MyCalendarPageState createState() => new _MyCalendarPageState();
}
class _MyCalendarPageState extends State<MyCalendarPage>{

  DateTime selectedDate = DateTime.now(); // TO tracking date

  int currentDateSelectedIndex = 0; //For Horizontal Date
  ScrollController scrollController =
  ScrollController(); //To Track Scroll of ListView

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            title: Text('My Calendar'),
          ),
          body: Column(
            children: [
              //To Show Current Date
              Container(
                  height: 30,
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    selectedDate.day.toString() +
                        '-' +
                        listOfMonths[selectedDate.month - 1] +
                        ', ' +
                        selectedDate.year.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.indigo[700]),
                  )),
              SizedBox(height: 10),
              //To show Calendar Widget
              Container(
                  height: 80,
                  child: Container(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 10);
                        },
                        itemCount: 365,
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                currentDateSelectedIndex = index;
                                selectedDate =
                                    DateTime.now().add(Duration(days: index));
                              });
                            },
                            child: Container(
                              height: 80,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(3, 3),
                                        blurRadius: 5)
                                  ],
                                  color: currentDateSelectedIndex == index
                                      ? Colors.black
                                      : Colors.white),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listOfMonths[DateTime.now()
                                        .add(Duration(days: index))
                                        .month -
                                        1]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: currentDateSelectedIndex == index
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    DateTime.now()
                                        .add(Duration(days: index))
                                        .day
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: currentDateSelectedIndex == index
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    listOfDays[DateTime.now()
                                        .add(Duration(days: index))
                                        .weekday -
                                        1]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: currentDateSelectedIndex == index
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ))),
            ],
          ),
        ));
  }
}

class MyScrolPage extends StatefulWidget {
  @override
  _MyScrolPageState createState() => new _MyScrolPageState();
}

class _MyScrolPageState extends State<MyScrolPage> {
  List<Widget> _messages = <Widget>[new Text('hello'), new Text('world')];
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          decoration: new BoxDecoration(color: Colors.blueGrey.shade100),
          width: 100.0,
          height: 100.0,
          child: new Column(
            children: [
              new Flexible(
                child: new ListView(
                  controller: _scrollController,
                  reverse: true,
                  shrinkWrap: true,
                  children: new UnmodifiableListView(_messages),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () {
            setState(() {
              _messages.insert(0, new Text("message ${_messages.length}"));
            });
            _scrollController.animateTo(
              0.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          }
      ),
    );
  }
}

void prints() async{
  print("1");
  print("2");
  print("3");
  print("4");
  print("5");
  print("6");
  print("7");
  print("8");
  print("9");
  print("10");
}