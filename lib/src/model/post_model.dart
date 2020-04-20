class Post {
  String id;
  String author;
  String description;
  String uid;
  String imageUrl;
  List<String> imageUrls;
  String timePast;
  int timeCreate;
  bool isDelete;
  bool isAttention;

  Post({
    this.id,
    this.author,
    this.description,
    this.uid,
    this.imageUrl,
    this.imageUrls,
    this.timePast,
    this.timeCreate,
    this.isDelete,
    this.isAttention,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'author': author,
    'description': description,
    'uid': uid,
    'imageUrl': imageUrl,
    'imageUrls': imageUrls.map<String>((item) { return item; }).toList(),
    'timeCreate': timeCreate,
    'isDelete': isDelete,
    'isAttention': isAttention
  };

  Post.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? '',
        author = map['author'] ?? '',
        description = map['description'] ?? '',
        uid = map['uid'] ?? '',
        imageUrl = map['imageUrl'] ?? '',
        imageUrls = List<String>.from(map['imageUrls'] ?? []),
        timePast = convert(map['timeCreate'] ?? 0) ?? '',
        timeCreate = map['timeCreate'] ?? 0,
        isDelete = map['isDelete'] ?? false,
        isAttention = map['isAttention'] ?? false;

  static convert(timeCreate) {
    if (timeCreate != 0) {
      final oldDay = new DateTime.fromMillisecondsSinceEpoch(timeCreate);
      final berlinWallFell = new DateTime.now();
      final Duration difference = berlinWallFell.difference(oldDay);
      final int days = difference.inDays;
      final int hours = difference.inHours;
      final int minutes = difference.inMinutes;

      if(difference.inDays == 0) {
        return (hours == 0) ? ((minutes == 0) ? '0 min' : '$minutes ${minutes == 1 ? 'minuto' : 'minutos'}') : '$hours ${hours == 1 ? 'hora' : 'horas'}';
      } else {
        return (days >= 365) ? '${(days/365).floor()} ${(days/365).floor() == 1 ? 'año' : 'años'}' : ((days >= 31) ? '${(days/31).floor()} meses' : '$days dias');
      }
    } else {
      return "indefinido";
    }
  }

  @override
  String toString() => toJson().toString();
}