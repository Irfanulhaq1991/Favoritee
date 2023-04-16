import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Heading extends StatefulWidget {
  Heading({Key? key}) : super(key: key);
  XFile? xFile;



  @override
  State<Heading> createState() => _HeadingState();
}

class _HeadingState extends State<Heading> {
  XFile? xFile;
  final ImagePicker picker = ImagePicker();

  getImageFromGallery() async {
    xFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      widget.xFile = xFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          getImageFromGallery();
        },
        child: Center(
          child: Column(
            children: [
              Card(
                  elevation: 10,
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          xFile == null ? null : FileImage(File(xFile!.path)),
                      radius: MediaQuery.of(context).size.width * 0.10,
                      child: xFile != null
                          ? null
                          : Icon(
                              Icons.add_photo_alternate,
                              color: Colors.black,
                              size: MediaQuery.of(context).size.width * 0.10,
                            ),
                    ),
                  )),
              const Text(
                "Image",
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2.5,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(60, 0, 60.0, 0),
                child: const Divider(
                  thickness: 7,
                  color: Colors.amber,
                  height: 50.0,
                ),
              )
            ],
          ),
        ));
  }
}
