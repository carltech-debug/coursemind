import 'package:flutter/material.dart';

import '../../../data/models/course.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/repositories/course_repository.dart';
import '../../../data/repositories/user_profile_repository.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() =>
      _CoursesScreenState();
}

class _CoursesScreenState
    extends State<CoursesScreen> {
  final _profileRepository = UserProfileRepository();
  final _courseRepository = CourseRepository();

  List<Course> _courses = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    try {
      final currentUserProfile =
          await _getUserProfile();

      if (currentUserProfile == null) {
        throw Exception('Student profile not found.');
      }

      final institutionId =
          currentUserProfile.institutionId;

      final programmeId =
          currentUserProfile.programmeId;

      if (institutionId == null ||
          programmeId == null) {
        throw Exception(
          'Institution or programme information is missing.',
        );
      }

      final courses =
          await _courseRepository.getPublishedCourses(
        institutionId: institutionId,
        programmeId: programmeId,
      );

      if (!mounted) return;

      setState(() {
        _courses = courses;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<UserProfile?> _getUserProfile() {
    return _profileRepository.getCurrentUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _errorMessage != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : _courses.isEmpty
                    ? _buildEmptyState()
                    : _buildCourses(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'No published courses are available for your programme yet.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCourses() {
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: _courses.length,
      separatorBuilder: (_, _) =>
          const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final course = _courses[index];

        return Card(
          child: ListTile(
            contentPadding:
                const EdgeInsets.all(16),
            leading: CircleAvatar(
              child: Text(
                course.code.isEmpty
                    ? '?'
                    : course.code[0],
              ),
            ),
            title: Text(
              course.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${course.code} • ${course.semester}',
            ),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}