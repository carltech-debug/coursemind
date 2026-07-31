import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_topic.dart';

class CourseTopicRepository {
  CourseTopicRepository({
    FirebaseFirestore? firestore,
  }) : _firestore =
            firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>>
      _topics({
    required String institutionId,
    required String programmeId,
    required String courseId,
  }) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('programmes')
        .doc(programmeId)
        .collection('courses')
        .doc(courseId)
        .collection('topics');
  }

  Future<List<CourseTopic>> getTopics({
    required String institutionId,
    required String programmeId,
    required String courseId,
  }) async {
    final snapshot = await _topics(
      institutionId: institutionId,
      programmeId: programmeId,
      courseId: courseId,
    ).orderBy('order').get();

    return snapshot.docs
        .map(
          (doc) => CourseTopic.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }

  Future<void> createTopic({
    required String institutionId,
    required String programmeId,
    required String courseId,
    required CourseTopic topic,
  }) async {
    await _topics(
      institutionId: institutionId,
      programmeId: programmeId,
      courseId: courseId,
    ).doc(topic.id).set(topic.toMap());
  }

  Future<void> updateTopic({
    required String institutionId,
    required String programmeId,
    required String courseId,
    required CourseTopic topic,
  }) async {
    await _topics(
      institutionId: institutionId,
      programmeId: programmeId,
      courseId: courseId,
    ).doc(topic.id).update(topic.toMap());
  }

  Future<void> deleteTopic({
    required String institutionId,
    required String programmeId,
    required String courseId,
    required String topicId,
  }) async {
    await _topics(
      institutionId: institutionId,
      programmeId: programmeId,
      courseId: courseId,
    ).doc(topicId).delete();
  }
}