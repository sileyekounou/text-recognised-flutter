// import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:texto/message.dart';
import 'package:google_fonts/google_fonts.dart';


class MyCameraPage extends StatefulWidget {
  const MyCameraPage({super.key});

  @override
  State<MyCameraPage> createState() => _MyCameraPageState();
}

class _MyCameraPageState extends State<MyCameraPage>
    with WidgetsBindingObserver {
  bool _isPermissionGranted = false;
  late final Future<void> _future;
  CameraController? _cameraController;
  final _textRecognizer = TextRecognizer();

  @override
  void initState() {
    super.initState();
    _future = _requestCameraPermission();
  }

  // Future<void> _requestCameraPermission() async {
  //   final status = await Permission.camera.request();
  //   _isPermissionGranted = status == PermissionStatus.granted;
  // }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
    if (_isPermissionGranted) {
      _initCameraController(await availableCameras());
    }
  }

  void _startCamera() {
    if (_cameraController != null) {
      return;
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  // void _initCameraController(List<CameraDescription> cameras) async {
  //   if (_cameraController != null) {
  //     return;
  //   }

  //   CameraDescription? camera;

  //   for (var i = 0; i < cameras.length; i++) {
  //     final CameraDescription current = cameras[i];
  //     if (current.lensDirection == CameraLensDirection.back) {
  //       camera = current;
  //       break;
  //     }
  //   }

  //   if (camera != null) {
  //     _cameraSelected(camera);
  //   }
  // }

  void _initCameraController(List<CameraDescription> cameras) async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      return;
    }

    CameraDescription? camera;

    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      await _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _cameraController?.initialize();

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  // Future<void> _scanImage() async {
  //   if (_cameraController == null) return;
  //   final navigator = Navigator.of(context);

  //   try {
  //     //
  //     final pictureFile = await _cameraController!.takePicture();
  //     final file = File(pictureFile.path);
  //     final inputImage = InputImage.fromFile(file);
  //     final recognizedText = await _textRecognizer.processImage(inputImage);
  //     //

  //     await navigator.push(
  //       MaterialPageRoute(builder: (context)=> ResultScreen(text: recognizedText.text))
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Error cousin')));
  //   }
  // }
  Future<void> _scanImage() async {
  if (_cameraController == null) return;
  final navigator = Navigator.of(context);

  try {
    print('Taking picture...');
    final pictureFile = await _cameraController!.takePicture();
    print('Picture taken: ${pictureFile.path}');

    final file = File(pictureFile.path);
    final inputImage = InputImage.fromFile(file);

    print('Processing image...');
    final recognizedText = await _textRecognizer.processImage(inputImage);
    print('Text recognized: ${recognizedText.text}');

    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ResultScreen(text: recognizedText.text),
      ),
    );
  } catch (e) {
    print('Error while scanning text: $e');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Error occurred while scanning')));
  }
}


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return Stack(
            children: [
              if (_isPermissionGranted)
                FutureBuilder<List<CameraDescription>>(
                  future: availableCameras(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _initCameraController(snapshot.data!);

                      if (_cameraController != null &&
                          _cameraController!.value.isInitialized) {
                        return Center(
                          child: CameraPreview(_cameraController!),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(color: Color.fromRGBO(176, 225, 101, 1)),
                        );
                      }
                    } else {
                      return Center(
                        child: LinearProgressIndicator(color: Color.fromRGBO(176, 225, 101, 1)),
                      );
                    }
                  },
                ),
              Scaffold(
                backgroundColor:
                    _isPermissionGranted ? Color.fromRGBO(0, 0, 0, 0) : null,
                body: _isPermissionGranted
                    ? Column(
                        children: [
                          Expanded(child: Container()),
                          Container(
                            padding: EdgeInsets.only(bottom: 30.0),
                            child: Center(
                              child: ElevatedButton(
                                  onPressed: _scanImage, child: Text('Scan Text', style: GoogleFonts.lexend(textStyle : TextStyle(fontSize: 18, fontWeight: FontWeight.w500, inherit: true, color: Color.fromRGBO(176, 225, 101, 1)),)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(36, 80, 59, 1)
                                  ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(36, 80, 59, 1)
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [                                
                                Text(
                                  'Camera Denied',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lexend(
                                    textStyle: TextStyle(
                                        fontSize: 28, fontWeight: FontWeight.w500, inherit: true, color: Color.fromRGBO(176, 225, 101, 1))),
                                ),
                              ],
                            ),
                          )
                        ),
                      ),
              ),
            ],
          );
        });
  }
}
