class GoodsListModel {
  GoodsData data;

  GoodsListModel({this.data});

  GoodsListModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GoodsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class GoodsData {
  String msg;
  List<Result> result;

  GoodsData({this.msg, this.result});

  GoodsData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String goodId;
  String img;
  String title;

  Result({this.goodId, this.img, this.title});

  Result.fromJson(Map<String, dynamic> json) {
    goodId = json['goodId'];
    img = json['img'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodId'] = this.goodId;
    data['img'] = this.img;
    data['title'] = this.title;
    return data;
  }
}