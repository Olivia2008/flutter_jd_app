import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';

class AccessoryWidget extends StatelessWidget {
  AccessoryWidget(this.goodsId);
  final String goodsId;

  @override
  Widget build(BuildContext context) {
    Provide.value<GoodsCommentDetailProvide>(context).getGoodsAccessory(goodsId);
    // return Provide<GoodsCommentDetailProvide>(
    //   builder: (context, child, provider) {
    //     if(provider.accessoryInfo != null) {
    //       return Container(child: Text('aaaa'));
    //     } else {
    //       return Center(child: CircularProgressIndicator(),);
    //     }
        
    //   },
    // );
    return Text('aaaaa');
  }
}
