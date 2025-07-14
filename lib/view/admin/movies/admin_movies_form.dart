import 'dart:io';

import 'package:cinema_flutter/view_model/admin/movies/bloc/admin_movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import '../../../model/data_models/movie.dart';
import '../../../model/data_models/genres.dart';
import '../../../model/services/movie_service.dart';

class AdminMoviesForm extends StatefulWidget {
  final bool isEditing;
  final Movie? currentMovie;
  const AdminMoviesForm({super.key, this.isEditing = false, this.currentMovie})
    : assert(
        !isEditing || currentMovie != null,
        'currentMovie must not be null when isEditing is true',
      );

  @override
  State<AdminMoviesForm> createState() => _AdminMoviesFormState();
}

class _AdminMoviesFormState extends State<AdminMoviesForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _onSubmit(String? movieId) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;
      if (formData != null && movieId == null) {
        context.read<AdminMoviesBloc>().add(
          AdminMoviesCreateMovie(movieMap: formData),
        );
      } else if (formData != null && movieId != null) {
        context.read<AdminMoviesBloc>().add(
          AdminMoviesUpdateMovie(movieId: movieId, movieMap: formData),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminMoviesBloc, AdminMoviesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.isEditing ? 'Edit Movie' : 'Add Movie'),

            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _formKey,
              initialValue: widget.isEditing && widget.currentMovie != null
                  ? {
                      'title': widget.currentMovie!.title,
                      'description': widget.currentMovie!.description,
                      'duration': widget.currentMovie!.duration,
                      'releaseDate': widget.currentMovie!.releaseDate,
                      'genres': widget.currentMovie!.genres,
                    }
                  : {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title Field
                  FormBuilderTextField(
                    name: 'title',
                    decoration: const InputDecoration(
                      labelText: 'Title *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.movie),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(1),
                    ]),
                  ),
                  const SizedBox(height: 16),

                  // Description Field
                  FormBuilderTextField(
                    name: 'description',
                    decoration: const InputDecoration(
                      labelText: 'Description *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(10),
                    ]),
                    maxLines: 4,
                    minLines: 3,
                  ),
                  const SizedBox(height: 16),

                  // Duration Field
                  FormBuilderTextField(
                    name: 'duration',
                    decoration: const InputDecoration(
                      labelText: 'Duration (minutes) *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.timer),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.min(1),
                    ]),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),

                  // Release Date Field
                  FormBuilderDateTimePicker(
                    name: 'releaseDate',
                    decoration: const InputDecoration(
                      labelText: 'Release Date *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: FormBuilderValidators.required(),
                    inputType: InputType.date,
                    format: DateFormat('yyyy-MM-dd'),
                  ),
                  const SizedBox(height: 16),
                  // Thumbnail Picker Field
                  FormBuilderField<XFile?>(
                    name: 'thumbnail',
                    validator: FormBuilderValidators.required(),
                    builder: (FormFieldState<XFile?> field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Thumbnail *',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.image),
                            ),
                            child: Row(
                              children: [
                                if (field.value != null)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Image.file(
                                      File(field.value!.path),
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                Expanded(
                                  child: Text(
                                    field.value?.name ?? 'No image selected',
                                    style: TextStyle(
                                      color: field.hasError
                                          ? Theme.of(
                                              field.context,
                                            ).colorScheme.error
                                          : null,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.upload_file),
                                  onPressed: () async {
                                    final ImagePicker picker = ImagePicker();
                                    final XFile? picked = await picker
                                        .pickImage(source: ImageSource.gallery);
                                    if (picked != null) {
                                      field.didChange(picked);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          if (field.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 12),
                              child: Text(
                                field.errorText ?? '',
                                style: TextStyle(
                                  color: Theme.of(
                                    field.context,
                                  ).colorScheme.error,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  // Trailer Picker Field
                  FormBuilderField<XFile?>(
                    name: 'trailerUrl',
                    validator: FormBuilderValidators.required(),
                    builder: (FormFieldState<XFile?> field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Trailer *',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.video_library),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    field.value?.name ?? 'No video selected',
                                    style: TextStyle(
                                      color: field.hasError
                                          ? Theme.of(
                                              field.context,
                                            ).colorScheme.error
                                          : null,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.upload_file),
                                  onPressed: () async {
                                    final ImagePicker picker = ImagePicker();
                                    final XFile? picked = await picker
                                        .pickVideo(source: ImageSource.gallery);
                                    if (picked != null) {
                                      field.didChange(picked);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          if (field.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 12),
                              child: Text(
                                field.errorText ?? '',
                                style: TextStyle(
                                  color: Theme.of(
                                    field.context,
                                  ).colorScheme.error,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Genres Selection
                  FormBuilderCheckboxGroup<String>(
                    name: 'genres',
                    decoration: const InputDecoration(
                      labelText: 'Genres *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category),
                    ),
                    options: state.availableGenres
                        .map(
                          (genre) => FormBuilderFieldOption(
                            value: genre.id,
                            child: Text(genre.name),
                          ),
                        )
                        .toList(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(
                        1,
                        errorText: 'Please select at least one genre',
                      ),
                    ]),
                    initialValue: state.selectedGenreIds,
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: state.isLoading
                              ? null
                              : () => _onSubmit(widget.currentMovie?.id),
                          icon: state.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(
                                  widget.isEditing ? Icons.update : Icons.add,
                                ),
                          label: Text(
                            state.isLoading
                                ? 'Processing...'
                                : (widget.isEditing
                                      ? 'Update Movie'
                                      : 'Create Movie'),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      if (widget.isEditing) ...[
                        const SizedBox(width: 16),
                        state.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: state.isLoading
                                      ? null
                                      : () => _onSubmit(null),
                                  icon: const Icon(Icons.add),
                                  label: const Text('New Movie'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
