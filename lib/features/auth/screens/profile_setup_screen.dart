import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/institution.dart';
import '../../../data/models/programme.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/repositories/institution_repository.dart';
import '../../../data/repositories/user_profile_repository.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _institutionSearchController = TextEditingController();
  final _programmeSearchController = TextEditingController();

  final _userProfileRepository = UserProfileRepository();
  final _institutionRepository = InstitutionRepository();
  
  List<Institution> _institutions = [];
  List<Programme> _programmes = [];

  Institution? _selectedInstitution;
  Programme? _selectedProgramme;

  String _selectedLevel = '100';

  bool _isLoadingInstitutions = true;
  bool _isLoadingProgrammes = false;
  bool _isSaving = false;

  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadInstitutions();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _institutionSearchController.dispose();
    _programmeSearchController.dispose();
    super.dispose();
  }

  Future<void> _loadInstitutions() async {
    try {
      final institutions =
          await _institutionRepository.getActiveInstitutions();

      if (!mounted) return;

      setState(() {
        _institutions = institutions;
        _isLoadingInstitutions = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoadingInstitutions = false;
        _errorMessage = 'Unable to load institutions.';
      });
    }
  }

  Future<void> _selectInstitution(Institution institution) async {
    setState(() {
      _selectedInstitution = institution;
      _selectedProgramme = null;
      _programmes = [];
      _isLoadingProgrammes = true;
      _errorMessage = null;
    });

    _programmeSearchController.clear();

    try {
      final programmes =
          await _institutionRepository.getActiveProgrammes(
        institution.id,
      );

      if (!mounted) return;

      setState(() {
        _programmes = programmes;
        _isLoadingProgrammes = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoadingProgrammes = false;
        _errorMessage = 'Unable to load programmes.';
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        _errorMessage = 'No authenticated user found.';
      });
      return;
    }

    final institution = _selectedInstitution;
    final programme = _selectedProgramme;
    final level = _selectedLevel;

    if (institution == null) {
      setState(() {
        _errorMessage = 'Please select a registered institution.';
      });
      return;
    }

    if (programme == null) {
      setState(() {
        _errorMessage = 'Please select a programme.';
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      final profile = UserProfile(
        uid: user.uid,
        name: _nameController.text.trim(),
        email: user.email ?? '',
        university: institution.name,
        programme: programme.name,
        level: level,
        role: 'student',
        institutionId: institution.id,
        programmeId: programme.id,
        createdAt: DateTime.now(),
      );

      await _userProfileRepository.createProfile(profile);

      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to save profile: $e';
        });
      }
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
        title: const Text('Complete Your Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: _isLoadingInstitutions
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const Text(
                      'Tell us about yourself',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Select your institution and programme to personalize CourseMind.',
                    ),
                    const SizedBox(height: 32),

                    // FULL NAME
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Please enter your full name.';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // UNIVERSITY / INSTITUTION
                    Autocomplete<Institution>(
                      displayStringForOption: (institution) =>
                          institution.name,
                      optionsBuilder: (textEditingValue) {
                        final query =
                            textEditingValue.text.trim().toLowerCase();

                        if (query.isEmpty) {
                          return _institutions;
                        }

                        return _institutions.where(
                          (institution) =>
                              institution.name
                                  .toLowerCase()
                                  .contains(query) ||
                              institution.shortName
                                  .toLowerCase()
                                  .contains(query),
                        );
                      },
                      onSelected: _selectInstitution,
                      fieldViewBuilder: (
                        context,
                        textEditingController,
                        focusNode,
                        onFieldSubmitted,
                      ) {
                        _institutionSearchController.value =
                            textEditingController.value;

                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            labelText: 'University / Institution',
                            hintText:
                                'Start typing your university...',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.school_outlined),
                          ),
                          onChanged: (value) {
                            if (_selectedInstitution != null &&
                                value !=
                                    _selectedInstitution!.name) {
                              setState(() {
                                _selectedInstitution = null;
                                _selectedProgramme = null;
                                _programmes = [];
                              });

                              _programmeSearchController.clear();
                            }
                          },
                          validator: (_) {
                            if (_selectedInstitution == null) {
                              return 'Select a registered institution from the suggestions.';
                            }

                            return null;
                          },
                        );
                      },
                      optionsViewBuilder: (
                        context,
                        onSelected,
                        options,
                      ) {
                        final optionsList = options.toList();

                        if (optionsList.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(8),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 240,
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: optionsList.length,
                                itemBuilder: (context, index) {
                                  final institution =
                                      optionsList[index];

                                  return ListTile(
                                    leading: const Icon(
                                      Icons.account_balance_outlined,
                                    ),
                                    title: Text(institution.name),
                                    subtitle:
                                        Text(institution.shortName),
                                    onTap: () =>
                                        onSelected(institution),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // PROGRAMME
                    Autocomplete<Programme>(
                      displayStringForOption: (programme) =>
                          programme.name,
                      optionsBuilder: (textEditingValue) {
                        if (_selectedInstitution == null) {
                          return const <Programme>[];
                        }

                        final query =
                            textEditingValue.text.trim().toLowerCase();

                        if (query.isEmpty) {
                          return _programmes;
                        }

                        return _programmes.where(
                          (programme) => programme.name
                              .toLowerCase()
                              .contains(query),
                        );
                      },
                      onSelected: (programme) {
                        setState(() {
                          _selectedProgramme = programme;
                        });
                      },
                      fieldViewBuilder: (
                        context,
                        textEditingController,
                        focusNode,
                        onFieldSubmitted,
                      ) {
                        _programmeSearchController.value =
                            textEditingController.value;

                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          enabled: _selectedInstitution != null &&
                              !_isLoadingProgrammes,
                          decoration: InputDecoration(
                            labelText: 'Programme of Study',
                            hintText: _selectedInstitution == null
                                ? 'Select your institution first'
                                : 'Start typing your programme...',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(
                              Icons.menu_book_outlined,
                            ),
                            suffixIcon: _isLoadingProgrammes
                                ? const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child:
                                          CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          onChanged: (value) {
                            if (_selectedProgramme != null &&
                                value !=
                                    _selectedProgramme!.name) {
                              setState(() {
                                _selectedProgramme = null;
                              });
                            }
                          },
                          validator: (_) {
                            if (_selectedProgramme == null) {
                              return 'Select a programme from the suggestions.';
                            }

                            return null;
                          },
                        );
                      },
                      optionsViewBuilder: (
                        context,
                        onSelected,
                        options,
                      ) {
                        final optionsList = options.toList();

                        if (optionsList.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(8),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 240,
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: optionsList.length,
                                itemBuilder: (context, index) {
                                  final programme =
                                      optionsList[index];

                                  return ListTile(
                                    leading: const Icon(
                                      Icons.menu_book_outlined,
                                    ),
                                    title: Text(programme.name),
                                    onTap: () =>
                                        onSelected(programme),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // LEVEL
                    DropdownButtonFormField<String>(
                      initialValue: _selectedLevel,
                      decoration: const InputDecoration(
                        labelText: 'Level',
                        border: OutlineInputBorder(),
                        prefixIcon:
                            Icon(Icons.layers_outlined),
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
                        DropdownMenuItem(
                          value: '500',
                          child: Text('Level 500'),
                        ),
                        DropdownMenuItem(
                          value: 'Postgraduate',
                          child: Text('Postgraduate'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          _selectedLevel = value;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    if (_errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .errorContainer,
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onErrorContainer,
                          ),
                        ),
                      ),

                    FilledButton(
                      onPressed:
                          _isSaving ? null : _saveProfile,
                      style: FilledButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
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
                              'Save & Continue',
                              style:
                                  TextStyle(fontSize: 16),
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}