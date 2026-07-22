class CourseModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final int durationSeconds;
  final String description;
  final String videoUrl;

  const CourseModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.durationSeconds,
    required this.description,
    required this.videoUrl,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      durationSeconds: json['durationSeconds'] ?? 0,
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'durationSeconds': durationSeconds,
      'description': description,
      'videoUrl': videoUrl,
    };
  }
}
