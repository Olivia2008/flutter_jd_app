import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';


@JsonSerializable()
class HomeModel extends Object{

  @JsonKey(name: 'data')
  Data data;

  HomeModel(this.data,);

  factory HomeModel.fromJson(Map<String, dynamic> srcJson) => _$HomeModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}

@JsonSerializable()
class Data extends Object{

  @JsonKey(name: 'carousel')
  List<Carousel> carousel;

  @JsonKey(name: 'category')
  List<Category> category;

  @JsonKey(name: 'seconds')
  List<Seconds> seconds;

  @JsonKey(name: 'newPerson')
  List<NewPerson> newPerson;

  Data(this.carousel,this.category,this.seconds,this.newPerson,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);
  Map<String, dynamic> toJson() => _$DataToJson(this);

}


@JsonSerializable()
class Carousel extends Object{

  @JsonKey(name: 'imgUrl')
  String imgUrl;

  Carousel(this.imgUrl,);

  factory Carousel.fromJson(Map<String, dynamic> srcJson) => _$CarouselFromJson(srcJson);
  Map<String, dynamic> toJson() => _$CarouselToJson(this);

}


@JsonSerializable()
class Category extends Object{

  @JsonKey(name: 'page')
  List<Page> page;

  Category(this.page,);

  factory Category.fromJson(Map<String, dynamic> srcJson) => _$CategoryFromJson(srcJson);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}


@JsonSerializable()
class Page extends Object{

  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(name: 'title')
  String title;

  Page(this.icon,this.title,);

  factory Page.fromJson(Map<String, dynamic> srcJson) => _$PageFromJson(srcJson);
  Map<String, dynamic> toJson() => _$PageToJson(this);
}


@JsonSerializable()
class Seconds extends Object{

  @JsonKey(name: 'img')
  String img;

  @JsonKey(name: 'discount')
  String discount;

  @JsonKey(name: 'price')
  String price;

  Seconds(this.img,this.discount,this.price,);

  factory Seconds.fromJson(Map<String, dynamic> srcJson) => _$SecondsFromJson(srcJson);
  Map<String, dynamic> toJson() => _$SecondsToJson(this);
}


@JsonSerializable()
class NewPerson extends Object{

  @JsonKey(name: 'img')
  String img;

  NewPerson(this.img,);

  factory NewPerson.fromJson(Map<String, dynamic> srcJson) => _$NewPersonFromJson(srcJson);
  Map<String, dynamic> toJson() => _$NewPersonToJson(this);

}