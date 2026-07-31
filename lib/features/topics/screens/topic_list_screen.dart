import 'package:flutter/material.dart';

import '../../../data/models/course.dart';
import '../../../data/models/course_topic.dart';
import '../../../data/repositories/course_topic_repository.dart';

class TopicListScreen extends StatefulWidget {
  const TopicListScreen({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  State<TopicListScreen> createState() =>
      _TopicListScreenState();
}

class _TopicListScreenState
    extends State<TopicListScreen> {
  final CourseTopicRepository _repository =
      CourseTopicRepository();

  bool _loading = true;

  List<CourseTopic> _topics = [];

  @override
  void initState() {
    super.initState();
    _loadTopics();
  }

  Future<void> _loadTopics() async {
    final topics =
        await _repository.getTopics(
      institutionId:
          widget.course.institutionId,
      programmeId:
          widget.course.programmeId,
      courseId: widget.course.id,
    );

    if (!mounted) return;

    setState(() {
      _topics = topics;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.code),
      ),
      body: _loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : ListView.builder(
              padding:
                  const EdgeInsets.all(20),
              itemCount: _topics.length,
              itemBuilder: (context, index) {
                final topic =
                    _topics[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        '${topic.order}',
                      ),
                    ),
                    title: Text(topic.title),
                    subtitle:
                        Text(topic.description),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                );
              },
            ),
    );
  }
}