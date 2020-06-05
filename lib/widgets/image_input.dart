import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  
  Future<void> _selectImage(ImageSource source) async{
    final picker = ImagePicker();
    final imageFile = await picker.getImage(source: source, maxWidth: 600,);
    if(imageFile == null)
      return;

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await File(imageFile.path).copy('${appDir.path}/${fileName}');
    widget.onSelectImage(savedImage);
  }

  /*Future<void> _selectPicture() async{
    final picker = ImagePicker();
    final imageFile = await picker.getImage(source: ImageSource.gallery, maxWidth: 600,);
    if(imageFile == null)
      return;

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await File(imageFile.path).copy('${appDir.path}/${fileName}');
    widget.onSelectImage(savedImage);
  }

  Future<void> _takePicture() async{
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
        source: ImageSource.camera,
        maxWidth: 600,
    );

    if(imageFile == null)
      return;

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await File(imageFile.path).copy('${appDir.path}/${fileName}');
    widget.onSelectImage(savedImage);
  }*/

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
            _storedImage,
            fit: BoxFit.cover,
            width: double.infinity,
          )
              : Text('No image taken', textAlign: TextAlign.center,),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10,),
        Expanded(
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () => _selectImage(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text('Take picture'),
                  textColor: Theme.of(context).primaryColor,
                ),
                FlatButton.icon(
                  onPressed: () => _selectImage(ImageSource.gallery),
                  icon: Icon(Icons.photo),
                  label: Text('Select from gallery'),
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
        ),
      ],
    );
  }
}
