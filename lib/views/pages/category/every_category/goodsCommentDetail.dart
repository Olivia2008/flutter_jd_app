import 'package:flutter/material.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';
import 'package:provide/provide.dart';

class GoodsCommentDetail extends StatefulWidget {
  GoodsCommentDetail(this.params);
  final Map<String, dynamic> params;
  @override
  _GoodsCommentDetailState createState() => _GoodsCommentDetailState();
}

class _GoodsCommentDetailState extends State<GoodsCommentDetail> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  ScrollController _scrollController;
  String _videoUrl = '';
  bool _showTopBtn = false;
  double _screenHeight;
  GoodsCommentDetailModel goodsInfo = null;
  Animation<double> _animation;
  double _topBarHeight = ScreenUtil().setHeight(100.0);
  Color _topBarColor = Color(0xfff5f5f5);
  double _topBarOpacity;

  Future getGoodsInfo(BuildContext context) async {
    await Provide.value<GoodsCommentDetailProvide>(context)
        .getGoodsCommentDetail(widget.params['goodsId'].first);
    return 'goodsInfo的future数据加载完成......';
  }

  @override
  void initState() {
    print(widget.params);
    _scrollController = new ScrollController();
    _scrollController.addListener(HandleAnimation);
    super.initState();
  }

  void HandleAnimation() {
    _screenHeight = MediaQuery.of(context).size.height;

    // 超过一屏显示backTopIcon
    if (_scrollController.offset < _screenHeight && _showTopBtn) {
      setState(() {
        _showTopBtn = false;
      });
    } else if (_scrollController.offset >= _screenHeight &&
        _showTopBtn == false) {
      setState(() {
        _showTopBtn = true;
      });
    }
  }

  @override
  void dispose() {
    // _videoPlayerController.dispose();
    // _chewieController.dispose();
    _scrollController.dispose();
    // _scrollController.removeListener(HandleAnimation);
    super.dispose();
  }

  @override
  void didUpdateWidget(GoodsCommentDetail oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        floatingActionButton: _showTopBtn
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  _scrollController.animateTo(0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                },
                child: Icon(Icons.arrow_upward))
            : null,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
                backgroundColor: Color(0xfff5f5f5).withOpacity(1.0),
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                actions: [
                  Icon(Icons.share),
                  Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 10.0),
                      child: Icon(Icons.more_horiz))
                ],
                title: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    print('colse button');
                  },
                ),
                expandedHeight: ScreenUtil().setHeight(650),
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  // background: Provide<GoodsCommentDetailProvide>(
                  //   builder: (context, child, provider) {
                  //     print(Provide.value<GoodsCommentDetailProvide>(context).goodsInfo);
                  //     if(Provide.value<GoodsCommentDetailProvide>(context).goodsInfo != null) {
                  //       _videoUrl =
                  //             provider
                  //                 .goodsInfo
                  //                 .data
                  //                 .result
                  //                 .introduce
                  //                 .vedio;
                  //         var _videoImg =
                  //             provider
                  //                 .goodsInfo
                  //                 .data
                  //                 .result
                  //                 .introduce
                  //                 .vedioImg;
                  //         _videoPlayerController =
                  //             VideoPlayerController.network(_videoUrl);
                  //         _chewieController = ChewieController(
                  //             videoPlayerController: _videoPlayerController,
                  //             aspectRatio: 16 / 9,
                  //             autoPlay: false,
                  //             looping: true,
                  //             placeholder: Container(
                  //                 width: ScreenUtil().setWidth(750),
                  //                 height: ScreenUtil().setHeight(650),
                  //                 color: Color(0xff000000),
                  //                 alignment: Alignment.center,
                  //                 padding: EdgeInsets.only(
                  //                     top: ScreenUtil().setHeight(200)),
                  //                 child: FadeInImage.assetNetwork(
                  //                     placeholder: 'assets/images/lazy.png',
                  //                     image: _videoImg,
                  //                     width: ScreenUtil().setWidth(750),
                  //                     height: ScreenUtil().setHeight(450),
                  //                     fit: BoxFit.fill)),
                  //             materialProgressColors: ChewieProgressColors(
                  //               playedColor: Color(0xffff9999),
                  //               handleColor: Color(0xff000000),
                  //               backgroundColor: Color(0xff999999),
                  //               bufferedColor: Color(0xffe0e0e0),
                  //             ));
                  //         return Container(
                  //             width: ScreenUtil().setWidth(750),
                  //             height: ScreenUtil().setHeight(650),
                  //             color: Color(0xffeeeeee),
                  //             // padding: EdgeInsets.only(
                  //             //     top: ScreenUtil().setHeight(150)),
                  //             alignment: Alignment.center,
                  //             child: Column(children: <Widget>[
                  //               Chewie(
                  //                 controller: _chewieController,
                  //               )
                  //             ]));
                  //     } else {
                  //       return Center(child: CircularProgressIndicator());
                  //     }
                  //   }
                  // ),
                  background: FutureBuilder(
                      future: getGoodsInfo(context),
                      builder: (context, snapshot) {
                        print(snapshot.hasData);
                        print(Provide.value<GoodsCommentDetailProvide>(context)
                            .goodsInfo);
                        if (snapshot.hasData) {
                          if (Provide.value<GoodsCommentDetailProvide>(context)
                                  .goodsInfo !=
                              null) {
                            _videoUrl =
                                Provide.value<GoodsCommentDetailProvide>(
                                        context)
                                    .goodsInfo
                                    .data
                                    .result
                                    .introduce
                                    .vedio;
                            var _videoImg =
                                Provide.value<GoodsCommentDetailProvide>(
                                        context)
                                    .goodsInfo
                                    .data
                                    .result
                                    .introduce
                                    .vedioImg;
                            _videoPlayerController =
                                VideoPlayerController.network(_videoUrl);
                            _chewieController = ChewieController(
                                videoPlayerController: _videoPlayerController,
                                aspectRatio: 16 / 9,
                                autoPlay: false,
                                looping: true,
                                placeholder: Container(
                                    width: ScreenUtil().setWidth(750),
                                    height: ScreenUtil().setHeight(550),
                                    color: Color(0xff000000),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(150)),
                                    child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/images/lazy.png',
                                        image: _videoImg,
                                        width: ScreenUtil().setWidth(750),
                                        height: ScreenUtil().setHeight(400),
                                        fit: BoxFit.fill)),
                                materialProgressColors: ChewieProgressColors(
                                  playedColor: Color(0xffff9999),
                                  handleColor: Color(0xff000000),
                                  backgroundColor: Color(0xff999999),
                                  bufferedColor: Color(0xffe0e0e0),
                                ));
                            return Container(
                                width: ScreenUtil().setWidth(750),
                                height: ScreenUtil().setHeight(550),
                                color: Color(0xffeeeeee),
                                // padding: EdgeInsets.only(
                                //     top: ScreenUtil().setHeight(150)),
                                alignment: Alignment.center,
                                child: Column(children: <Widget>[
                                  Chewie(
                                    controller: _chewieController,
                                  )
                                ]));
                          } else {
                            return Container();
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                )),
            SliverPadding(
                padding: EdgeInsets.all(8.0),
                sliver: SliverGrid(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 4),
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Container(
                          alignment: Alignment.center,
                          color: Color(0xffacd),
                          child: Text('grid item $index'));
                    }, childCount: 500)))
          ],
        ));
  }
}
