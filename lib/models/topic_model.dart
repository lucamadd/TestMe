class Topic {
  int id;
  String title;
  String priority;
  int status;

  Topic({this.title, this.priority, this.status});
  Topic.withId({this.id, this.title, this.priority, this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }

    map['title'] = title;
    map['priority'] = priority;
    map['status'] = status;
    return map;
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic.withId(
        id: map['id'],
        title: map['title'],
        priority: map['priority'],
        status: map['status']);
  }
}
