import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
// import 'package:netease_news/views/model/GoodsDetailModel.dart';
import 'package:netease_news/views/provides/category_goods_detail.dart';
import 'package:netease_news/views/pages/category/every_category/goods_detail/topArea.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:netease_news/views/model/GoodsDetailModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:netease_news/views/service/service_method.dart';
 import 'dart:convert';

// class GoodsDetail extends StatelessWidget {
//   GoodsDetail(this.params);
//   final Map<String, dynamic> params;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text('商品详情页'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: (){
//             Navigator.pop(context);
//           }
//         )
//       ),
//       body: FutureBuilder(
//         future: getBackGoodsInfo(context),
//         builder: (context, snapshot) {
//           if(snapshot.hasData) {
//           print('snapshotdata:${snapshot.data}');
//           var goodsList = Provide.value<GoodsDetailProvide>(context).goodsInfo;
//           print('snapshot goodsInfo: $goodsList');
//            return Container(
//             child: Column(
//               children: <Widget>[
//                 TopArea(goodsList)
//               ],
//             )
//           );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         }
//       ),
//     );
//   }

//   Future getBackGoodsInfo(BuildContext context) async {
//     await Provide.value<GoodsDetailProvide>(context).getGoodsInfo(params['goodsId'].first);
//     return '加载完成......';
//   }
// }

class GoodsDetail extends StatefulWidget {
  GoodsDetail(this.params);
  final Map<String, dynamic> params;
  @override
  _GoodsDetailState createState() => _GoodsDetailState();
}

class _GoodsDetailState extends State<GoodsDetail> with SingleTickerProviderStateMixin {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  ScrollController _scrollController;
  String _videoUrl = '';
  bool _showTopBtn = false;
  double _screenHeight;
  GoodsDetailModel goodsInfo = null;
  Animation<double> _animation;
  double _topBarHeight = ScreenUtil().setHeight(100);
  AnimationController _animationController;
  Color _topBarColor = Color(0xfff5f5f5);
  double _topBarOpacity;

  // Future getBackGoodsInfo(BuildContext context) async {
  //  await request('goodsDetail', params: {'goodsId': widget.params['goodsId'].first}).then((val) {
  //      var data = json.decode(val.toString());
  //      goodsInfo = GoodsDetailModel.fromJson(data);
  //   print('goodsInfo加载完成....');
  //    });
  //    return goodsInfo;
  // }
  Future getBackGoodsInfo(BuildContext context) async {
   await Provide.value<GoodsDetailProvide>(context).getGoodsInfo(widget.params['goodsId'].first);
   return 'goodsInfo加载完成....';
  }


  @override
  void initState() {
    // TODO: implement initState
    
    _scrollController = new ScrollController();
    _scrollController.addListener(HandleAnimation);
    // _animationController = new AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    super.initState();
  }
  void HandleAnimation() {
    _screenHeight = MediaQuery.of(context).size.height;
    // print('scrollController offset: ${_scrollController.position.toString()}');
    print('scrollController offset: ${_scrollController.offset.toString()}');
    print('screenHeight:$_screenHeight');
    // 超过一屏显示topIcon
    if(_scrollController.offset < _screenHeight && _showTopBtn) {
      setState(() {
        _showTopBtn = false;
      });
    } else if (_scrollController.offset >= _screenHeight && _showTopBtn == false) {
      setState(() {
        _showTopBtn = true;
      });
    }
    // scroll在topBarHeight内显示背景透明度动画
    // if(_scrollController.offset < _topBarHeight) {
    //   _animation = new Tween(begin: 0.0, end: _topBarHeight).animate(_animationController)
    //   ..addListener(HandleOpacity);
    // }
    
  }
  void HandleOpacity() {
    setState(() {
      var heightRatio = _animation.value / _topBarHeight;
      _topBarOpacity = _topBarColor.opacity * heightRatio;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    _chewieController.dispose();
    _scrollController.dispose();
    // _animation ?.removeListener(HandleOpacity);
    // _animationController ?.removeListener(HandleAnimation);
    // _animationController ?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(GoodsDetail oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
        floatingActionButton: _showTopBtn
            ? FloatingActionButton(
                child: Icon(Icons.arrow_upward),
                onPressed: () {
                  _scrollController.animateTo(0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                })
            : null,
        body: CustomScrollView(controller: _scrollController, slivers: <Widget>[
          SliverAppBar(
            // backgroundColor: _topBarColor.withOpacity(_topBarOpacity),
            backgroundColor: Color(0xfff5f5f5).withOpacity(1.0),
            leading: Icon(Icons.arrow_back_ios),
            actions: [
              Icon(Icons.share),
              Padding(
                padding: EdgeInsets.only(right: 20, left: 10),
                child: Icon(Icons.more_horiz),
              )
            ],
            title: IconButton(
              icon: Icon(Icons.close_rounded),
              onPressed: () {print('colose button');},
            ),
            expandedHeight: ScreenUtil().setHeight(800),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                background: FutureBuilder(
                  future: getBackGoodsInfo(context),
                  builder: (context, snapshot) {
                    print('snapshot data:${snapshot.hasData}');
                    if(snapshot.hasData && Provide.value<GoodsDetailProvide>(context).goodsInfo != null) {
                       // _videoUrl = goodsInfo.data.result.introduce.vedio;
                       print('provide goodsinfo:${Provide.value<GoodsDetailProvide>(context).goodsInfo}');
                       _videoUrl = Provide.value<GoodsDetailProvide>(context).goodsInfo.data.result.introduce.vedio;
                       // print('video url:$_videoUrl');
                       var _videoImg = Provide.value<GoodsDetailProvide>(context).goodsInfo.data.result.introduce.vedioImg;
                        _videoPlayerController = VideoPlayerController.network(_videoUrl);
                        _chewieController = ChewieController(
                            videoPlayerController: _videoPlayerController,
                            aspectRatio: 16 / 9,
                            autoPlay: false,
                            looping: true,
                            placeholder: Container(
                              width: ScreenUtil().setWidth(750),
                              height: ScreenUtil().setHeight(630),
                              color: Color(0xff000000),
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: ScreenUtil().setHeight(150)),
                              child: FadeInImage.assetNetwork(
                                width: ScreenUtil().setWidth(750),
                                height: ScreenUtil().setHeight(422),
                                fit: BoxFit.fill,
                                placeholder: 'assets/images/lazy.png',
                                image: _videoImg)
                            ), // 占位图
                            // autoInitialize: !true, //是否在UI构建时就加载
                            materialProgressColors: ChewieProgressColors(
                              playedColor: Color(0xffff9999),
                              handleColor: Color(0xff000000),
                              backgroundColor: Color(0xff999999),
                              bufferedColor: Color(0xffe0e0e0),
                            ));
                      return Container(
                        width: ScreenUtil().setWidth(750),
                        height: ScreenUtil().setHeight(630),
                        color: Color(0xffeeeeee),
                        padding: EdgeInsets.only(top: ScreenUtil().setHeight(150)),
                        alignment: Alignment.center,
                        child: Column(children: <Widget>[
                          Chewie(
                              controller: _chewieController,
                            )
                        ]));
                    } else { 
                      return Center(child: CircularProgressIndicator());
                    }
                  }
                )
          )),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 4
                ),
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Color(0xffacd),
                  child: Text('grid item $index')
                );
              }, childCount: 500,)
            )
          )
        ]));
  }

  
}