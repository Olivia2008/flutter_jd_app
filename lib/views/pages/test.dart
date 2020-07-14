import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:netease_news/views/config/httpHeaders.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}
class _TestPageState extends State<TestPage> {
  TextEditingController searchController = TextEditingController();
  Dio _dio = Dio();
  String globalSearchText = '';
  String searchList = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TextField(
            controller: searchController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(10.0),
                // label
                labelText: 'Global Search',
                // 下面的提示类似文本框下面的error提示
                helperText: 'please search the keywords'),
            onChanged: (text) {
              setState(() {
                globalSearchText = text;
              });
            },
          ),
          Text(
            globalSearchText,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          RaisedButton(
            onPressed: _getData,
            child: Text('Click to get httpData'),
          ),
          Text(searchList)
        ],
      ),
    );
  }

  //
  void _getData() {
    print('............getHttpData..........');
    if (searchController.text.toString() == '') {
      showDialog(context: context,
          builder: (BuildContext ctx) => AlertDialog(title: Text('不能为空'),)
      );
    } else {
      getHttp(searchController.text.toString()).then((res) {
        print(res);
        List<Map> dataList = null;
        dataList = res;
          setState(() {
            searchList = res['data']['projects'][0]['name'];
          });
      });
    }
  }

  // 数据请求
  Future getHttp(String text) async {
    try {
//      Map<String, dynamic> data = {'searchwords': globalSearchText};
//      Response response;
//      response = await _dio.post(
//          'https://www.easy-mock.com/mock/5e73043fbb41c365b8085dda/base_url/test',
//          queryParameters: data);
     //  _dio.options.headers = httpHeaders;
      Response response;
      response = await _dio.get('http://10.1.48.181:7300/mock/5e782b04dceab80be0b25fca/example/mock');
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
