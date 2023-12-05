import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controller/controller.dart';

class DynamicList extends StatefulWidget {
  @override
  _DynamicListState createState() => _DynamicListState();
}

class _DynamicListState extends State<DynamicList> {
  final GoodsController goodsController = Get.put(GoodsController());

  List<Map<String, String>> itemList = []; // List to store selected items
  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown and ListView',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          for (int i = 0; i < itemList.length; i++)
            Row(
              children: [
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.67,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Color(0xff1A535C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03),
                        icon: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Icon(Icons.arrow_drop_down_outlined,
                                size: 40, color: Colors.white),
                          ),
                        ),
                        value: itemList[i]['selectedItem'],
                        alignment: Alignment.center,
                        onChanged: (newValue) {
                          setState(() {
                            itemList[i]['selectedItem'] = newValue.toString();
                          });
                        },
                        dropdownColor: Colors.green,
                        items: goodsController.goodsItems.map((item) => DropdownMenuItem(
                          value: item,
                          child: Center(
                              child: Text(item,
                                  textAlign: TextAlign.center)),
                        )).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (newValue) {
                      itemList[i]['text'] = newValue;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter text',
                    ),
                  ),
                ),
              ],
            ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                itemList.add({
                  'selectedItem': '',
                  'text': '',
                });
              });
            },
            child: Text('Add New'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Assuming both selectedItem and text are required
                // You might want to add validation or handle empty values
                items.add('${itemList.last['selectedItem']} ${itemList.last['text']}');
              });
            },
            child: Text('Add to ListView'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Text(items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
