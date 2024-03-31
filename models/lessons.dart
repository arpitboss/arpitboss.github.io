class Lessons {
  String? requestId;
  List<Items>? items;
  int? count;
  String? anyKey;

  Lessons({this.requestId, this.items, this.count, this.anyKey});

  Lessons.fromJson(Map<String, dynamic> json) {
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
  int? duration;
  String? category;
  bool? locked;
  String? id;

  Items(
      {this.createdAt,
      this.name,
      this.duration,
      this.category,
      this.locked,
      this.id});

  Items.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    name = json['name'];
    duration = json['duration'];
    category = json['category'];
    locked = json['locked'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['name'] = name;
    data['duration'] = duration;
    data['category'] = category;
    data['locked'] = locked;
    data['id'] = id;
    return data;
  }
}
