
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({this.hintText});
  final String hintText;
  final controller = TextEditingController();
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
//      Container(
//        height: 26,
//        alignment: Alignment.center,
//        width: ScreenUtil().setWidth(580),
//        decoration: BoxDecoration(
//          color: Color(0xFFF7F7F7),
//          borderRadius: BorderRadius.circular(50.0),
//        ),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.only(left: 10),
//              child: Icon(Icons.search, color: Colors.grey, size: ScreenUtil().setSp(46),),
//            ),
//            Expanded(
//              child: Container(
//                alignment: Alignment.center,
//                padding: EdgeInsets.only(left: 6),
//                width: ScreenUtil().setWidth(440),
//                child: TextField(
//                  textAlignVertical: TextAlignVertical.center,
//                  controller: controller,
//                  decoration: InputDecoration(
//                    // contentPadding: EdgeInsets.only(top: 0.0),
//                      hintText: 'Search', border: InputBorder.none),
//                  // onChanged: onSearchTextChanged,
//                ),
//              ),
//            ),
//            IconButton(
//              icon: new Icon(Icons.cancel),
//              color: Colors.grey,
//              iconSize: ScreenUtil().setSp(36),
//              onPressed: () {
//                // controller.clear();
//                query = '';
//                showSuggestions(context);
//              },
//            ),
//          ],
//        ),
//      ),
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
      Text('搜索')
    ];
    // throw UnimplementedError();
  }
  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //throw UnimplementedError();
    return ListView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // throw UnimplementedError();
    return ListView();
  }
  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return super.appBarTheme(context);
  }
}