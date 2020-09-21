import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/category_goods_detail.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:netease_news/views/model/GoodsDetailModel.dart';

class TopArea extends StatefulWidget {
  TopArea(this.goodsInfo);
  GoodsDetailModel goodsInfo;
  @override
  _TopAreaState createState() => _TopAreaState();
}

class _TopAreaState extends State<TopArea> {
  // final videoPlayerController = nVideoPlayerController();
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  ScrollController _scrollController;
  String _videoUrl = '';
  bool _showTopBtn = false;
  double _screenHeight;
  @override
  void initState() {
    // TODO: implement initState
    _scrollController = new ScrollController();
    _videoUrl = widget.goodsInfo.data.result.introduce.vedio;
    _videoPlayerController = VideoPlayerController.network(_videoUrl);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: false,
        looping: true,
        placeholder: FadeInImage.assetNetwork(
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(422),
            fit: BoxFit.fill,
            placeholder: 'assets/images/lazy.png',
            image: widget.goodsInfo.data.result.introduce.vedioImg), // 占位图
        // autoInitialize: !true, //是否在UI构建时就加载
        materialProgressColors: ChewieProgressColors(
          playedColor: Color(0xffff9999),
          handleColor: Color(0xff000000),
          backgroundColor: Color(0xff999999),
          bufferedColor: Color(0xffe0e0e0),
        ));
    _scrollController.addListener(() {
      print(
          'scrollController positions length:${_scrollController.positions.length}');
      print(
          'scrollController position:${_scrollController.position.toString()}');
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    _chewieController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TopArea oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            leading: Icon(Icons.backup),
            title: Container(
                alignment: Alignment.centerRight,
                child: Row(children: <Widget>[
                  Icon(Icons.share),
                  Icon(Icons.more_horiz)
                ])),
            expandedHeight: ScreenUtil().setHeight(530),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
                    width: ScreenUtil().setWidth(750),
                    height: ScreenUtil().setHeight(530),
                    color: Color(0xff000000),
                    alignment: Alignment.center,
                    child: Column(children: <Widget>[
                      Chewie(
                          controller: _chewieController,
                        )
                    ]))),
          )
        ]));
    // return widget.goodsInfo != null ? Container(
    //       width: ScreenUtil().setWidth(750),
    //       height: ScreenUtil().setHeight(530),
    //       color: Color(0xff000000),
    //       alignment: Alignment.center,
    //       child: Column(
    //         children: <Widget>[
    //           // Text('${goodsInfo.data.result.introduce.vedio}')
    //           InkWell(
    //             onTap: () {print('ontap');},
    //             onDoubleTap: () {
    //                print('videoPlayerController value: ${_videoPlayerController.value}');
    //               //  setState(() {
    //               //    if(_videoPlayerController.value.isPlaying) _videoPlayerController.pause();
    //               //    else _videoPlayerController.play();
    //               //  });
    //             },
    //             child: Chewie(
    //               controller: _chewieController,
    //             ),
    //           )
    //         ]
    //       )
    //     ) : Center(child: Text('数据加载中.......'));
  }
}
