class GoodsRecommendSearchModel {
  bool result;
  int code;
  Null message;
  Data data;

  GoodsRecommendSearchModel({this.result, this.code, this.message, this.data});

  GoodsRecommendSearchModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String newSkuId;
  Selected selected;
  List<Connection> connection;
  List<History> history;

  Data({this.newSkuId, this.selected, this.connection, this.history});

  Data.fromJson(Map<String, dynamic> json) {
    newSkuId = json['newSkuId'];
    selected = json['selected'] != null
        ? new Selected.fromJson(json['selected'])
        : null;
    if (json['connection'] != null) {
      connection = new List<Connection>();
      json['connection'].forEach((v) {
        connection.add(new Connection.fromJson(v));
      });
    }
    if (json['history'] != null) {
      history = new List<History>();
      json['history'].forEach((v) {
        history.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newSkuId'] = this.newSkuId;
    if (this.selected != null) {
      data['selected'] = this.selected.toJson();
    }
    if (this.connection != null) {
      data['connection'] = this.connection.map((v) => v.toJson()).toList();
    }
    if (this.history != null) {
      data['history'] = this.history.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Selected {
  String name;
  String id;

  Selected({this.name, this.id});

  Selected.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class Connection {
  String name;
  String id;

  Connection({this.name, this.id});

  Connection.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class History {
  String name;
  String id;

  History({this.name, this.id});

  History.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}