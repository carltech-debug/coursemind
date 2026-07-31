import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/course.dart';
import '../../../data/repositories/course_repository.dart';

class CourseCreateScreen extends StatefulWidget {
  const CourseCreateScreen({
    super.key,
    required this.institutionId,
    required this.programmeId,
  });

  final String institutionId;
  final String programmeId;

  @override
  State<CourseCreateScreen> createState() =>
      _CourseCreateScreenState();
}

class _CourseCreateScreenState
    extends State<CourseCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController =
      TextEditingController();

  final _courseRepository = CourseRepository();

  String _level = '100';
  String _semester = 'First Semester';

  bool _isSaving = false;
  String? _errorMessage;

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createCourse() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      final course = Course(
        id: '',
        code: _codeController.text.trim(),
        name: _nameController.text.trim(),
        description:
            _descriptionController.text.trim(),
        level: _level,
        semester: _semester,
        active: true,
        published: false,
        institutionId: widget.institutionId,
        programmeId: widget.programmeId,
        createdAt: DateTime.now(),
      );

      await _courseRepository.createCourse(course);

      if (!mounted) return;

      context.pop();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Course'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Course Code',
                  hintText: 'Example: EEE 101',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Enter the course code.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Course Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Enter the course name.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller:
                    _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _level,
                decoration:
                    const InputDecoration(
                  labelText: 'Level',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: '100',
                    child: Text('Level 100'),
                  ),
                  DropdownMenuItem(
                    value: '200',
                    child: Text('Level 200'),
                  ),
                  DropdownMenuItem(
                    value: '300',
                    child: Text('Level 300'),
                  ),
                  DropdownMenuItem(
                    value: '400',
                    child: Text('Level 400'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _level = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _semester,
                decoration:
                    const InputDecoration(
                  labelText: 'Semester',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'First Semester',
                    child: Text(
                      'First Semester',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Second Semester',
                    child: Text(
                      'Second Semester',
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _semester = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .error,
                  ),
                ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed:
                    _isSaving ? null : _createCourse,
                child: _isSaving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Create Course',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}