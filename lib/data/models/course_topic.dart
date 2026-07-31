class CourseTopic {
  const CourseTopic({
    required this.id,
    required this.title,
    required this.description,
    required this.courseId,
    required this.order,
    required this.isPublished,
  });

  final String id;
  final String title;
  final String description;
  final String courseId;
  final int order;
  final bool isPublished;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'courseId': courseId,
      'order': order,
      'isPublished': isPublished,
    };
  }

  factory CourseTopic.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return CourseTopic(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      courseId: map['courseId'] ?? '',
      order: map['order'] ?? 0,
      isPublished: map['isPublished'] ?? false,
    );
  }
}