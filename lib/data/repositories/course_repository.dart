import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course.dart';

class CourseRepository {
  CourseRepository({
    FirebaseFirestore? firestore,
  }) : _firestore =
            firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>>
      _coursesCollection({
    required String institutionId,
    required String programmeId,
  }) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('programmes')
        .doc(programmeId)
        .collection('courses');
  }

  Future<List<Course>> getPublishedCourses({
    required String institutionId,
    required String programmeId,
  }) async {
    final snapshot = await _coursesCollection(
      institutionId: institutionId,
      programmeId: programmeId,
    )
        .where('active', isEqualTo: true)
        .where('published', isEqualTo: true)
        .get();

    return snapshot.docs
        .map(
          (doc) => Course.fromMap(
            id: doc.id,
            map: doc.data(),
          ),
        )
        .toList();
  }

  Future<List<Course>> getAllCourses({
    required String institutionId,
    required String programmeId,
  }) async {
    final snapshot = await _coursesCollection(
      institutionId: institutionId,
      programmeId: programmeId,
    ).get();

    return snapshot.docs
        .map(
          (doc) => Course.fromMap(
            id: doc.id,
            map: doc.data(),
          ),
        )
        .toList();
  }

  Future<String> createCourse(Course course) async {
    final document = await _coursesCollection(
      institutionId: course.institutionId,
      programmeId: course.programmeId,
    ).add(course.toMap());

    return document.id;
  }

  Future<void> updateCourse(Course course) async {
    await _coursesCollection(
      institutionId: course.institutionId,
      programmeId: course.programmeId,
    )
        .doc(course.id)
        .update(course.toMap());
  }

  Future<void> deleteCourse({
    required String institutionId,
    required String programmeId,
    required String courseId,
  }) async {
    await _coursesCollection(
      institutionId: institutionId,
      programmeId: programmeId,
    ).doc(courseId).delete();
  }
}