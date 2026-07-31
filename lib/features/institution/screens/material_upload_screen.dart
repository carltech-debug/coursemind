import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/mock_material_file_storage.dart';
import '../../../data/models/course_material.dart';
import '../../../data/repositories/mock_course_material_repository.dart';

class MaterialUploadScreen
    extends StatefulWidget {
  const MaterialUploadScreen({
    super.key,
    required this.institutionId,
    required this.programmeId,
    required this.courseId,
  });

  final String institutionId;
  final String programmeId;
  final String courseId;

  @override
  State<MaterialUploadScreen> createState() =>
      _MaterialUploadScreenState();
}

class _MaterialUploadScreenState
    extends State<MaterialUploadScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController =
      TextEditingController();

  final _storage = MockMaterialFileStorage();
  final _repository =
      MockCourseMaterialRepository();

  String _accessType = 'free';
  bool _published = false;
  bool _isSaving = false;

  String? _errorMessage;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _simulateUpload() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      const fakePdfBytes = <int>[
        37,
        80,
        68,
        70,
        45,
        49,
        46,
        52,
      ];

      final fileName =
          '${_titleController.text.trim()}.pdf';

      final storagePath =
          await _storage.uploadPdf(
        fileName: fileName,
        bytes: fakePdfBytes,
      );

      final material =
          CourseMaterial(
        id: DateTime.now()
            .microsecondsSinceEpoch
            .toString(),
        title: _titleController.text.trim(),
        description:
            _descriptionController.text.trim(),
        fileName: fileName,
        storagePath: storagePath,
        contentType: 'application/pdf',
        sizeBytes: fakePdfBytes.length,
        accessType: _accessType,
        published: _published,
        institutionId: widget.institutionId,
        programmeId: widget.programmeId,
        courseId: widget.courseId,
        uploadedBy: 'mock_institution',
        createdAt: DateTime.now(),
      );

      await _repository.createMaterial(
        material,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Mock material uploaded successfully.',
          ),
        ),
      );

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
        title: const Text(
          'Upload Material',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text(
                'Development Upload',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This currently simulates a PDF upload. No Firebase Storage is used.',
              ),
              const SizedBox(height: 28),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Material Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Enter a material title.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller:
                    _descriptionController,
                maxLines: 4,
                decoration:
                    const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _accessType,
                decoration:
                    const InputDecoration(
                  labelText: 'Access Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'free',
                    child: Text('Free'),
                  ),
                  DropdownMenuItem(
                    value: 'premium',
                    child: Text('Premium'),
                  ),
                ],
                onChanged: _isSaving
                    ? null
                    : (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _accessType = value;
                        });
                      },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Publish material',
                ),
                subtitle: const Text(
                  'Published materials are visible to students.',
                ),
                value: _published,
                onChanged: _isSaving
                    ? null
                    : (value) {
                        setState(() {
                          _published = value;
                        });
                      },
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .error,
                  ),
                ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed:
                    _isSaving
                        ? null
                        : _simulateUpload,
                child: _isSaving
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Simulate PDF Upload',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}