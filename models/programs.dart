class Programs {
  String? requestId;
  List<Items>? items;
  int? count;
  String? anyKey;

  Programs({this.requestId, this.items, this.count, this.anyKey});

  Programs.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    count = json['count'];
    anyKey = json['anyKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestId'] = requestId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    data['anyKey'] = anyKey;
    return data;
  }
}

class Items {
  String? createdAt;
  String? name;
  String? category;
  int? lesson;
  String? id;
  String? userName;
  String? mobileNo;
  String? emailId;
  String? city;
  String? password;

  Items(
      {this.createdAt,
      this.name,
      this.category,
      this.lesson,
      this.id,
      this.userName,
      this.mobileNo,
      this.emailId,
      this.city,
      this.password});

  Items.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    name = json['name'];
    category = json['category'];
    lesson = json['lesson'];
    id = json['id'];
    userName = json['userName'];
    mobileNo = json['mobileNo'];
    emailId = json['emailId'];
    city = json['city'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['name'] = name;
    data['category'] = category;
    data['lesson'] = lesson;
    data['id'] = id;
    data['userName'] = userName;
    data['mobileNo'] = mobileNo;
    data['emailId'] = emailId;
    data['city'] = city;
    data['password'] = password;
    return data;
  }
}
