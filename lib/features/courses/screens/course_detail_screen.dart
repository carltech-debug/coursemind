import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/course.dart';
import '../../../data/models/course_material.dart';
import '../../../data/repositories/mock_course_material_repository.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  State<CourseDetailScreen> createState() =>
      _CourseDetailScreenState();
}

class _CourseDetailScreenState
    extends State<CourseDetailScreen> {
  final _materialRepository =
      MockCourseMaterialRepository();

  List<CourseMaterial> _materials = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMaterials();
  }

  Future<void> _loadMaterials() async {
    try {
      final materials =
          await _materialRepository
              .getPublishedMaterials(
        institutionId:
            widget.course.institutionId,
        programmeId:
            widget.course.programmeId,
        courseId: widget.course.id,
      );

      if (!mounted) return;

      setState(() {
        _materials = materials;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'Unable to load course materials.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.code),
      ),
      body: RefreshIndicator(
        onRefresh: _loadMaterials,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              widget.course.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${widget.course.code} • Level ${widget.course.level}',
              style:
                  Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            Text(
              widget.course.description.isEmpty
                  ? 'No course description available yet.'
                  : widget.course.description,
            ),
            const SizedBox(height: 32),
            const Text(
              'Learning Materials',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (_errorMessage != null)
              Text(_errorMessage!)
            else if (_materials.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'No published materials are available yet.',
                  ),
                ),
              )
            else
              ..._materials.map(
                (material) => Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.picture_as_pdf_outlined,
                      ),
                    ),
                    title: Text(material.title),
                    subtitle: Text(
                      material.accessType == 'premium'
                          ? 'Premium material'
                          : 'Free material',
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                    onTap: () {
                      context.push(
                        '/material-viewer',
                        extra: material,
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}