//class CategoryNavModel {
//  Data data;
//
//  CategoryNavModel({this.data});
//
//  CategoryNavModel.fromJson(Map<String, dynamic> json) {
//    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.data != null) {
//      data['data'] = this.data.toJson();
//    }
//    return data;
//  }
//}
//
//class Data {
//  String message;
//  List<Result> result;
//
//  Data({this.message, this.result});
//
//  Data.fromJson(Map<String, dynamic> json) {
//    message = json['message'];
//    if (json['result'] != null) {
//      result = new List<Result>();
//      json['result'].forEach((v) {
//        result.add(new Result.fromJson(v));
//      });
//    }
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['message'] = this.message;
//    if (this.result != null) {
//      data['result'] = this.result.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//}
//
//class Result {
//  String title;
//  List<SubList> subList;
//
//  Result({this.title, this.subList});
//
//  Result.fromJson(Map<String, dynamic> json) {
//    title = json['title'];
//    if (json['subList'] != null) {
//      subList = new List<SubList>();
//      json['subList'].forEach((v) {
//        subList.add(new SubList.fromJson(v));
//      });
//    }
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['title'] = this.title;
//    if (this.subList != null) {
//      data['subList'] = this.subList.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//}
//
//class SubList {
//  String title;
//
//  SubList({this.title});
//
//  SubList.fromJson(Map<String, dynamic> json) {
//    title = json['title'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['title'] = this.title;
//    return data;
//  }
//}

class CategoryNavModel {
  Data data;

  CategoryNavModel({this.data});

  CategoryNavModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String message;
  List<Result> result;

  Data({this.message, this.result});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String id;
  String title;
  List<SubList> subList;

  Result({this.id, this.title, this.subList});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['subList'] != null) {
      subList = new List<SubList>();
      json['subList'].forEach((v) {
        subList.add(new SubList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.subList != null) {
      data['subList'] = this.subList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubList {
  String id;
  String title;

  SubList({this.id, this.title});

  SubList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}