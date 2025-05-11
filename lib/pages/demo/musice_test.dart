import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({super.key});

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  late final AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isLoading = false;
  String _audioFilePath = '';

  final String _audioUrl =
      'http://m804.music.126.net/20250119022338/5903b73d39feeafeb948465f49836780/jdyyaac/obj/w5rDlsOJwrLDjj7CmsOj/28481685020/a767/00e6/3dc8/34094bb760eb1214bca2c2dae473e74d.m4a?vuutv=R3FdaJsIillVpUJKSebKjNfUdFCmIxITi7iozne29h6KEoHdwGNFI/XTtPbuUzJ1VDheduWoAOr+nW+36A4dYrbclOJlYAKwYHn8Vyk41wQ=&authSecret=000001947a911f4604e50a3084fb6e57';

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _downloadAndPlay() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 获取本地存储路径
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/audio.mp4';

      // 使用 Dio 下载音频文件
      await Dio().download(_audioUrl, filePath);

      // 下载完成，更新文件路径
      setState(() {
        _audioFilePath = filePath;
        _isLoading = false;
      });

      // 设置音频文件并播放
      await _audioPlayer.setFilePath(_audioFilePath);
      _audioPlayer.play();
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Download error: $e');
    }
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      if (_audioFilePath.isNotEmpty) {
        _audioPlayer.play();
      } else {
        _downloadAndPlay(); // 下载并播放
      }
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              const CircularProgressIndicator() // 显示加载动画
            else
              IconButton(
                iconSize: 100,
                icon: Icon(
                  _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                  color: Colors.blue,
                ),
                onPressed: _togglePlayPause,
              ),
            const SizedBox(height: 20),
            Text(
              _isPlaying ? 'Now Playing: Song 1' : 'Paused',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
