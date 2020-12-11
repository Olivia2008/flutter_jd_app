
class CartInfoModel {
  String goodsId;
  String goodsName;
  double price;
  int count;
  String images;
  String selectedText;

  CartInfoModel(
      {this.goodsId,
      this.goodsName,
      this.price,
      this.count,
      this.images,
      this.selectedText});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    price = json['price'];
    count = json['count'];
    images = json['images'];
    selectedText = json['selectedText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['price'] = this.price;
    data['count'] = this.count;
    data['images'] = this.images;
    data['selectedText'] = this.selectedText;
    return data;
  }
}