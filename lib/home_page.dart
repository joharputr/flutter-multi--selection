import 'package:flutter/material.dart';
import 'package:flutter_app_custom_clipper/griditem.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> itemList;
  List<Item> selectedList;

  List<bool> isSelected = [];

  @override
  void initState() {
    loadList();
    super.initState();
  }

  loadList() {
    itemList = List();
    selectedList = List();
    for (int i = 0; i < 20; i++) {
      isSelected.add(false);
      itemList.add(Item(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: GridView.builder(
          itemCount: itemList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.56,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected[index] == true)
                    isSelected[index] = false;
                  else
                    isSelected[index] = true;
                });
              },
              child: Stack(
                children: <Widget>[
                  Icon(Icons.add),
                  isSelected[index]
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            );
          }),
    );
  }

  getAppBar() {
    return AppBar(
      title: Text(selectedList.length < 1
          ? "Multi Selection"
          : "${selectedList.length} item selected"),
      actions: <Widget>[
        selectedList.length < 1
            ? Container()
            : InkWell(
                onTap: () {
                  setState(() {
                    for (int i = 0; i < selectedList.length; i++) {
                      itemList.remove(selectedList[i]);
                    }
                    selectedList = List();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.delete),
                ))
      ],
    );
  }
}

class Item {
  int rank;

  Item(this.rank);
}
