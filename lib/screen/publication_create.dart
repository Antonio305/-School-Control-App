import 'dart:io';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/file_services.dart';
import 'package:sistema_escolar_prepa/Services/publication_services.dart';
import 'package:sistema_escolar_prepa/models/publication.dart';

import 'package:file_picker/file_picker.dart';
import 'package:sistema_escolar_prepa/widgets/view_pdf.dart';

import '../models/selected_file.dart';
import '../providers/form_publication.dart';

// ScreenCreatePublicationw

class ScreenCreatePublication extends StatelessWidget {
  const ScreenCreatePublication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ValidateFormPublication(),
        child: const BuildFormPublication());
  }
}

class BuildFormPublication extends StatefulWidget {
  const BuildFormPublication({Key? key}) : super(key: key);

  @override
  _ScreenCreatePublicationState createState() =>
      _ScreenCreatePublicationState();
}

class _ScreenCreatePublicationState extends State<BuildFormPublication> {
  // key para el for
  final _formKey = GlobalKey<FormState>();
  // controller  for tile and description
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _title = '';
  String _description = '';
  List<XFile>? _file;
  // List<File>? _file;

  // instance model publication
  Publication publication = Publication(title: '');
// inicializr los controladores
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title = _titleController.text;
    _description = _descriptionController.text;
    _file = [];
  }

  // Declarte a file object named file tyo repesent a file
  File? file;
  // Declare a File  object named  'file' to represent an image file,
  File? fileImage;
  // Declare a File object named 'FiledPdf to present a PDF FILE.
  File? filePdf;
// Declare a File object named 'fileSend' to represent a file to be sent.
  File? fileSend;
  // Declare a list named 'typeExtends' to store the file extension allowed
  // para almacenar la expresion del archivo, ya que se hace la destructuracion con la propiedad slice
  List typeExtends = [];

  /// save  type extension
  String extend = '';

  @override
  Widget build(BuildContext context) {
    // el argumento puede ser opcinal
    // Publication publication =
    // ModalRoute.of(context)?.settings.arguments as Publication;

    final statusForm = Provider.of<ValidateFormPublication>(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Agregar publicaciones', style: TextStyle(fontSize: 20)),
      ),
      body: Padding(
        padding: Platform.isAndroid || Platform.isIOS
            ? const EdgeInsets.symmetric(horizontal: 16)
            : const EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: Platform.isAndroid || Platform.isIOS ? size.width : 300,
                child: TextFormField(
                  // initialValue: publication.title,
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa un título';
                    }
                    return null;
                  },
                  onSaved: (value) => _title = value!,
                ),
              ),
              SizedBox(
                width: Platform.isAndroid || Platform.isIOS ? size.width : 300,
                child: TextFormField(
                  // initialValue: publication.description,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa una descripción';
                    }
                    return null;
                  },
                  onSaved: (value) => _description = value!,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              if (fileSend == null)
                const Text('NO HAY ARCHIVOS SELECCIONADOS')
              else
                _viewFile(context),
              Platform.isAndroid || Platform.isIOS
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: () async {
                            // file = await pickFile();
                            await _show(context, size);
                          },
                          child: file == null
                              ? const Text('SELCCIONAR ARCHIVO')
                              : const Text('CAMBIAR  ARCHIVO')),
                    )
                  : widgetOpload(file: _file),
              const SizedBox(
                height: 20,
              ),
              statusForm.statusUpload == false
                  ? ElevatedButton(
                      autofocus: true,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        final publicationServices =
                            Provider.of<PublicationServices>(context,
                                listen: false);
                        final uploadFileServices =
                            Provider.of<FilesServices>(context, listen: false);

                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          publication.title = _title;
                          publication.description = _description;

// isWindows  
                          if (Platform.isWindows || Platform.isMacOS) {
                            if (_file!.isEmpty) {
                              statusForm.statusUpload = true;

                              publicationServices.createPublication(
                                  _title, _description);
                              print('ingresando si narchivos');
                              print(
                                  'Título: $_title, Descripción: $_description');
                              statusForm.statusUpload = false;

                              return null;
                            } else {

                              statusForm.statusUpload = true;

                              String idPublication = await publicationServices
                                  .createPublication(_title, _description);

                              await uploadFileServices.uploadFilesPublicacion(
                                  _file!, idPublication, 'publication');
                              statusForm.statusUpload = false;
                            }
                          } else {
// isAndroid or isIos

                            // for phones
                            if (fileSend == null) {
                              statusForm.statusUpload = true;

                              await publicationServices.createPublication(
                                  _title, _description);
                              print('ingresando si narchivos');
                              print(
                                  'Título: $_title, Descripción: $_description');

                              statusForm.statusUpload = false;

                              return null;
                            } else {

                            statusForm.statusUpload = true;

                            String idPublication = await publicationServices
                                .createPublication(_title, _description);

                            await uploadFileServices.uploadFilesPublicacion2(
                                fileSend!, idPublication, 'publication');

                            statusForm.statusUpload = false;
                            return null;
                            }
                          }
                        }

                        // publicationServices.allPublication();
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                        child: Text('PUBLICAR'),
                      ),
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  _show(BuildContext context, Size size) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.only(right: 20),
          title: const Text(
            "Selecciona el tipo de archivo",
            style: TextStyle(fontSize: 16),
          ),
          content: SizedBox(
            height: size.height / 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const SizedBox(
                      width: 200, child: Center(child: Text('Imágenes'))),
                  onPressed: () async {
                    Navigator.pop(context);

                    fileImage = await SelectedFileType.pickFileImage();
                    // await pickFileImage();
                    fileSend = fileImage;

                    if (fileImage != null) {
                      typeExtends = fileImage!.path.split('.');
                      extend = typeExtends[typeExtends.length - 1];
                    }

                    setState(() {});
                  },
                ),
                ElevatedButton(
                  child: const SizedBox(
                      width: 200, child: Center(child: Text('PDF'))),
                  onPressed: () async {
                    Navigator.pop(context);
                    // filePdf = await pickFilePdf();
                    filePdf = await SelectedFileType.pickFilePdf();
                    fileSend = filePdf;

                    if (filePdf != null) {
                      typeExtends = filePdf!.path.split('.');
                      extend = typeExtends[typeExtends.length - 1];
                    }

                    setState(() {});
                    // final path =
                    //     filePdf!.files.first;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _viewFile(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: extend == "pdf"
          ? GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'show_pdf', arguments: filePdf);
              },
              child: const Icon(
                Icons.picture_as_pdf_rounded,
                size: 100,
              ),
            )
          : GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'view_image',
                    arguments: fileImage);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(File(fileImage!.path), fit: BoxFit.cover),
              ),
            ),
    );
  }
}

