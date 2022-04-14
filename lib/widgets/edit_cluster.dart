import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fractal/data/database.dart';
import 'package:o_color_picker/o_color_picker.dart';



class EditClusterPage extends StatefulWidget {
  static String routeName = '/edit_cluster';

  final String clusterKey;

  EditClusterPage({Key? key, required this.clusterKey}) : super(key: key);

  @override
  _EditClusterPageState createState() => new _EditClusterPageState();
}

class _EditClusterPageState extends State<EditClusterPage> {
  final _nameFieldTextController = new TextEditingController();
  Color? selectedColor = Color(0xFF5C98F1);
  StreamSubscription? _subscriptionName;

  @override
  void initState() {
    _nameFieldTextController.clear();

    Database.getNameStream(widget.clusterKey, _updateName)
        .then((StreamSubscription s) => _subscriptionName = s);

    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionName != null) {
      _subscriptionName!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Редактирование Кластеров"),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: TextField(
              controller: _nameFieldTextController,
              decoration: InputDecoration(
                  icon: Icon(Icons.edit),
                  labelText: "Имя кластера",
                  hintText: "Введите имя кластера..."
              ),
              onChanged: (String value) {
                Database.saveName(widget.clusterKey,value);
                Database.saveColor(widget.clusterKey, selectedColor.toString().substring(6,16));
              },
            ),

          )
          ,
          Padding(
              padding: EdgeInsets.only(bottom: 20,left: 40),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (var states) => selectedColor!,
                    )),
                child: Text(
                  'Выбири цвет для кластера',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (_) => Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OColorPicker(
                          selectedColor: selectedColor,
                          colors: primaryColorsPalette,
                          onColorChange: (color) {
                            setState(() {
                              selectedColor = color;
                              Database.saveColor(widget.clusterKey, selectedColor.toString().substring(6,16));
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (var states) => Color(0xff8c0000),

                    )),
                child: Text(
                  'Удалить кластер',
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
                onPressed: (){Database.delCluster(widget.clusterKey);}
              )
          ),
        ],
      ),
    );
  }

  void _updateName(String name) {
    _nameFieldTextController.value = _nameFieldTextController.value.copyWith(
      text: name,
    );
  }
}