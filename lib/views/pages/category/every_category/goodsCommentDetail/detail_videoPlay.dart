import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlay extends StatefulWidget {
  VideoPlay(this.data);
  final Introduce data;
  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: Column(
          children: [_videoTitle(context), _videoPlay(context, widget.data)],
        ),
      ),
    );
  }

  Widget _videoTitle(context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.slow_motion_video, size: 14),
              SizedBox(
                width: 6,
              ),
              Text(
                '动态展区',
              )
            ],
          ),
          Text(
            '视频',
            style: TextStyle(color: Color(0xff888888)),
          ),
        ],
      ),
    );
  }

  Widget _videoPlay(context, data) {
    _videoPlayerController =
                    VideoPlayerController.network(data.vedio);
    // return Text('aafaawef');
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0),
      child: Chewie(
        controller: ChewieController(
                    videoPlayerController: _videoPlayerController,
                    aspectRatio: 2 / 1,
                    autoPlay: false,
                    looping: true,
                    autoInitialize: true,
                    placeholder: Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/lazy.png',
                            image: data.vedioImg,
                            width: ScreenUtil().setWidth(600),
                            height: ScreenUtil().setHeight(350),
                            fit: BoxFit.fill)
                    )
                    ),
                    // routePageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondAnimation,  chewieControllerProvider) {
                    //   return AnimatedBuilder(
                    //     animation: animation,
                    //     builder: (BuildContext context, Widget child) {
                    //       return Text('routePageBuilder');
                    //     },
                    //   );
                    // }
                    ),
      ),
    );
  }
}
