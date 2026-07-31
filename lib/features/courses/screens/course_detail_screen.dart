import 'package:flutter/material.dart';

import '../../../data/models/course.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.code),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            course.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${course.code} • Level ${course.level}',
            style: Theme.of(context)
                .textTheme
                .titleMedium,
          ),
          const SizedBox(height: 24),
          Text(
            course.description.isEmpty
                ? 'No course description available yet.'
                : course.description,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Course materials will appear here in the next section.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}