import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img_lib;

class ObjectDetector {
  static const modelPath = 'assets/models/best.tflite';
  static const labelsPath = 'assets/models/labels.txt';

  Interpreter? _interpreter;
  List<String> _labels = [];
  bool _modelLoaded = false;

  static const int inputSize = 640;
  static const int numClasses = 7;
  static const double confidenceThreshold = 0.5;
  static const double iouThreshold = 0.5;

  ObjectDetector() {
    _initializeDetector();
  }

  Future<void> _initializeDetector() async {
    await _loadModel();
    await _loadLabels();
  }

  Future<void> _loadModel() async {
    try {
      print('Loading model from: $modelPath');
      final interpreterOptions = InterpreterOptions()..threads = 4;

      _interpreter = await Interpreter.fromAsset(
        modelPath,
        options: interpreterOptions,
      );

      final inputShape = _interpreter!.getInputTensor(0).shape;
      final outputShape = _interpreter!.getOutputTensor(0).shape;

      print('Model loaded successfully');
      print('Input shape: $inputShape');
      print('Output shape: $outputShape');

      _modelLoaded = true;
    } catch (e) {
      print('Error loading model: $e');
      _modelLoaded = false;
    }
  }

  Future<void> _loadLabels() async {
    try {
      print('Loading labels from: $labelsPath');
      final labelsData = await rootBundle.loadString(labelsPath);
      _labels = labelsData
          .split('\n')
          .where((label) => label.trim().isNotEmpty)
          .map((label) => label.trim())
          .toList();

      print('Labels loaded: $_labels');

      if (_labels.isEmpty) {
        print('Warning: No labels loaded');
        _labels = ['Unknown'];
      }
    } catch (e) {
      print('Error loading labels: $e');
      _labels = ['Unknown'];
    }
  }

  Future<List<Map<String, dynamic>>> detectFromImage(XFile file) async {
    if (!_modelLoaded) {
      print('Model not loaded');
      return [];
    }

    try {
      print('Starting detection process');

      // Read and decode image
      final imageData = await File(file.path).readAsBytes();
      final image = img_lib.decodeImage(imageData);
      if (image == null) {
        print('Failed to decode image');
        return [];
      }

      // Resize image
      final resizedImage = img_lib.copyResize(
        image,
        width: inputSize,
        height: inputSize,
      );

      // Prepare input tensor
      var input = List<double>.filled(1 * inputSize * inputSize * 3, 0.0);
      var inputIndex = 0;

      for (var y = 0; y < inputSize; y++) {
        for (var x = 0; x < inputSize; x++) {
          final pixel = resizedImage.getPixel(x, y);
          input[inputIndex++] = pixel.r / 255.0;
          input[inputIndex++] = pixel.g / 255.0;
          input[inputIndex++] = pixel.b / 255.0;
        }
      }

      // Create properly shaped input tensor
      final inputTensor = List.generate(
        1,
        (_) => List.generate(
          inputSize,
          (_) => List.generate(
            inputSize,
            (_) => List<double>.filled(3, 0.0),
          ),
        ),
      );

      // Fill input tensor
      var idx = 0;
      for (var y = 0; y < inputSize; y++) {
        for (var x = 0; x < inputSize; x++) {
          for (var c = 0; c < 3; c++) {
            inputTensor[0][y][x][c] = input[idx++];
          }
        }
      }

      // Create output tensor
      final outputTensor = List.generate(
        1,
        (_) => List.generate(
          11,
          (_) => List<double>.filled(8400, 0.0),
        ),
      );

      // Run inference
      print('Running inference...');
      _interpreter!.run(inputTensor, outputTensor);
      print('Inference complete');

      // Process output
      return _processOutput(outputTensor);
    } catch (e) {
      print('Error in detectFromImage: $e');
      return [];
    }
  }

  List<Map<String, dynamic>> _nonMaxSuppression(
      List<Map<String, dynamic>> boxes) {
    boxes.sort((a, b) => b['confidence'].compareTo(a['confidence']));
    final selected = <Map<String, dynamic>>[];

    for (var i = 0; i < boxes.length; i++) {
      var keep = true;
      for (var j = 0; j < selected.length; j++) {
        if (_calculateIoU(boxes[i]['bbox'], selected[j]['bbox']) >
            iouThreshold) {
          keep = false;
          break;
        }
      }
      if (keep) selected.add(boxes[i]);
    }
    print('Selected boxes: $selected');

    return selected;
  }

  double _calculateIoU(List<double> box1, List<double> box2) {
    final intersection = _getIntersectionArea(box1, box2);
    final union = _getArea(box1) + _getArea(box2) - intersection;
    return intersection / union;
  }

  double _getIntersectionArea(List<double> box1, List<double> box2) {
    final x1 = max(box1[0], box2[0]);
    final y1 = max(box1[1], box2[1]);
    final x2 = min(box1[2], box2[2]);
    final y2 = min(box1[3], box2[3]);
    return max(0, x2 - x1) * max(0, y2 - y1);
  }

  double _getArea(List<double> box) {
    return (box[2] - box[0]) * (box[3] - box[1]);
  }

  void dispose() {
    _interpreter?.close();
  }

  List<Map<String, dynamic>> _processOutput(List<dynamic> output) {
    try {
      final List<Map<String, dynamic>> detections = [];
      final results = output[0] as List<List<double>>;
      for (var i = 0; i < 8400; i++) {
        var maxClass = 0;
        var maxScore = 0.0;
        // Find class with maximum score
        // Start from index 4 (after x,y,w,h) and only process the actual number of classes
        for (var c = 0; c < _labels.length; c++) {
          final score = results[c + 4][i];
          if (score > maxScore) {
            maxScore = score;
            maxClass = c;
          }
        }
        if (maxScore > confidenceThreshold) {
          // Get coordinates and normalize them
          final x = results[0][i] / inputSize;
          final y = results[1][i] / inputSize;
          final w = results[2][i] / inputSize;
          final h = results[3][i] / inputSize;
          final bbox = [
            x - w / 2,
            y - h / 2,
            x + w / 2,
            y + h / 2,
          ];
          detections.add({
            'bbox': bbox,
            'class': _labels[maxClass],
            'confidence': maxScore,
          });
        }
      }
      return _nonMaxSuppression(detections);
    } catch (e) {
      print('Error in _processOutput: $e');
      return [];
    }
  }
}
