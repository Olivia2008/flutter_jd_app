class CategoryDetailMainModel {
  MainData data;

  CategoryDetailMainModel({this.data});

  CategoryDetailMainModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new MainData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class MainData {
  String msg;
  Result result;

  MainData({this.msg, this.result});

  MainData.fromJson(Map<String, dynamic> json) {
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
  String id;
  List<Summary> summary;
  int total;

  Result({this.id, this.summary, this.total});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['summary'] != null) {
      summary = new List<Summary>();
      json['summary'].forEach((v) {
        summary.add(new Summary.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.summary != null) {
      data['summary'] = this.summary.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Summary {
  String skuId;
  Priceinfo priceinfo;
  Stockstate stockstate;
  int goodRateShow;
  int commentCount;
  String commentCountStr;
  int sensitiveBook;
  String store;
  List<Storage> storage;
  List<Property> property;
  String title;
  String img;

  Summary(
      {this.skuId,
        this.priceinfo,
        this.stockstate,
        this.goodRateShow,
        this.commentCount,
        this.commentCountStr,
        this.sensitiveBook,
        this.store,
        this.storage,
        this.property,
        this.title,
        this.img});

  Summary.fromJson(Map<String, dynamic> json) {
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
    if (json['property'] != null) {
      property = new List<Property>();
      json['property'].forEach((v) {
        property.add(new Property.fromJson(v));
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
    if (this.property != null) {
      data['property'] = this.property.map((v) => v.toJson()).toList();
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
  String f;
  String g;
  String h;
  String i;
  String j;
  String k;
  String l;
  String m;
  String n;
  String o;
  String p;

  Stockstate(
      {this.a, this.b, this.c, this.d, this.e, this.f, this.g, this.h, this.i, this.j, this.k, this.l, this.m, this.n, this.o, this.p});

  Stockstate.fromJson(Map<String, dynamic> json) {
    a = json['a'];
    b = json['b'];
    c = json['c'];
    d = json['d'];
    e = json['e'];
    f = json['f'];
    g = json['g'];
    h = json['h'];
    i = json['i'];
    j = json['j'];
    k = json['k'];
    l = json['l'];
    m = json['m'];
    n = json['n'];
    o = json['o'];
    p = json['p'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['a'] = this.a;
    data['b'] = this.b;
    data['c'] = this.c;
    data['d'] = this.d;
    data['e'] = this.e;
    data['f'] = this.f;
    data['g'] = this.g;
    data['h'] = this.h;
    data['i'] = this.i;
    data['j'] = this.j;
    data['k'] = this.k;
    data['l'] = this.l;
    data['m'] = this.m;
    data['n'] = this.n;
    data['o'] = this.o;
    data['p'] = this.p;
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

class Property {
  String id;
  String des;

  Property({this.id, this.des});

  Property.fromJson(Map<String, dynamic> json) {
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