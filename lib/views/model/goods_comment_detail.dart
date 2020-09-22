class GoodsCommentDetailModel {
  GoodsDetailData data;

  GoodsCommentDetailModel({this.data});

  GoodsCommentDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new GoodsDetailData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class GoodsDetailData {
  Result result;

  GoodsDetailData({this.result});

  GoodsDetailData.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String skuId;
  String title;
  String subTitle;
  List<Images> images;
  Store store;
  Priceinfo priceinfo;
  Stockstate stockstate;
  List<Discount> discount;
  Selected selected;
  Destination destination;
  List<Question> question;
  Params params;
  Introduce introduce;

  Result(
      {this.skuId,
      this.title,
      this.subTitle,
      this.images,
      this.store,
      this.priceinfo,
      this.stockstate,
      this.discount,
      this.selected,
      this.destination,
      this.question,
      this.params,
      this.introduce});

  Result.fromJson(Map<String, dynamic> json) {
    skuId = json['SkuId'];
    title = json['title'];
    subTitle = json['subTitle'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    priceinfo = json['priceinfo'] != null
        ? new Priceinfo.fromJson(json['priceinfo'])
        : null;
    stockstate = json['stockstate'] != null
        ? new Stockstate.fromJson(json['stockstate'])
        : null;
    if (json['discount'] != null) {
      discount = new List<Discount>();
      json['discount'].forEach((v) {
        discount.add(new Discount.fromJson(v));
      });
    }
    selected = json['selected'] != null
        ? new Selected.fromJson(json['selected'])
        : null;
    destination = json['destination'] != null
        ? new Destination.fromJson(json['destination'])
        : null;
    if (json['question'] != null) {
      question = new List<Question>();
      json['question'].forEach((v) {
        question.add(new Question.fromJson(v));
      });
    }
    params =
        json['params'] != null ? new Params.fromJson(json['params']) : null;
    introduce = json['introduce'] != null
        ? new Introduce.fromJson(json['introduce'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SkuId'] = this.skuId;
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.store != null) {
      data['store'] = this.store.toJson();
    }
    if (this.priceinfo != null) {
      data['priceinfo'] = this.priceinfo.toJson();
    }
    if (this.stockstate != null) {
      data['stockstate'] = this.stockstate.toJson();
    }
    if (this.discount != null) {
      data['discount'] = this.discount.map((v) => v.toJson()).toList();
    }
    if (this.selected != null) {
      data['selected'] = this.selected.toJson();
    }
    if (this.destination != null) {
      data['destination'] = this.destination.toJson();
    }
    if (this.question != null) {
      data['question'] = this.question.map((v) => v.toJson()).toList();
    }
    if (this.params != null) {
      data['params'] = this.params.toJson();
    }
    if (this.introduce != null) {
      data['introduce'] = this.introduce.toJson();
    }
    return data;
  }
}

class Images {
  String img;
  String value;

  Images({this.img, this.value});

  Images.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['value'] = this.value;
    return data;
  }
}

class Store {
  String name;
  String fans;
  String desc;

  Store({this.name, this.fans, this.desc});

  Store.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fans = json['fans'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['fans'] = this.fans;
    data['desc'] = this.desc;
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
  String q;

  Stockstate(
      {this.a,
      this.b,
      this.c,
      this.d,
      this.e,
      this.f,
      this.g,
      this.h,
      this.i,
      this.j,
      this.k,
      this.l,
      this.m,
      this.n,
      this.o,
      this.p,
      this.q});

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
    q = json['q'];
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
    data['q'] = this.q;
    return data;
  }
}

class Discount {
  String title;
  String dis;
  String value;

  Discount({this.title, this.dis, this.value});

  Discount.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    dis = json['dis'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['dis'] = this.dis;
    data['value'] = this.value;
    return data;
  }
}

class Selected {
  String img;
  String price;
  Colors colors;
  Storage storage;
  Methods methods;
  StandMatch standMatch;
  Discount count;
  List<Service> service;

  Selected(
      {this.img,
      this.price,
      this.colors,
      this.storage,
      this.methods,
      this.standMatch,
      this.count,
      this.service});

  Selected.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    price = json['price'];
    colors =
        json['colors'] != null ? new Colors.fromJson(json['colors']) : null;
    storage =
        json['storage'] != null ? new Storage.fromJson(json['storage']) : null;
    methods =
        json['methods'] != null ? new Methods.fromJson(json['methods']) : null;
    standMatch = json['standMatch'] != null
        ? new StandMatch.fromJson(json['standMatch'])
        : null;
    count = json['count'] != null ? new Discount.fromJson(json['count']) : null;
    if (json['service'] != null) {
      service = new List<Service>();
      json['service'].forEach((v) {
        service.add(new Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['price'] = this.price;
    if (this.colors != null) {
      data['colors'] = this.colors.toJson();
    }
    if (this.storage != null) {
      data['storage'] = this.storage.toJson();
    }
    if (this.methods != null) {
      data['methods'] = this.methods.toJson();
    }
    if (this.standMatch != null) {
      data['standMatch'] = this.standMatch.toJson();
    }
    if (this.count != null) {
      data['count'] = this.count.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Colors {
  String title;
  List<ColorList> colorList;

  Colors({this.title, this.colorList});

  Colors.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['colorList'] != null) {
      colorList = new List<ColorList>();
      json['colorList'].forEach((v) {
        colorList.add(new ColorList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.colorList != null) {
      data['colorList'] = this.colorList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ColorList {
  String label;
  String value;

  ColorList({this.label, this.value});

  ColorList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}

class Storage {
  String title;
  List<VersionList> versionList;

  Storage({this.title, this.versionList});

  Storage.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['versionList'] != null) {
      versionList = new List<VersionList>();
      json['versionList'].forEach((v) {
        versionList.add(new VersionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.versionList != null) {
      data['versionList'] = this.versionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VersionList {
  String label;
  String value;

  VersionList({this.label, this.value});

  VersionList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}

class Methods {
  String title;
  List<MethodsList> methodsList;

  Methods({this.title, this.methodsList});

  Methods.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['methodsList'] != null) {
      methodsList = new List<MethodsList>();
      json['methodsList'].forEach((v) {
        methodsList.add(new MethodsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.methodsList != null) {
      data['methodsList'] = this.methodsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MethodsList {
  String label;
  String value;

  MethodsList({this.label, this.value});

  MethodsList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}

class StandMatch {
  String title;
  List<MatchList> matchList;

  StandMatch({this.title, this.matchList});

  StandMatch.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['matchList'] != null) {
      matchList = new List<MatchList>();
      json['matchList'].forEach((v) {
        matchList.add(new MatchList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.matchList != null) {
      data['matchList'] = this.matchList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MatchList {
  String label;
  String value;

  MatchList({this.label, this.value});

  MatchList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}

class Service {
  String title;
  String id;
  List<ServiceList> serviceList;
  List<JdList> jdList;

  Service({this.title, this.id, this.serviceList, this.jdList});

  Service.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    if (json['serviceList'] != null) {
      serviceList = new List<ServiceList>();
      json['serviceList'].forEach((v) {
        serviceList.add(new ServiceList.fromJson(v));
      });
    }
    if (json['jdList'] != null) {
      jdList = new List<JdList>();
      json['jdList'].forEach((v) {
        jdList.add(new JdList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    if (this.serviceList != null) {
      data['serviceList'] = this.serviceList.map((v) => v.toJson()).toList();
    }
    if (this.jdList != null) {
      data['jdList'] = this.jdList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceList {
  String label;
  String more;
  String value;
  List<OriginList> originList;
  List<ScreenList> screenList;
  List<AccList> accList;

  ServiceList(
      {this.label,
      this.more,
      this.value,
      this.originList,
      this.screenList,
      this.accList});

  ServiceList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    more = json['more'];
    value = json['value'];
    if (json['originList'] != null) {
      originList = new List<OriginList>();
      json['originList'].forEach((v) {
        originList.add(new OriginList.fromJson(v));
      });
    }
    if (json['screenList'] != null) {
      screenList = new List<ScreenList>();
      json['screenList'].forEach((v) {
        screenList.add(new ScreenList.fromJson(v));
      });
    }
    if (json['accList'] != null) {
      accList = new List<AccList>();
      json['accList'].forEach((v) {
        accList.add(new AccList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['more'] = this.more;
    data['value'] = this.value;
    if (this.originList != null) {
      data['originList'] = this.originList.map((v) => v.toJson()).toList();
    }
    if (this.screenList != null) {
      data['screenList'] = this.screenList.map((v) => v.toJson()).toList();
    }
    if (this.accList != null) {
      data['accList'] = this.accList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OriginList {
  String label;
  String dis;
  String icon;
  String price;
  String value;

  OriginList({this.label, this.dis, this.icon, this.price, this.value});

  OriginList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    dis = json['dis'];
    icon = json['icon'];
    price = json['price'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['dis'] = this.dis;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['value'] = this.value;
    return data;
  }
}

class ScreenList {
  String label;
  String dis;
  String icon;
  String price;
  String value;

  ScreenList({this.label, this.dis, this.icon, this.price, this.value});

  ScreenList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    dis = json['dis'];
    icon = json['icon'];
    price = json['price'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['dis'] = this.dis;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['value'] = this.value;
    return data;
  }
}

class AccList {
  String label;
  String dis;
  String icon;
  String price;
  String value;

  AccList({this.label, this.dis, this.icon, this.price, this.value});

  AccList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    dis = json['dis'];
    icon = json['icon'];
    price = json['price'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['dis'] = this.dis;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['value'] = this.value;
    return data;
  }
}

class JdList {
  String label;
  String more;
  String value;
  List<DiyList> diyList;
  List<SpecialList> specialList;

  JdList({this.label, this.more, this.value, this.diyList, this.specialList});

  JdList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    more = json['more'];
    value = json['value'];
    if (json['diyList'] != null) {
      diyList = new List<DiyList>();
      json['diyList'].forEach((v) {
        diyList.add(new DiyList.fromJson(v));
      });
    }
    if (json['specialList'] != null) {
      specialList = new List<SpecialList>();
      json['specialList'].forEach((v) {
        specialList.add(new SpecialList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['more'] = this.more;
    data['value'] = this.value;
    if (this.diyList != null) {
      data['diyList'] = this.diyList.map((v) => v.toJson()).toList();
    }
    if (this.specialList != null) {
      data['specialList'] = this.specialList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DiyList {
  String label;
  String dis;
  String icon;
  String price;
  String value;

  DiyList({this.label, this.dis, this.icon, this.price, this.value});

  DiyList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    dis = json['dis'];
    icon = json['icon'];
    price = json['price'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['dis'] = this.dis;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['value'] = this.value;
    return data;
  }
}

class SpecialList {
  String label;
  String dis;
  String icon;
  String price;
  String value;
  SpecialList({this.label, this.dis, this.icon, this.price, this.value});
  SpecialList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    dis = json['dis'];
    icon = json['icon'];
    price = json['price'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['dis'] = this.dis;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['value'] = this.value;
    return data;
  }
}

class Destination {
  String addr;
  String cate;
  String time;
  String res;
  List<Dis> dis;

  Destination({this.addr, this.cate, this.time, this.res, this.dis});

  Destination.fromJson(Map<String, dynamic> json) {
    addr = json['addr'];
    cate = json['cate'];
    time = json['time'];
    res = json['res'];
    if (json['dis'] != null) {
      dis = new List<Dis>();
      json['dis'].forEach((v) {
        dis.add(new Dis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addr'] = this.addr;
    data['cate'] = this.cate;
    data['time'] = this.time;
    data['res'] = this.res;
    if (this.dis != null) {
      data['dis'] = this.dis.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dis {
  String label;

  Dis({this.label});

  Dis.fromJson(Map<String, dynamic> json) {
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    return data;
  }
}

class Question {
  String question;
  String user;
  String avatar;
  String time;
  List<Replay> replay;
  String value;

  Question(
      {this.question,
      this.user,
      this.avatar,
      this.time,
      this.replay,
      this.value});

  Question.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    user = json['user'];
    avatar = json['avatar'];
    time = json['time'];
    if (json['replay'] != null) {
      replay = new List<Replay>();
      json['replay'].forEach((v) {
        replay.add(new Replay.fromJson(v));
      });
    }
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['user'] = this.user;
    data['avatar'] = this.avatar;
    data['time'] = this.time;
    if (this.replay != null) {
      data['replay'] = this.replay.map((v) => v.toJson()).toList();
    }
    data['value'] = this.value;
    return data;
  }
}

class Replay {
  String r;
  String user;
  String time;
  String avatar;

  Replay({this.r, this.user, this.time, this.avatar});

  Replay.fromJson(Map<String, dynamic> json) {
    r = json['r'];
    user = json['user'];
    time = json['time'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r'] = this.r;
    data['user'] = this.user;
    data['time'] = this.time;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Params {
  String desc;
  String code;
  List<ParamList> paramList;

  Params({this.desc, this.code, this.paramList});

  Params.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    code = json['code'];
    if (json['paramList'] != null) {
      paramList = new List<ParamList>();
      json['paramList'].forEach((v) {
        paramList.add(new ParamList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['code'] = this.code;
    if (this.paramList != null) {
      data['paramList'] = this.paramList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParamList {
  String title;
  List<Desc> desc;

  ParamList({this.title, this.desc});

  ParamList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['desc'] != null) {
      desc = new List<Desc>();
      json['desc'].forEach((v) {
        desc.add(new Desc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.desc != null) {
      data['desc'] = this.desc.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Desc {
  String label;
  String value;
  Desc({this.label, this.value});
  Desc.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}

class Introduce {
  String vedio;
  String vedioImg;
  List<String> introList;

  Introduce({this.vedio, this.vedioImg, this.introList});

  Introduce.fromJson(Map<String, dynamic> json) {
    vedio = json['vedio'];
    vedioImg = json['vedioImg'];
    introList = json['introList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vedio'] = this.vedio;
    data['vedioImg'] = this.vedioImg;
    data['introList'] = this.introList;
    return data;
  }
}
