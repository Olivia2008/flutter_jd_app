class RangeModel {
  bool result;
  int code;
  Null message;
  Data data;

  RangeModel({this.result, this.code, this.message, this.data});

  RangeModel.fromJson(Map<String, dynamic> json) {
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
  List<ListSkuRange> listSkuRange;
  int totalCount;

  Data({this.newSkuId, this.listSkuRange, this.totalCount});

  Data.fromJson(Map<String, dynamic> json) {
    newSkuId = json['newSkuId'];
    if (json['listSkuRange'] != null) {
      listSkuRange = new List<ListSkuRange>();
      json['listSkuRange'].forEach((v) {
        listSkuRange.add(new ListSkuRange.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newSkuId'] = this.newSkuId;
    if (this.listSkuRange != null) {
      data['listSkuRange'] = this.listSkuRange.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class ListSkuRange {
  int id;
  int skuId;
  String productName;
  String mainImgPath;
  int shopId;
  int verderId;
  String shopName;
  int shopCategory;
  String shopPath;
  int newUsedFlag;
  String productAttributeMap;
  String productAttribute;
  bool hasStock;
  double usedNo;
  int productType;
  int showState;
  int price;
  List<String> inspectedTag;
  String originalCost;
  String reducePrice;
  String discount;
  List<String> inspectServices;

  ListSkuRange(
      {this.id,
      this.skuId,
      this.productName,
      this.mainImgPath,
      this.shopId,
      this.verderId,
      this.shopName,
      this.shopCategory,
      this.shopPath,
      this.newUsedFlag,
      this.productAttributeMap,
      this.productAttribute,
      this.hasStock,
      this.usedNo,
      this.productType,
      this.showState,
      this.price,
      this.inspectedTag,
      this.originalCost,
      this.reducePrice,
      this.discount,
      this.inspectServices});

  ListSkuRange.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuId = json['skuId'];
    productName = json['productName'];
    mainImgPath = json['mainImgPath'];
    shopId = json['shopId'];
    verderId = json['verderId'];
    shopName = json['shopName'];
    shopCategory = json['shopCategory'];
    shopPath = json['shopPath'];
    newUsedFlag = json['newUsedFlag'];
    productAttributeMap = json['productAttributeMap'];
    productAttribute = json['productAttribute'];
    hasStock = json['hasStock'];
    usedNo = json['usedNo'];
    productType = json['productType'];
    showState = json['showState'];
    price = json['price'];
    inspectedTag = json['inspectedTag'].cast<String>();
    originalCost = json['originalCost'];
    reducePrice = json['reducePrice'];
    discount = json['discount'];
    inspectServices = json['inspectServices'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['skuId'] = this.skuId;
    data['productName'] = this.productName;
    data['mainImgPath'] = this.mainImgPath;
    data['shopId'] = this.shopId;
    data['verderId'] = this.verderId;
    data['shopName'] = this.shopName;
    data['shopCategory'] = this.shopCategory;
    data['shopPath'] = this.shopPath;
    data['newUsedFlag'] = this.newUsedFlag;
    data['productAttributeMap'] = this.productAttributeMap;
    data['productAttribute'] = this.productAttribute;
    data['hasStock'] = this.hasStock;
    data['usedNo'] = this.usedNo;
    data['productType'] = this.productType;
    data['showState'] = this.showState;
    data['price'] = this.price;
    data['inspectedTag'] = this.inspectedTag;
    data['originalCost'] = this.originalCost;
    data['reducePrice'] = this.reducePrice;
    data['discount'] = this.discount;
    data['inspectServices'] = this.inspectServices;
    return data;
  }
}