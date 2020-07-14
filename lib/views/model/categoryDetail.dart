class CategoryDetailModel {
  Data data;

  CategoryDetailModel({this.data});

  CategoryDetailModel.fromJson(Map<String, dynamic> json) {
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
  String msg;
  Result result;

  Data({this.msg, this.result});

  Data.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<CommentSummaries> commentSummaries;

  Result({this.commentSummaries});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['commentSummaries'] != null) {
      commentSummaries = new List<CommentSummaries>();
      json['commentSummaries'].forEach((v) {
        commentSummaries.add(new CommentSummaries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commentSummaries != null) {
      data['commentSummaries'] =
          this.commentSummaries.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentSummaries {
  int skuId;
  Priceinfo priceinfo;
  Stockstate stockstate;
  int goodRateShow;
  int commentCount;
  String commentCountStr;
  int sensitiveBook;
  String store;
  List<Storage> storage;
  String title;
  String img;

  CommentSummaries(
      {this.skuId,
        this.priceinfo,
        this.stockstate,
        this.goodRateShow,
        this.commentCount,
        this.commentCountStr,
        this.sensitiveBook,
        this.store,
        this.storage,
        this.title,
        this.img});

  CommentSummaries.fromJson(Map<String, dynamic> json) {
    skuId = json['SkuId'];
    priceinfo = json['priceinfo'] != null
        ? new Priceinfo.fromJson(json['priceinfo'])
        : null;
    stockstate = json['stockstate'] != null
        ? new Stockstate.fromJson(json['stockstate'])
        : null;
    goodRateShow = json['GoodRateShow'];
    commentCount = json['CommentCount'];
    commentCountStr = json['CommentCountStr'];
    sensitiveBook = json['SensitiveBook'];
    store = json['store'];
    if (json['storage'] != null) {
      storage = new List<Storage>();
      json['storage'].forEach((v) {
        storage.add(new Storage.fromJson(v));
      });
    }
    title = json['title'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SkuId'] = this.skuId;
    if (this.priceinfo != null) {
      data['priceinfo'] = this.priceinfo.toJson();
    }
    if (this.stockstate != null) {
      data['stockstate'] = this.stockstate.toJson();
    }
    data['GoodRateShow'] = this.goodRateShow;
    data['CommentCount'] = this.commentCount;
    data['CommentCountStr'] = this.commentCountStr;
    data['SensitiveBook'] = this.sensitiveBook;
    data['store'] = this.store;
    if (this.storage != null) {
      data['storage'] = this.storage.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['img'] = this.img;
    return data;
  }
}

class Priceinfo {
  String p;
  String m;
  String op;
  String up;

  Priceinfo({this.p, this.m, this.op, this.up});

  Priceinfo.fromJson(Map<String, dynamic> json) {
    p = json['p'];
    m = json['m'];
    op = json['op'];
    up = json['up'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p'] = this.p;
    data['m'] = this.m;
    data['op'] = this.op;
    data['up'] = this.up;
    return data;
  }
}

class Stockstate {
  String a;
  String b;
  String c;
  String d;
  String e;
  String p;
  String m;
  String op;
  String up;

  Stockstate(
      {this.a,
        this.b,
        this.c,
        this.d,
        this.e,
        this.p,
        this.m,
        this.op,
        this.up});

  Stockstate.fromJson(Map<String, dynamic> json) {
    a = json['a'];
    b = json['b'];
    c = json['c'];
    d = json['d'];
    e = json['e'];
    p = json['p'];
    m = json['m'];
    op = json['op'];
    up = json['up'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['a'] = this.a;
    data['b'] = this.b;
    data['c'] = this.c;
    data['d'] = this.d;
    data['e'] = this.e;
    data['p'] = this.p;
    data['m'] = this.m;
    data['op'] = this.op;
    data['up'] = this.up;
    return data;
  }
}

class Storage {
  String id;
  String des;

  Storage({this.id, this.des});

  Storage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    des = json['des'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['des'] = this.des;
    return data;
  }
}