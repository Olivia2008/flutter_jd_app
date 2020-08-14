import 'package:flutter/material.dart';
import 'package:netease_news/views/provides/counter.dart';
import 'package:provide/provide.dart';
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     // child: Provide<Counter>(
  //     //   builder: (context, child, counter) {
  //     //     return Text('${counter.count}');
  //     //   },
  //     // )
  //     child: Column(
  //         children: <Widget>[
  //           TextField(
  //             onChanged: (text) {
  //               print("First text field: $text");
  //             },
  //           ),
  //           TextField(
  //             controller: myController,
  //           ),
  //         ],
  //       ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }

}
