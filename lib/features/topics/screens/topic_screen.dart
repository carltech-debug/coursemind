import 'package:flutter/material.dart';

import '../../../data/models/course_topic.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({
    super.key,
    required this.topic,
  });

  final CourseTopic topic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(24),
        children: [
          Text(
            topic.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(topic.description),
          const SizedBox(height: 32),
          const Card(
            child: ListTile(
              leading:
                  Icon(Icons.picture_as_pdf),
              title:
                  Text("Learning Materials"),
            ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: ListTile(
              leading:
                  Icon(Icons.smart_toy),
              title: Text("AI Tutor"),
            ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: ListTile(
              leading:
                  Icon(Icons.quiz),
              title: Text("Quiz"),
            ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: ListTile(
              leading:
                  Icon(Icons.show_chart),
              title: Text("Progress"),
            ),
          ),
        ],
      ),
    );
  }
}