class BuildFiles extends StatefulWidget {
  final File filePdf;
  final File fileImage;
  final String extend;

  const BuildFiles(
      {Key? key,
      required this.filePdf,
      required this.fileImage,
      required this.extend})
      : super(key: key);

  @override
  State<BuildFiles> createState() => _BuildFilesState();
}

class _BuildFilesState extends State<BuildFiles> {
  @override
  Widget build(BuildContext context) {
    // final typeExtends = file!.path.split('.');
    // final extend = typeExtends[typeExtends.length - 1];
    // final fis = files.path;
    // onTap: () {
    //   if (widget.extend == "pdf") {
    //     Navigator.pushNamed(context, 'show_pdf', arguments: widget.file!);
    //   } else {
    //     Navigator.pushNamed(context, 'view_image', arguments: widget.file!);
    //   }
    // },

    return _view_file(context);
  }

  Widget _view_file(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: widget.extend == "pdf"
          ? GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'show_pdf',
                    arguments: widget.filePdf);
              },
              child: const Icon(
                Icons.picture_as_pdf_rounded,
                size: 100,
              ),
            )
          : GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'view_image',
                    arguments: widget.fileImage);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    Image.file(File(widget.fileImage!.path), fit: BoxFit.cover),
              ),
            ),
    );
  }
}

// ignore: camel_case_types
class widgetOpload extends StatefulWidget {
  final List<XFile>? file;

  const widgetOpload({Key? key, this.file}) : super(key: key);

  @override
  State<widgetOpload> createState() => _widgetOploadState();
}

class _widgetOploadState extends State<widgetOpload> {
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        DropTarget(
          onDragDone: (details) async {
            widget.file!.addAll(details.files);
            print('nombre del archivo' + details.files[0].name);

            // final createTask =
            //     Provider.of<TaskServices>(context, listen: false);

            // await createTask.fileUpload(details.files.first.name);
            // await createTask.uploadImage(details.files[0].path);
//
          },
          onDragEntered: (details) {
            setState(() {
              isDragging = true;
            });
          },
          onDragExited: (details) => setState(() => isDragging = false),

          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDragging == false ? Colors.red : Colors.white,
                ),
                // width: 300,
                height: 250,
                child: Center(
                  child: isDragging == false
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('ARRARTRE EL ARCHIVO ACA'),
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.filter,
                              size: 60,
                            )
                          ],
                        )
                      : const Text('AGREGANDO ARCHIVO....'),
                ),
              ),
            ],
          ),

          // para mostrar los archivod que se van agregando
        ),
        buildFiles()
      ],
    );
  }

//para mostarr todos los datos
  Widget buildFiles() => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          // children: file.map((e) => buildFile(e.path)).toList(),
          children: List.generate(
              widget.file!.length,
              (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        buildFile(widget.file![index]),
                        Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  setState(() {
                                    widget.file!.remove(widget.file![index]);
                                  });
                                },
                                icon: const Icon(Icons.delete))),
                      ],
                    ),
                  )),
        ),
      );

  //  widget para mostar  cada una de las imagens

  Widget buildFile(XFile url) {
    final typeExtends = url.path.split('.');
    final extend = typeExtends[typeExtends.length - 1];

    print('Typo de extension de la imagen' + extend);

    return Card(
      color: Colors.red,
      child: SizedBox(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        // color: Colors.red,
        // ),
        width: 240,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              extend == "pdf"
                  ? const Icon(Icons.picture_as_pdf)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(File(url.path),
                          width: 100, height: 100, fit: BoxFit.cover),
                    ),
              const SizedBox(
                height: 10,
              ),
              Text(url.name),
            ],
            // : [
            //     Image.file(File(url.path),
            //         width: 200, height: 200, fit: BoxFit.cover),
            //     Text(url.name)
            //   ],
          ),
        ),
      ),
    );
  }
}
