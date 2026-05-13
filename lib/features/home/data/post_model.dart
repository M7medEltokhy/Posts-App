// class PostModel {
//   final int id;
//   final int userId;
//   final String title;
//   final String body;

//   PostModel({
//     required this.id,
//     required this.userId,
//     required this.title,
//     required this.body,
//   });

//   factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
//         id: json['id'],
//         userId: json['userId'],
//         title: json['title'],
//         body: json['body'],
//       );
// }
class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;
  final List<String> tags;
  final int likes;
  final int views;

  PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.tags,
    required this.likes,
    required this.views,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'],
    userId: json['userId'],
    title: json['title'],
    body: json['body'],
    tags: List<String>.from(json['tags'] ?? []),
    likes: json['reactions']['likes'] ?? 0,
    views: json['views'] ?? 0,
  );
}
