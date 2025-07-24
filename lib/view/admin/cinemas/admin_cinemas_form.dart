import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:cinema_flutter/view_model/admin/cinemas/bloc/admin_cinema_bloc.dart';

class AdminCinemasForm extends StatefulWidget {
  const AdminCinemasForm({super.key});

  @override
  State<AdminCinemasForm> createState() => _AdminCinemasFormState();
}

class _AdminCinemasFormState extends State<AdminCinemasForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _onSubmit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      context.read<AdminCinemaBloc>().add(
        AdminCinemaCreateCinema(
          cinemaMap: {
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
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCinemaBloc, AdminCinemaState>(
      listener: (context, state) {
        if (state.isSaving) {
          // Optionally show a loading indicator
        } else if (state.status == AdminCinemaStatus.loaded) {
          Navigator.of(context).pop();
        } else if (state.status == AdminCinemaStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Error saving cinema'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Cinema')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
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
                BlocBuilder<AdminCinemaBloc, AdminCinemaState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.isSaving ? null : _onSubmit,
                      child: state.isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Save'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
