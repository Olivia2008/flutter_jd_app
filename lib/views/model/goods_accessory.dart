class AccessoryModel {
  int status;
  Result result;

  AccessoryModel({this.status, this.result});

  AccessoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String skuId;
  Accessories accessories;
  Suit suit;

  Result({this.skuId, this.accessories, this.suit});

  Result.fromJson(Map<String, dynamic> json) {
    skuId = json['SkuId'];
    accessories = json['accessories'] != null
        ? new Accessories.fromJson(json['accessories'])
        : null;
    suit = json['suit'] != null ? new Suit.fromJson(json['suit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SkuId'] = this.skuId;
    if (this.accessories != null) {
      data['accessories'] = this.accessories.toJson();
    }
    if (this.suit != null) {
      data['suit'] = this.suit.toJson();
    }
    return data;
  }
}

class Accessories {
  String wName;
  String wid;
  String imageUrl;
  String chBrand;
  String model;
  List<AccList> accList;
  String wMeprice;
  String wMaprice;

  Accessories(
      {this.wName,
      this.wid,
      this.imageUrl,
      this.chBrand,
      this.model,
      this.accList,
      this.wMeprice,
      this.wMaprice});

  Accessories.fromJson(Map<String, dynamic> json) {
    wName = json['wName'];
    wid = json['wid'];
    imageUrl = json['imageUrl'];
    chBrand = json['chBrand'];
    model = json['model'];
    if (json['accList'] != null) {
      accList = new List<AccList>();
      json['accList'].forEach((v) {
        accList.add(new AccList.fromJson(v));
      });
    }
    wMeprice = json['wMeprice'];
    wMaprice = json['wMaprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wName'] = this.wName;
    data['wid'] = this.wid;
    data['imageUrl'] = this.imageUrl;
    data['chBrand'] = this.chBrand;
    data['model'] = this.model;
    if (this.accList != null) {
      data['accList'] = this.accList.map((v) => v.toJson()).toList();
    }
    data['wMeprice'] = this.wMeprice;
    data['wMaprice'] = this.wMaprice;
    return data;
  }
}

class AccList {
  List<AccessoryShows> accessoryShows;
  String typeName;
  String typeId;

  AccList({this.accessoryShows, this.typeName, this.typeId});

  AccList.fromJson(Map<String, dynamic> json) {
    if (json['accessoryShows'] != null) {
      accessoryShows = new List<AccessoryShows>();
      json['accessoryShows'].forEach((v) {
        accessoryShows.add(new AccessoryShows.fromJson(v));
      });
    }
    typeName = json['typeName'];
    typeId = json['typeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accessoryShows != null) {
      data['accessoryShows'] =
          this.accessoryShows.map((v) => v.toJson()).toList();
    }
    data['typeName'] = this.typeName;
    data['typeId'] = this.typeId;
    return data;
  }
}

class AccessoryShows {
  String wName;
  String wid;
  String imageUrl;
  String wMaprice;

  AccessoryShows({this.wName, this.wid, this.imageUrl, this.wMaprice});

  AccessoryShows.fromJson(Map<String, dynamic> json) {
    wName = json['wName'];
    wid = json['wid'];
    imageUrl = json['imageUrl'];
    wMaprice = json['wMaprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wName'] = this.wName;
    data['wid'] = this.wid;
    data['imageUrl'] = this.imageUrl;
    data['wMaprice'] = this.wMaprice;
    return data;
  }
}

class Suit {
  List<PackList> packList;
  String mainSkuId;
  String original;
  String mainSkuName;
  String mainSkuPicUrl;
  bool empty;

  Suit(
      {this.packList,
      this.mainSkuId,
      this.original,
      this.mainSkuName,
      this.mainSkuPicUrl,
      this.empty});

  Suit.fromJson(Map<String, dynamic> json) {
    if (json['packList'] != null) {
      packList = new List<PackList>();
      json['packList'].forEach((v) {
        packList.add(new PackList.fromJson(v));
      });
    }
    mainSkuId = json['mainSkuId'];
    original = json['original'];
    mainSkuName = json['mainSkuName'];
    mainSkuPicUrl = json['mainSkuPicUrl'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packList != null) {
      data['packList'] = this.packList.map((v) => v.toJson()).toList();
    }
    data['mainSkuId'] = this.mainSkuId;
    data['original'] = this.original;
    data['mainSkuName'] = this.mainSkuName;
    data['mainSkuPicUrl'] = this.mainSkuPicUrl;
    data['empty'] = this.empty;
    return data;
  }
}

class PackList {
  String packOriginalPrice;
  String packPromotionPrice;
  String displayOrder;
  String packType;
  List<SuitSkuPriceList> suitSkuPriceList;
  String salesNum;
  List<PoolList> poolList;
  String baseSuitDiscount;
  String packId;
  String suitType;
  String suitDiscount;
  String packName;
  String limitUserType;
  String extType;

  PackList(
      {this.packOriginalPrice,
      this.packPromotionPrice,
      this.displayOrder,
      this.packType,
      this.suitSkuPriceList,
      this.salesNum,
      this.poolList,
      this.baseSuitDiscount,
      this.packId,
      this.suitType,
      this.suitDiscount,
      this.packName,
      this.limitUserType,
      this.extType});

  PackList.fromJson(Map<String, dynamic> json) {
    packOriginalPrice = json['packOriginalPrice'];
    packPromotionPrice = json['packPromotionPrice'];
    displayOrder = json['displayOrder'];
    packType = json['packType'];
    if (json['suitSkuPriceList'] != null) {
      suitSkuPriceList = new List<SuitSkuPriceList>();
      json['suitSkuPriceList'].forEach((v) {
        suitSkuPriceList.add(new SuitSkuPriceList.fromJson(v));
      });
    }
    salesNum = json['salesNum'];
    if (json['poolList'] != null) {
      poolList = new List<PoolList>();
      json['poolList'].forEach((v) {
        poolList.add(new PoolList.fromJson(v));
      });
    }
    baseSuitDiscount = json['baseSuitDiscount'];
    packId = json['packId'];
    suitType = json['suitType'];
    suitDiscount = json['suitDiscount'];
    packName = json['packName'];
    limitUserType = json['limitUserType'];
    extType = json['extType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packOriginalPrice'] = this.packOriginalPrice;
    data['packPromotionPrice'] = this.packPromotionPrice;
    data['displayOrder'] = this.displayOrder;
    data['packType'] = this.packType;
    if (this.suitSkuPriceList != null) {
      data['suitSkuPriceList'] =
          this.suitSkuPriceList.map((v) => v.toJson()).toList();
    }
    data['salesNum'] = this.salesNum;
    if (this.poolList != null) {
      data['poolList'] = this.poolList.map((v) => v.toJson()).toList();
    }
    data['baseSuitDiscount'] = this.baseSuitDiscount;
    data['packId'] = this.packId;
    data['suitType'] = this.suitType;
    data['suitDiscount'] = this.suitDiscount;
    data['packName'] = this.packName;
    data['limitUserType'] = this.limitUserType;
    data['extType'] = this.extType;
    return data;
  }
}

class SuitSkuPriceList {
  String salesPrice;
  String finalPrice;
  String skuId;

  SuitSkuPriceList({this.salesPrice, this.finalPrice, this.skuId});

  SuitSkuPriceList.fromJson(Map<String, dynamic> json) {
    salesPrice = json['salesPrice'];
    finalPrice = json['finalPrice'];
    skuId = json['skuId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesPrice'] = this.salesPrice;
    data['finalPrice'] = this.finalPrice;
    data['skuId'] = this.skuId;
    return data;
  }
}

class PoolList {
  List<String> saleNames;
  String promoIdPoolId;
  String numb;
  String displayOrder;
  String poolId;
  String selectState;
  SaleProp saleProp;
  List<ColorList> colorList;

  PoolList(
      {this.saleNames,
      this.promoIdPoolId,
      this.numb,
      this.displayOrder,
      this.poolId,
      this.selectState,
      this.saleProp,
      this.colorList});

  PoolList.fromJson(Map<String, dynamic> json) {
    saleNames = json['saleNames'].cast<String>();
    promoIdPoolId = json['promoIdPoolId'];
    numb = json['numb'];
    displayOrder = json['displayOrder'];
    poolId = json['poolId'];
    selectState = json['selectState'];
    saleProp = json['saleProp'] != null
        ? new SaleProp.fromJson(json['saleProp'])
        : null;
    if (json['colorList'] != null) {
      colorList = new List<ColorList>();
      json['colorList'].forEach((v) {
        colorList.add(new ColorList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['saleNames'] = this.saleNames;
    data['promoIdPoolId'] = this.promoIdPoolId;
    data['numb'] = this.numb;
    data['displayOrder'] = this.displayOrder;
    data['poolId'] = this.poolId;
    data['selectState'] = this.selectState;
    if (this.saleProp != null) {
      data['saleProp'] = this.saleProp.toJson();
    }
    if (this.colorList != null) {
      data['colorList'] = this.colorList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaleProp {
  String color;
  String size;

  SaleProp({this.color, this.size});

  SaleProp.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['size'] = this.size;
    return data;
  }
}

class ColorList {
  String skuName;
  String color;
  String size;
  String salesPrice;
  String finalPrice;
  String state;
  String skuPicUrl;
  bool stock;
  String skuId;

  ColorList(
      {this.skuName,
      this.color,
      this.size,
      this.salesPrice,
      this.finalPrice,
      this.state,
      this.skuPicUrl,
      this.stock,
      this.skuId});

  ColorList.fromJson(Map<String, dynamic> json) {
    skuName = json['skuName'];
    color = json['color'];
    size = json['size'];
    salesPrice = json['salesPrice'];
    finalPrice = json['finalPrice'];
    state = json['state'];
    skuPicUrl = json['skuPicUrl'];
    stock = json['stock'];
    skuId = json['skuId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skuName'] = this.skuName;
    data['color'] = this.color;
    data['size'] = this.size;
    data['salesPrice'] = this.salesPrice;
    data['finalPrice'] = this.finalPrice;
    data['state'] = this.state;
    data['skuPicUrl'] = this.skuPicUrl;
    data['stock'] = this.stock;
    data['skuId'] = this.skuId;
    return data;
  }
}