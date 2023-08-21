// The  class  to selected  the file type for publication

import 'dart:io';

import 'package:file_picker/file_picker.dart';

class SelectedFileType {
// crete method to select an image

  static Future<File?> pickFileImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    }
    return null;
  }

// crete method to select an pdf doc

  static Future<File?> pickFilePdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    }
    return null;
  }


// para archivos pdf
  // Future<FilePickerResult?> pickFilePdf() async {
  //   //  mostraar el dialog par seleccionar el archivo
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'doc'],
  //   );

  //   return result;
  // }

  // Future<File?> pickFilePdf() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //         type: FileType.

  //   );
  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     return file;
  //   }
  //   return null;
  // }


}

// method to verify the file extension type
