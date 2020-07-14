
class CategoryModel {
  CategoryData data;

  CategoryModel({this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CategoryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class CategoryData {
  List<Searchwords> searchwords;
  List<CategoryList> categoryList;
  List<HotCategory> hotCategory;
  List<Household> household;

  CategoryData({this.searchwords, this.categoryList, this.hotCategory, this.household});
//  factory CategoryData.fromJson(dynamic json) {
//    return CategoryData(
//      searchwords: json['searchwords'],
//        categoryList: json['categoryList'],
//        hotCategory: json['hotCategory'],
//        household: json['household']
//    );
//  }
  CategoryData.fromJson(Map<String, dynamic> json) {
    if (json['searchwords'] != null) {
      searchwords = new List<Searchwords>();
      json['searchwords'].forEach((v) {
        searchwords.add(new Searchwords.fromJson(v));
      });
    }
    if (json['categoryList'] != null) {
      categoryList = new List<CategoryList>();
      json['categoryList'].forEach((v) {
        categoryList.add(new CategoryList.fromJson(v));
      });
    }
    if (json['hotCategory'] != null) {
      hotCategory = new List<HotCategory>();
      json['hotCategory'].forEach((v) {
        hotCategory.add(new HotCategory.fromJson(v));
      });
    }
    if (json['household'] != null) {
      household = new List<Household>();
      json['household'].forEach((v) {
        household.add(new Household.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchwords != null) {
      data['searchwords'] = this.searchwords.map((v) => v.toJson()).toList();
    }
    if (this.categoryList != null) {
      data['categoryList'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    if (this.hotCategory != null) {
      data['hotCategory'] = this.hotCategory.map((v) => v.toJson()).toList();
    }
    if (this.household != null) {
      data['household'] = this.household.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Searchwords {
  String searchword;
  String showword;

  Searchwords({this.searchword, this.showword});

  Searchwords.fromJson(Map<String, dynamic> json) {
    searchword = json['searchword'];
    showword = json['showword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchword'] = this.searchword;
    data['showword'] = this.showword;
    return data;
  }
}

class CategoryList {
  String title;

  CategoryList({this.title});

  CategoryList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}

class HotCategory {
  String img;
  String title;

  HotCategory({this.img, this.title});

  HotCategory.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['title'] = this.title;
    return data;
  }
}

class Household {
  String img;
  String title;

  Household({this.img, this.title});

  Household.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['title'] = this.title;
    return data;
  }
}