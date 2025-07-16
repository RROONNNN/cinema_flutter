import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';

class TrailerPreviewPage extends StatefulWidget {
  final String trailerUrl;
  final bool useIsolate;
  const TrailerPreviewPage({
    super.key,
    required this.trailerUrl,
    this.useIsolate = false,
  });

  @override
  State<TrailerPreviewPage> createState() => _TrailerPreviewPageState();
}

class _TrailerPreviewPageState extends State<TrailerPreviewPage> {
  VideoPlayerController? _controller;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.useIsolate) {
      _loadVideoInIsolate(widget.trailerUrl);
    } else {
      _initController(widget.trailerUrl);
    }
  }

  Future<void> _initController(String url) async {
    try {
      _controller = url.startsWith('http')
          ? VideoPlayerController.networkUrl(Uri.parse(url))
          : VideoPlayerController.file(File(url));
      await _controller!.initialize();
      setState(() {
        _loading = false;
      });
      _controller!.play();
    } catch (e) {
      setState(() {
        _error = 'Failed to load video: $e';
        _loading = false;
      });
    }
  }

  static Future<String> _isolateLoader(String url) async {
    // Simulate heavy file loading, e.g., reading from disk/network
    await Future.delayed(const Duration(milliseconds: 500));
    return url;
  }

  Future<void> _loadVideoInIsolate(String url) async {
    setState(() {
      _loading = true;
    });
    try {
      final loadedUrl = await compute(_isolateLoader, url);
      await _initController(loadedUrl);
    } catch (e) {
      setState(() {
        _error = 'Failed to load video in isolate: $e';
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trailer Preview')),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : _error != null
            ? Text(_error!, style: const TextStyle(color: Colors.red))
            : _controller != null && _controller!.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              )
            : const Text('No video available'),
      ),
      floatingActionButton:
          _controller != null && _controller!.value.isInitialized
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller!.value.isPlaying
                      ? _controller!.pause()
                      : _controller!.play();
                });
              },
              child: Icon(
                _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )
          : null,
    );
  }
}
