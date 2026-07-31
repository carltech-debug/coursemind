import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/institution_profile.dart';
import '../../../data/repositories/institution_account_repository.dart';
import '../../../data/repositories/institution_profile_repository.dart';
import '../../auth/services/auth_service.dart';

class InstitutionHomeScreen extends StatefulWidget {
  const InstitutionHomeScreen({super.key});

  @override
  State<InstitutionHomeScreen> createState() =>
      _InstitutionHomeScreenState();
}

class _InstitutionHomeScreenState
    extends State<InstitutionHomeScreen> {
  final _authService = AuthService();

  final _accountRepository =
      InstitutionAccountRepository();

  final _institutionRepository =
      InstitutionProfileRepository();

  InstitutionProfile? _institution;

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadInstitution();
  }

  Future<void> _loadInstitution() async {
    try {
      final user = _authService.currentUser;

      if (user == null) {
        throw Exception('No authenticated account.');
      }

      final account =
          await _accountRepository.getAccount(user.uid);

      if (account == null) {
        throw Exception(
          'Institution account not found.',
        );
      }

      final institution =
          await _institutionRepository.getInstitution(
        account.institutionId,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _institution = institution;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorMessage =
            'Unable to load institution account.';
        _isLoading = false;
      });
    }
  }

  Future<void> _signOut() async {
    await _authService.signOut();

    if (!mounted) {
      return;
    }

    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Institution Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
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
                : _buildDashboard(),
      ),
    );
  }

  Widget _buildDashboard() {
    final institution = _institution;

    if (institution == null) {
      return const Center(
        child: Text('Institution not found.'),
      );
    }

    final isApproved =
        institution.status == 'approved';

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          institution.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text('Status: ${institution.status}'),
        const SizedBox(height: 24),
        if (!isApproved)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Your institution is waiting for approval. Programme and course management will become available after approval.',
              ),
            ),
          ),
        if (isApproved) ...[
          _DashboardAction(
            icon: Icons.school_outlined,
            title: 'Manage Programmes',
            subtitle:
                'Add and manage your academic programmes.',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _DashboardAction(
            icon: Icons.menu_book_outlined,
            title: 'Manage Courses',
            subtitle:
                'Create and organize your courses.',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _DashboardAction(
            icon: Icons.upload_file_outlined,
            title: 'Course Materials',
            subtitle:
                'Upload and publish learning materials.',
            onTap: () {},
          ),
        ],
      ],
    );
  }
}

class _DashboardAction extends StatelessWidget {
  const _DashboardAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.all(16),
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing:
            const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}