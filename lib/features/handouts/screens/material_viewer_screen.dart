import 'package:flutter/material.dart';

import '../../../data/models/course_material.dart';

class MaterialViewerScreen
    extends StatelessWidget {
  const MaterialViewerScreen({
    super.key,
    required this.material,
  });

  final CourseMaterial material;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(material.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(
            Icons.picture_as_pdf_outlined,
            size: 80,
          ),
          const SizedBox(height: 24),
          Text(
            material.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            material.fileName,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.description_outlined,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Development PDF Viewer',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This screen is ready for the real PDF viewer. Firebase Storage and PDF rendering will be connected before production.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Access: ${material.accessType}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}