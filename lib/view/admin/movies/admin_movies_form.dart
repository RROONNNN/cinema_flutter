import 'dart:io';

import 'package:cinema_flutter/view_model/admin/movies/bloc/admin_movies_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../model/data_models/movie.dart';
import '../../../model/data_models/genres.dart';
import '../../../model/services/movie_service.dart';
import 'package:cinema_flutter/view/trailer_preview_page.dart';

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

  void _onSubmit(String? movieId) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = Map<String, dynamic>.from(_formKey.currentState!.value);
      if (formData['releaseDate'] is DateTime) {
        formData['releaseDate'] = DateFormat(
          'yyyy-MM-dd',
        ).format(formData['releaseDate']);
      }
      final XFile? thumbnailFile = formData['thumbnail'];
      if (thumbnailFile != null) {
        formData['thumbnail'] = await MultipartFile.fromFile(
          thumbnailFile.path,
          filename: thumbnailFile.name,
        );
      }
      final XFile? trailerFile = formData['trailerUrl'];
      if (trailerFile != null) {
        formData['trailer'] = await MultipartFile.fromFile(
          trailerFile.path,
          filename: trailerFile.name,
        );
      }
      formData['genresIds'] = formData['genresIds'].join(',');
      if (mounted) {
        if (movieId == null) {
          context.read<AdminMoviesBloc>().add(
            AdminMoviesCreateMovie(movieMap: formData),
          );
        } else {
          context.read<AdminMoviesBloc>().add(
            AdminMoviesUpdateMovie(movieId: movieId, movieMap: formData),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.currentMovie != null) {
      context.read<AdminMoviesBloc>().add(
        AdminMoviesInitBeforeUpdate(movie: widget.currentMovie!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminMoviesBloc, AdminMoviesState>(
      listener: (context, state) {
        if (state.status == AdminMoviesStatus.success) {
          if (mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: BlocBuilder<AdminMoviesBloc, AdminMoviesState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(widget.isEditing ? 'Edit Movie' : 'Add Movie'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                initialValue: widget.isEditing && widget.currentMovie != null
                    ? {
                        'title': widget.currentMovie!.title,
                        'description': widget.currentMovie!.description,
                        'duration': widget.currentMovie!.duration.toString(),
                        'releaseDate': widget.currentMovie!.releaseDate,
                        'genresIds': widget.currentMovie!.genres
                            .map((e) => e.id)
                            .toList(),
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
                      validator: widget.isEditing
                          ? null
                          : FormBuilderValidators.required(),
                      builder: (FormFieldState<XFile?> field) {
                        final hasImage =
                            field.value != null ||
                            (field.value == null &&
                                widget.currentMovie != null);
                        final imageWidget = field.value != null
                            ? Image.file(
                                File(field.value!.path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : (widget.currentMovie != null &&
                                  widget.currentMovie!.thumbnail.isNotEmpty)
                            ? Image.network(
                                widget.currentMovie!.thumbnail,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : null;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Thumbnail *',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Colors.grey[100],
                                        ),
                                        child:
                                            imageWidget ??
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.image,
                                                  size: 40,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  'No Image',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                      ),
                                      if (hasImage && field.value != null)
                                        Positioned(
                                          top: 4,
                                          right: 4,
                                          child: GestureDetector(
                                            onTap: () => field.didChange(null),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black54,
                                                shape: BoxShape.circle,
                                              ),
                                              padding: const EdgeInsets.all(4),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        field.value?.name ??
                                            (widget.currentMovie?.thumbnail
                                                    .split('/')
                                                    .last ??
                                                'No image selected'),
                                        style: TextStyle(
                                          color: field.hasError
                                              ? Theme.of(
                                                  field.context,
                                                ).colorScheme.error
                                              : Colors.black87,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      ElevatedButton.icon(
                                        icon: const Icon(Icons.upload_file),
                                        label: const Text('Select Image'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blueAccent,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                        ),
                                        onPressed: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          final XFile? picked = await picker
                                              .pickImage(
                                                source: ImageSource.gallery,
                                              );
                                          if (picked != null) {
                                            field.didChange(picked);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (field.hasError)
                              Padding(
                                padding: const EdgeInsets.only(top: 8, left: 4),
                                child: Text(
                                  field.errorText ?? '',
                                  style: TextStyle(
                                    color: Theme.of(
                                      field.context,
                                    ).colorScheme.error,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
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
                      validator: widget.isEditing
                          ? null
                          : FormBuilderValidators.required(),
                      builder: (FormFieldState<XFile?> field) {
                        final hasTrailer =
                            field.value != null ||
                            (widget.isEditing &&
                                widget.currentMovie != null &&
                                widget.currentMovie!.trailerUrl.isNotEmpty);
                        final trailerName =
                            field.value?.name ??
                            (widget.currentMovie?.trailerUrl.split('/').last ??
                                'No video selected');
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Trailer *',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () async {
                                if (widget.isEditing &&
                                    widget.currentMovie != null &&
                                    widget
                                        .currentMovie!
                                        .trailerUrl
                                        .isNotEmpty) {
                                  // Route to trailer preview page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TrailerPreviewPage(
                                        trailerUrl:
                                            widget.currentMovie!.trailerUrl,
                                        useIsolate: true,
                                      ),
                                    ),
                                  );
                                } else {
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? picked = await picker.pickVideo(
                                    source: ImageSource.gallery,
                                  );
                                  if (picked != null) {
                                    field.didChange(picked);
                                  }
                                }
                              },
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 80,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.video_library,
                                        size: 40,
                                        color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          trailerName,
                                          style: TextStyle(
                                            color: field.hasError
                                                ? Theme.of(
                                                    field.context,
                                                  ).colorScheme.error
                                                : Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (hasTrailer && field.value != null)
                                        IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.redAccent,
                                          ),
                                          onPressed: () =>
                                              field.didChange(null),
                                        ),
                                      if (!widget.isEditing ||
                                          (widget.isEditing &&
                                              (widget.currentMovie == null ||
                                                  widget
                                                      .currentMovie!
                                                      .trailerUrl
                                                      .isEmpty)))
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.upload_file),
                                          label: const Text('Select Trailer'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueAccent,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 10,
                                            ),
                                          ),
                                          onPressed: () async {
                                            final ImagePicker picker =
                                                ImagePicker();
                                            final XFile? picked = await picker
                                                .pickVideo(
                                                  source: ImageSource.gallery,
                                                );
                                            if (picked != null) {
                                              field.didChange(picked);
                                            }
                                          },
                                        ),
                                      if (widget.isEditing &&
                                          widget.currentMovie != null &&
                                          widget
                                              .currentMovie!
                                              .trailerUrl
                                              .isNotEmpty)
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.play_arrow),
                                          label: const Text('Preview'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 10,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TrailerPreviewPage(
                                                      trailerUrl: widget
                                                          .currentMovie!
                                                          .trailerUrl,
                                                      useIsolate: true,
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (field.hasError)
                              Padding(
                                padding: const EdgeInsets.only(top: 8, left: 4),
                                child: Text(
                                  field.errorText ?? '',
                                  style: TextStyle(
                                    color: Theme.of(
                                      field.context,
                                    ).colorScheme.error,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
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
                      name: 'genresIds',
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
                      initialValue: widget.isEditing
                          ? widget.currentMovie!.genres
                                .map((e) => e.id)
                                .toList()
                          : state.selectedGenreIds,
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
      ),
    );
  }
}
