import 'package:cinema_flutter/model/data_models/cinema.dart';
import 'package:cinema_flutter/model/data_models/room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:cinema_flutter/view_model/admin/cinemas/bloc/admin_cinema_bloc.dart';
import 'package:cinema_flutter/view/admin/cinemas/admin_rooms_form.dart';
import 'package:cinema_flutter/view_model/admin/cinemas/bloc/admin_room_bloc.dart';

class AdminCinemasForm extends StatefulWidget {
  const AdminCinemasForm({super.key, this.cinemaId});

  final String? cinemaId;

  @override
  State<AdminCinemasForm> createState() => _AdminCinemasFormState();
}

class _AdminCinemasFormState extends State<AdminCinemasForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final bool isEditing;
  @override
  void initState() {
    isEditing = widget.cinemaId != null;
    if (isEditing) {
      context.read<AdminCinemaBloc>().add(AdminCinemaRemoveLoadedCinema());
      context.read<AdminCinemaBloc>().add(
        AdminCinemaLoadCinema(cinemaId: widget.cinemaId!),
      );
    }

    // _fillForm();

    super.initState();
  }

  Map<String, String> _toFormBuilderData(Cinema cinema) {
    return {
      'name': cinema.name,
      'address': cinema.address,
      'city': cinema.city,
      'longitude': cinema.longitude?.toString() ?? '',
      'latitude': cinema.latitude?.toString() ?? '',
    };
  }

  void _onSubmit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final cinemaMap = {
        'name': values['name'],
        'address': values['address'],
        'city': values['city'],
        'longitude':
            values['longitude'] != null &&
                values['longitude'].toString().isNotEmpty
            ? double.tryParse(values['longitude'].toString())
            : null,
        'latitude':
            values['latitude'] != null &&
                values['latitude'].toString().isNotEmpty
            ? double.tryParse(values['latitude'].toString())
            : null,
      };

      if (isEditing) {
        context.read<AdminCinemaBloc>().add(
          AdminCinemaUpdateCinema(
            cinemaId: widget.cinemaId!,
            cinemaMap: cinemaMap,
          ),
        );
      } else {
        context.read<AdminCinemaBloc>().add(
          AdminCinemaCreateCinema(cinemaMap: cinemaMap),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCinemaBloc, AdminCinemaState>(
      listener: (context, state) {
        if (state.isSaving) {
          // Optionally show a loading indicator
        } else if (state.status == AdminCinemaStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMessage ?? 'Operation completed successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        } else if (state.status == AdminCinemaStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Error saving cinema'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(isEditing ? 'Edit Cinema' : 'Add Cinema')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<AdminCinemaBloc, AdminCinemaState>(
            builder: (context, state) {
              if (state.loadedCinema == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return FormBuilder(
                key: _formKey,
                initialValue: isEditing
                    ? _toFormBuilderData(state.loadedCinema!)
                    : {},
                child: ListView(
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'address',
                      decoration: const InputDecoration(labelText: 'Address'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'city',
                      decoration: const InputDecoration(labelText: 'City'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'longitude',
                      decoration: const InputDecoration(labelText: 'Longitude'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'latitude',
                      decoration: const InputDecoration(labelText: 'Latitude'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 24),
                    if (isEditing) _buildRoomsSection(),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: state.isSaving ? null : _onSubmit,
                      child: state.isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(isEditing ? 'Update' : 'Save'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRoomsSection() {
    return BlocBuilder<AdminCinemaBloc, AdminCinemaState>(
      builder: (context, state) {
        final rooms = state.loadedCinema?.rooms ?? [];

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rooms (${rooms.length})',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: () =>
                          _showAddRoomDialog(context, state.loadedCinema),
                      icon: const Icon(Icons.add),
                      tooltip: 'Add Room',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (rooms.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'No rooms found. Add a room to get started.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: rooms.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final room = rooms[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(room.name),
                        subtitle: Text(
                          '${room.totalSeats} seats • ${room.isActive ? "Active" : "Inactive"}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              room.isActive ? Icons.check_circle : Icons.cancel,
                              color: room.isActive ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () => _navigateToRoomForm(context, room),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddRoomDialog(BuildContext context, Cinema? cinema) {
    final TextEditingController roomNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Room'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Cinema: ${cinema?.name}'),
              const SizedBox(height: 16),
              TextField(
                controller: roomNameController,
                decoration: const InputDecoration(
                  labelText: 'Room Name',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Room 1, VIP Hall, etc.',
                ),
                autofocus: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final roomName = roomNameController.text.trim();
                if (roomName.isNotEmpty) {
                  Navigator.of(context).pop();
                  _navigateToRoomForm(context, null, roomName, cinema);
                }
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToRoomForm(
    BuildContext context,
    Room? room, [
    String? roomName,
    Cinema? cinema,
  ]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => AdminRoomBloc(),
          child: AdminRoomsForm(
            room: room,
            cinemaId: room?.cinemaId ?? cinema?.id,
            roomName: roomName,
          ),
        ),
      ),
    );
  }
}
