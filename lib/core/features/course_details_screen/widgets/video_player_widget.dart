import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_course_player/core/wedgets/loding_widget.dart';
import 'package:mini_course_player/styling/app_colors.dart';
import 'package:video_player/video_player.dart';

class CourseVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final int lastPosition;
  final Function(int position)? onPositionChanged;
  final VoidCallback? onVideoError;

  const CourseVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.lastPosition,
    this.onPositionChanged,
    this.onVideoError,
  });

  @override
  State<CourseVideoPlayer> createState() => _CourseVideoPlayerState();
}

class _CourseVideoPlayerState extends State<CourseVideoPlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  Timer? _positionTimer;

  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      await _videoController!.initialize();

      if (widget.lastPosition > 0) {
        await _videoController!.seekTo(Duration(seconds: widget.lastPosition));
      }

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        allowPlaybackSpeedChanging: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primarycolor,
          handleColor: AppColors.primarycolor,
          backgroundColor: Colors.grey.shade300,
          bufferedColor: Colors.grey.shade500,
        ),
      );

      _startPositionTracking();
    } catch (e) {
      debugPrint('Video initialization error: $e');

      _hasError = true;

      widget.onVideoError?.call();
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _startPositionTracking() {
    _positionTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (_videoController != null &&
          _videoController!.value.isInitialized &&
          _videoController!.value.isPlaying) {
        final position = _videoController!.value.position.inSeconds;

        widget.onPositionChanged?.call(position);
      }
    });
  }

  @override
  void dispose() {
    _positionTimer?.cancel();

    _chewieController?.dispose();
    _videoController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.grey.shade100,
          child: const Center(
            child: Text(
              'Unable to load video',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
    }

    if (_chewieController == null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: LodingWidget(width: 25.w, height: 25.h),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Chewie(controller: _chewieController!),
    );
  }
}
