import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_course_player/styling/app_assets.dart';
import 'package:mini_course_player/styling/app_colors.dart';
import 'package:video_player/video_player.dart';

class CourseVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const CourseVideoPlayer({super.key, required this.videoUrl});

  @override
  State<CourseVideoPlayer> createState() => _CourseVideoPlayerState();
}

class _CourseVideoPlayerState extends State<CourseVideoPlayer> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    await _videoController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoController,
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

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController == null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: SvgPicture.asset(AppAssets.imagebrokensvg)),
      );
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Chewie(controller: _chewieController!),
    );
  }
}
