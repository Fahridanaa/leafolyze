import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/services/object_detector.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ObjectDetector _objectDetector = ObjectDetector();
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool _isCameraInitialized = false;
  int _selectedCameraIndex = 0;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        _initializeCamera();
      }
    } else if (status.isGranted) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      _controller = CameraController(
          cameras![_selectedCameraIndex], ResolutionPreset.high,
          enableAudio: false,
          imageFormatGroup: Platform.isAndroid
              ? ImageFormatGroup.nv21
              : ImageFormatGroup.bgra8888);
      try {
        await _controller!.initialize();
        if (Platform.isAndroid) {
          await _controller!.lockCaptureOrientation();
          await _controller!.setExposureMode(ExposureMode.auto);
          await _controller!.setFocusMode(FocusMode.auto);
        }
        setState(() {
          _isCameraInitialized = true;
        });
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camera initialization error: ${e.toString()}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _flipCamera() async {
    if (cameras != null && cameras!.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras!.length;
      await _initializeCamera();
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _processImage(image);
    }
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized ||
        _controller!.value.isTakingPicture) {
      return;
    }

    try {
      XFile picture = await _controller!.takePicture();
      _processImage(picture);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error taking picture: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _processImage(XFile image) async {
    try {
      final detections = await _objectDetector.detectFromImage(image);

      if (detections.isEmpty) {
        if (!mounted) return;
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('No Disease Detected'),
            content: const Text(
                'No plant diseases were detected in this image. Please try again with a clearer image.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Disease Detected'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Detected diseases:'),
              const SizedBox(height: 8),
              ...detections.map((detection) {
                final disease = detection['class'] as String;
                final confidence = (detection['confidence'] as double) * 100;
                return Text('• $disease (${confidence.toStringAsFixed(1)}%)');
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error processing image: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _toggleFlash() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    try {
      if (_controller!.value.flashMode == FlashMode.off) {
        await _controller!.setFlashMode(FlashMode.torch);
        setState(() {
          _isFlashOn = true;
        });
      } else {
        await _controller!.setFlashMode(FlashMode.off);
        setState(() {
          _isFlashOn = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to toggle flash'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  int _mapDiseaseToId(String disease) {
    final Map<String, int> diseaseIds = {
      'Bacterial Spot': 1,
      'Early_Blight': 2,
      'Healthy': 3,
      'Late_blight': 4,
      'Leaf Mold': 5,
      'Target_Spot': 6,
      'black spot': 7,
    };
    return diseaseIds[disease] ?? 3; // Default to 3 if not found
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          !_isCameraInitialized
              ? Center(child: CircularProgressIndicator())
              : CameraPreview(_controller!),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => context.go('/home'),
                  ),
                  IconButton(
                    icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.black),
                    onPressed: _toggleFlash,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_library,
                        color: Colors.black, size: 32),
                    onPressed: _pickImageFromGallery,
                  ),
                  GestureDetector(
                    onTap: _takePicture,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.camera, color: Colors.black, size: 40),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.flip_camera_android,
                        color: Colors.black, size: 32),
                    onPressed: _flipCamera,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
