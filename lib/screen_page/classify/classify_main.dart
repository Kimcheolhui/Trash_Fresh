// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class ClassifyTrash extends StatefulWidget {
  const ClassifyTrash({Key? key}) : super(key: key);
  @override
  ClassifyTrashState createState() => ClassifyTrashState();
}

class ClassifyTrashState extends State<ClassifyTrash> {
  // File? _image;
  // final picker = ImagePicker();
  // List? _outputs;

  // @override
  // void initState() {
  //   super.initState();
  //   loadModel().then((value) {
  //     setState(() {});
  //   });
  // }

  // loadModel() async {
  //   await Tflite.loadModel(
  //     model: "assets/garbage_classification.tflite",
  //     labels: "assets/label.txt",
  //   ).then((value) {
  //     setState(() {
  //       //loading = false;
  //     });
  //   });
  // }

  // Future getImage(ImageSource imageSource) async {
  //   final image = await picker.pickImage(source: imageSource);

  //   setState(() {
  //     _image = File(image!.path);
  //   });
  //   await classifyImage(File(image!.path));
  // }

/*  Uint8List imageToByteListFloat32(
    img.Image image, int inputSize, double mean, double std) {
  var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  var buffer = Float32List.view(convertedBytes.buffer);
  int pixelIndex = 0;
  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      var pixel = image.getPixel(j, i);
      buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
      buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
      buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
    }
  }
  return convertedBytes.buffer.asUint8List();
}
*/
  // Future classifyImage(File image) async {
  //   var output = await Tflite.runModelOnImage(
  //     path: image.path,
  //     imageMean: 0,
  //     imageStd: 255.0,
  //     numResults: 9, // defaults to 5
  //     threshold: 0.3, // defaults to 0.1
  //   );
  //   setState(() {
  //     _outputs = output;
  //   });
  // }

  // Widget showImage() {
  //   return Container(
  //       color: const Color(0xffd0cece),
  //       margin: EdgeInsets.only(left: 95, right: 95),
  //       width: MediaQuery.of(context).size.width,
  //       height: MediaQuery.of(context).size.width,
  //       child: Center(
  //           child: _image == null
  //               ? Text('No image selected.')
  //               : Image.file(File(_image!.path))));
  // }

  // recycleDialog() {
  //   _outputs != null
  //       ? showDialog(
  //           context: context,
  //           barrierDismissible:
  //               false, // barrierDismissible - Dialog??? ????????? ?????? ?????? ?????? x
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               // RoundedRectangleBorder - Dialog ?????? ????????? ????????? ??????
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(10.0)),
  //               content: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: <Widget>[
  //                   Text(
  //                     _outputs![0]['label'].toString().toUpperCase(),
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 15.0,
  //                       background: Paint()..color = Colors.white,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               actions: <Widget>[
  //                 Center(
  //                   child: new TextButton(
  //                     child: new Text("Ok"),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                 )
  //               ],
  //             );
  //           })
  //       : showDialog(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               content: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: <Widget>[
  //                   Text(
  //                     "???????????? ????????? ????????? ????????? ?????????.",
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 15.0,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               actions: <Widget>[
  //                 Center(
  //                   child: new TextButton(
  //                     child: new Text("Ok"),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                 )
  //               ],
  //             );
  //           });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff4f3f9),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('????????? ??????'),
            ],
          ),
        )
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       'Classify',
        //       style: TextStyle(fontSize: 25, color: const Color(0xff1ea271)),
        //     ),
        //     SizedBox(height: 25.0),
        //     showImage(),
        //     SizedBox(
        //       height: 50.0,
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: <Widget>[
        //         // ????????? ?????? ??????
        //         FloatingActionButton(
        //           child: Icon(Icons.add_a_photo),
        //           tooltip: 'pick Iamge',
        //           onPressed: () async {
        //             await getImage(ImageSource.camera);
        //             recycleDialog();
        //           },
        //         ),

        //         // ??????????????? ???????????? ???????????? ??????
        //         FloatingActionButton(
        //           child: Icon(Icons.wallpaper),
        //           tooltip: 'pick Iamge',
        //           onPressed: () async {
        //             await getImage(ImageSource.gallery);
        //             recycleDialog();
        //           },
        //         ),
        //       ],
        //     )
        //   ],
        // ),
        );
  }

  // @override
  // void dispose() {
  //   Tflite.close();
  //   super.dispose();
  // }
}
