import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import "package:camera/camera.dart";
import 'package:cross_file/cross_file.dart';
import 'package:tflite/tflite.dart';

class DeteksiPenyakitPage extends StatefulWidget {
  const DeteksiPenyakitPage({Key? key}) : super(key: key);

  @override
  _DeteksiPenyakitPageState createState() => _DeteksiPenyakitPageState();
}

class _DeteksiPenyakitPageState extends State<DeteksiPenyakitPage> {
  late CameraController _camController;
  String? pathDir;
  bool _showCamera = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    _camController = CameraController(cameras[0], ResolutionPreset.high);
    await _camController.initialize();
    setState(() {});
    await Tflite.loadModel(
        model: 'assets/model.tflite', 
        labels: 'assets/labels.txt');
  }

  Future<String> takePicture() async {
    String filePath = "";
    try {
      XFile? img = await _camController.takePicture();
      filePath = img!.path;
    } catch (e) {
      log("Error : ${e.toString()}");
    }
    return filePath;
  }

  Future<dynamic> predict(String path) async {
    var prediksi = await Tflite.runModelOnImage(
      path: path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 3,
      threshold: 0.2,
      asynch: true,
    );
    log("prediksi : $prediksi");
    return prediksi;
  }

  @override
  void dispose() {
    _camController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: _showCamera
        ? Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          1 /
                          _camController.value.aspectRatio,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CameraPreview(_camController),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (!_camController.value.isTakingPicture) {
                        pathDir = null;
                        pathDir = await takePicture();
                        log("hasil : $pathDir");
                        var prediction = await predict(pathDir!);
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return FutureBuilder(
                              future: predict(pathDir!),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    // Menyiapkan data prediksi
                                    var predictionData = snapshot.data;
                                    if (predictionData.isEmpty) {
                                      return Center(
                                        child: Text(
                                          "Tidak ada hasil prediksi.",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }
                                    String label =
                                        predictionData[0]['label'];
                                    double confidence =
                                        predictionData[0]['confidence'];

                                    return Container(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hasil Pengecekan:",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                ),
                                                // child: Icon(
                                                //   Icons.camera_alt_rounded,
                                                //   size: 40,
                                                //   color: Colors.blue,
                                                // ),
                                              ),
                                              SizedBox(width: 20),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      label,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "Confidence: ${confidence.toStringAsFixed(2)}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Colors.grey[700],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Text(
                                        "Tidak ada data prediksi.",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            );
                          },
                        );
                        setState(() {});
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Deteksi",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(77, 255, 0, 1)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _showCamera = false;
                    });
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
            ],
          )
        : Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _showCamera = true;
                });
              },
              child: Text('Masuk untuk Deteksi'),
            ),
          ),
  );
}
}