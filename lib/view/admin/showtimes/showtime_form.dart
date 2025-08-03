import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_flutter/model/data_models/showtime.dart';
import 'package:cinema_flutter/view_model/admin/bloc/admin_showtime_bloc.dart';
import 'package:cinema_flutter/model/services/cinema_service.dart';
import 'package:intl/intl.dart';

class ShowtimeForm extends StatefulWidget {
  final Showtime? showtime;

  const ShowtimeForm({super.key, this.showtime});

  @override
  State<ShowtimeForm> createState() => _ShowtimeFormState();
}

class _ShowtimeFormState extends State<ShowtimeForm> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();

  String? _selectedMovieId;
  String? _selectedCinemaId;
  String? _selectedRoomId;
  DateTime? _selectedStartTime;
  DateTime? _selectedEndTime;
  String _selectedLanguage = 'vi';
  bool _hasSubtitle = true;
  String _selectedFormat = '2D';
  bool _isActive = true;

  List<Map<String, dynamic>> _rooms = [];
  bool _isLoadingRooms = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _initializeForm();
  }

  void _loadInitialData() {
    context.read<AdminShowtimeBloc>()
      ..add(AdminShowtimeGetAllMovies())
      ..add(AdminShowtimeGetAllCinemas());
  }

  void _initializeForm() {
    if (widget.showtime != null) {
      final showtime = widget.showtime!;
      _selectedMovieId = showtime.movieId;
      _selectedCinemaId = showtime.cinemaId;
      _selectedRoomId = showtime.roomId;
      _selectedStartTime = showtime.startTime;
      _selectedEndTime = showtime.endTime;
      _priceController.text = (showtime.price / 100).toString();
      _selectedLanguage = showtime.language;
      _hasSubtitle = showtime.subtitle;
      _selectedFormat = showtime.format;
      _isActive = showtime.isActive;

      // Load rooms for the selected cinema
      if (_selectedCinemaId != null) {
        _loadRoomsForCinema(_selectedCinemaId!);
      }
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _loadRoomsForCinema(String cinemaId) async {
    setState(() {
      _isLoadingRooms = true;
    });

    try {
      final cinemaService = CinemaService();
      final cinema = await cinemaService.getCinemaById(cinemaId);
      // For now, we'll use a placeholder. In a real app, you'd have a method to get rooms by cinema
      setState(() {
        _rooms = [
          {'id': 'room1', 'name': 'Room 1'},
          {'id': 'room2', 'name': 'Room 2'},
          {'id': 'room3', 'name': 'Room 3'},
        ];
        _isLoadingRooms = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingRooms = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load rooms: $e')));
    }
  }

  Future<void> _selectDateTime(bool isStartTime) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartTime
          ? (_selectedStartTime ?? DateTime.now())
          : (_selectedEndTime ?? (_selectedStartTime ?? DateTime.now())),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          if (isStartTime) {
            _selectedStartTime = selectedDateTime;
            // Auto-calculate end time (assuming 2 hours duration)
            _selectedEndTime = selectedDateTime.add(const Duration(hours: 2));
          } else {
            _selectedEndTime = selectedDateTime;
          }
        });
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedMovieId == null ||
          _selectedCinemaId == null ||
          _selectedRoomId == null ||
          _selectedStartTime == null ||
          _selectedEndTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all required fields'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_selectedEndTime!.isBefore(_selectedStartTime!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('End time must be after start time'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final price = (double.tryParse(_priceController.text) ?? 0) * 100;

      final showtimeMap = {
        'movieId': _selectedMovieId,
        'cinemaId': _selectedCinemaId,
        'roomId': _selectedRoomId,
        'startTime': _selectedStartTime!.toIso8601String(),
        'endTime': _selectedEndTime!.toIso8601String(),
        'price': price.toInt(),
        'language': _selectedLanguage,
        'subtitle': _hasSubtitle,
        'format': _selectedFormat,
        'isActive': _isActive,
      };

      if (widget.showtime != null) {
        // Update existing showtime
        context.read<AdminShowtimeBloc>().add(
          AdminShowtimeUpdateShowtime(
            showtimeId: widget.showtime!.id,
            showtimeMap: showtimeMap,
          ),
        );
      } else {
        // Create new showtime
        context.read<AdminShowtimeBloc>().add(
          AdminShowtimeCreateShowtime(showtimeMap: showtimeMap),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.showtime == null ? 'Create Showtime' : 'Edit Showtime',
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<AdminShowtimeBloc, AdminShowtimeState>(
        listener: (context, state) {
          if (state.status == AdminShowtimeStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'An error occurred'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state.status == AdminShowtimeStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage ?? 'Operation successful'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Movie Selection
                  _buildDropdownField(
                    label: 'Movie *',
                    value: _selectedMovieId,
                    items: state.movies.map((movie) {
                      return DropdownMenuItem<String>(
                        value: movie['id'] as String,
                        child: Text(
                          movie['name'] as String? ?? 'Unknown Movie',
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedMovieId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) return 'Please select a movie';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Cinema Selection
                  _buildDropdownField(
                    label: 'Cinema *',
                    value: _selectedCinemaId,
                    items: state.cinemas.map((cinema) {
                      return DropdownMenuItem<String>(
                        value: cinema['id'] as String,
                        child: Text(
                          cinema['name'] as String? ?? 'Unknown Cinema',
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCinemaId = value;
                        _selectedRoomId = null; // Reset room selection
                        _rooms.clear();
                      });
                      if (value != null) {
                        _loadRoomsForCinema(value);
                      }
                    },
                    validator: (value) {
                      if (value == null) return 'Please select a cinema';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Room Selection
                  _buildDropdownField(
                    label: 'Room *',
                    value: _selectedRoomId,
                    items: _isLoadingRooms
                        ? [
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Text('Loading rooms...'),
                            ),
                          ]
                        : _rooms.map((room) {
                            return DropdownMenuItem<String>(
                              value: room['id'] as String,
                              child: Text(
                                room['name'] as String? ?? 'Unknown Room',
                              ),
                            );
                          }).toList(),
                    onChanged: (value) {
                      if (!_isLoadingRooms) {
                        setState(() {
                          _selectedRoomId = value;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null) return 'Please select a room';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Start Time
                  _buildDateTimeField(
                    label: 'Start Time *',
                    value: _selectedStartTime,
                    onTap: () => _selectDateTime(true),
                    validator: (value) {
                      if (_selectedStartTime == null)
                        return 'Please select start time';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // End Time
                  _buildDateTimeField(
                    label: 'End Time *',
                    value: _selectedEndTime,
                    onTap: () => _selectDateTime(false),
                    validator: (value) {
                      if (_selectedEndTime == null)
                        return 'Please select end time';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Price
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price (USD) *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Price must be greater than 0';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Language
                  _buildDropdownField(
                    label: 'Language',
                    value: _selectedLanguage,
                    items: const [
                      DropdownMenuItem(value: 'vi', child: Text('Vietnamese')),
                      DropdownMenuItem(value: 'en', child: Text('English')),
                      DropdownMenuItem(value: 'ko', child: Text('Korean')),
                      DropdownMenuItem(value: 'cn', child: Text('Chinese')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedLanguage = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Format
                  _buildDropdownField(
                    label: 'Format',
                    value: _selectedFormat,
                    items: const [
                      DropdownMenuItem(value: '2D', child: Text('2D')),
                      DropdownMenuItem(value: '3D', child: Text('3D')),
                      DropdownMenuItem(value: 'IMAX', child: Text('IMAX')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedFormat = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Subtitle
                  SwitchListTile(
                    title: const Text('Subtitle'),
                    subtitle: const Text('Enable subtitles for this showtime'),
                    value: _hasSubtitle,
                    onChanged: (value) {
                      setState(() {
                        _hasSubtitle = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Active Status
                  SwitchListTile(
                    title: const Text('Active'),
                    subtitle: const Text('Enable this showtime'),
                    value: _isActive,
                    onChanged: (value) {
                      setState(() {
                        _isActive = value;
                      });
                    },
                  ),
                  const SizedBox(height: 32),

                  // Submit Button
                  ElevatedButton(
                    onPressed: state.isSaving ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: state.isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            widget.showtime == null
                                ? 'Create Showtime'
                                : 'Update Showtime',
                            style: const TextStyle(fontSize: 16),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildDateTimeField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.access_time),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: onTap,
        ),
      ),
      controller: TextEditingController(
        text: value != null
            ? DateFormat('MMM dd, yyyy - HH:mm').format(value)
            : '',
      ),
      validator: validator,
      onTap: onTap,
    );
  }
}
