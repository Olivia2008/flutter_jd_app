// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) {
  return HomeModel(
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    (json['carousel'] as List)
        ?.map((e) =>
            e == null ? null : Carousel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['category'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['seconds'] as List)
        ?.map((e) =>
            e == null ? null : Seconds.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['newPerson'] as List)
        ?.map((e) =>
            e == null ? null : NewPerson.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'carousel': instance.carousel,
      'category': instance.category,
      'seconds': instance.seconds,
      'newPerson': instance.newPerson,
    };

Carousel _$CarouselFromJson(Map<String, dynamic> json) {
  return Carousel(
    json['imgUrl'] as String,
  );
}

Map<String, dynamic> _$CarouselToJson(Carousel instance) => <String, dynamic>{
      'imgUrl': instance.imgUrl,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    (json['page'] as List)
        ?.map(
            (e) => e == null ? null : Page.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'page': instance.page,
    };

Page _$PageFromJson(Map<String, dynamic> json) {
  return Page(
    json['icon'] as String,
    json['title'] as String,
  );
}

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'icon': instance.icon,
      'title': instance.title,
    };

Seconds _$SecondsFromJson(Map<String, dynamic> json) {
  return Seconds(
    json['img'] as String,
    json['discount'] as String,
    json['price'] as String,
  );
}

Map<String, dynamic> _$SecondsToJson(Seconds instance) => <String, dynamic>{
      'img': instance.img,
      'discount': instance.discount,
      'price': instance.price,
    };

NewPerson _$NewPersonFromJson(Map<String, dynamic> json) {
  return NewPerson(
    json['img'] as String,
  );
}

Map<String, dynamic> _$NewPersonToJson(NewPerson instance) => <String, dynamic>{
      'img': instance.img,
    };
