import 'dart:io';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/file_services.dart';
import 'package:sistema_escolar_prepa/Services/publication_services.dart';
import 'package:sistema_escolar_prepa/Services/story_servies.dart';
import 'package:sistema_escolar_prepa/models/publication.dart';

import 'package:file_picker/file_picker.dart';
import 'package:sistema_escolar_prepa/widgets/view_pdf.dart';

import '../models/selected_file.dart';
import '../providers/form_publication.dart';
import '../widgets/text_fileds.dart';

// ScreenCreatePublicationw

class ScreenCreateStory extends StatelessWidget {
  const ScreenCreateStory({Key? key}) : super(key: key);

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
  List<XFile>? _file;
  // List<File>? _file;

  // instance model publication
  Publication publication = Publication(title: '');
// inicializr los controladores

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

  // objecto para definiar la fecha inicial

  DateTime fecha = DateTime.now();

  // FECHA DE EXPIRACION DEL A HISTORIA
  DateTime? expiredAt;

  // controlador para el campor de texto
  final TextEditingController _textController = TextEditingController();

  String? textData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _file = [];
    textData = _textController.text;
  }

  @override
  Widget build(BuildContext context) {
    // Publication publication =
    // ModalRoute.of(context)?.settings.arguments as Publication;

    final statusForm = Provider.of<ValidateFormPublication>(context);

    final size = MediaQuery.of(context).size;
    final storyServices = Provider.of<StoryServices>(context);
    final uploadFile = Provider.of<FilesServices>(context);

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Agregar publicaciones', style: TextStyle(fontSize: 20)),
      ),
      body: Padding(
        padding: Platform.isAndroid || Platform.isIOS
            ? const EdgeInsets.symmetric(horizontal: 16)
            : const EdgeInsets.symmetric(horizontal: 30),
        child: Platform.isWindows || Platform.isMacOS
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                        'Solo estarasn disponibles en dia que ustd asigne'),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //     color: Colors.red,
                        //     height: size.height * 0.5,
                        //     width: size.width * 0.2),
                        Container(
                          // color: Colors.red,
                          height: size.height * 0.8,
                          width: size.width * 0.7,
                          child: SingleChildScrollView(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextField(
                                  decoration: InputDecorations.authDecoration(
                                      hintText: 'CONTETO DE HA HISTORIA',
                                      labelText: 'CONTETO DE HA HISTORIA'),
                                  controller: _textController,
                                  onChanged: (value) => textData = value,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                if (fileSend == null)
                                  const Text('NO HAY ARCHIVOS SELECCIONADOS')
                                else
                                  _viewFile(context),
                                Platform.isAndroid || Platform.isIOS
                                    ? SizedBox(
                                        height: double.infinity,
                                        width: double.infinity,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                // file = await pickFile();
                                                await _show(context, size);
                                              },
                                              child: file == null
                                                  ? const Text(
                                                      'SELCCIONAR ARCHIVO')
                                                  : const Text(
                                                      'CAMBIAR  ARCHIVO')),
                                        ),
                                      )
                                    : widgetOpload(file: _file),
                                const SizedBox(
                                  height: 20,
                                ),
                                Card(
                                  elevation: 2,
                                  borderOnForeground: true,
                                  shadowColor: Colors.black,
                                  surfaceTintColor: Colors.red,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          const Text('FECHA DE EXPIRACION'),
                                          expiredAt == null
                                              ? Container()
                                              : Text(expiredAt
                                                  .toString()
                                                  .substring(0, 10)),
                                          ElevatedButton(
                                              onPressed: () async {
                                                _selectDate(context);
                                              },
                                              child: const Text(
                                                  'Seleccionar Fecha')),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (expiredAt == null) {
                                            print(
                                                'no ha seleccionado la fecha');
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Error!'),
                                                  content: const Text(
                                                      'Selecciona la fecha expiracion'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            return null;
                                          }

                                          // condicio para elviar solo el texto
                                          if (textData!.isNotEmpty) {
                                            if (_file!.isEmpty) {
                                              statusForm.statusUpload = true;

                                              Map<String, dynamic> story =
                                                  await storyServices
                                                      .createStory(textData!,
                                                          expiredAt!);
                                              print(story['_id']);
                                              statusForm.statusUpload = false;
                                            } else {
                                              statusForm.statusUpload = true;
                                              Map<String, dynamic> story =
                                                  await storyServices
                                                      .createStory(textData!,
                                                          expiredAt!);
                                              print(story['_id']);

                                              await uploadFile.uploadFilesStory(
                                                  _file!,
                                                  story['_id'],
                                                  'story');
                                              print(
                                                  'subida de archicos completado');

                                              statusForm.statusUpload = false;
                                            }

                                            return null;
                                          }

                                          //enviar solo la imagen o con texto
                                          if (_file!.isEmpty
                                              //  ||
                                              //     textData!.isEmpty
                                              ) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Error!'),
                                                  content: const Text(
                                                      'Tines que agregar el texto o una imagen'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            return null;
                                          }

                                          print('agregado texto he imagen');
                                          statusForm.statusUpload = true;
                                          Map<String, dynamic> story =
                                              await storyServices.createStory(
                                                  textData!, expiredAt!);
                                          print(story['_id']);

                                          await uploadFile.uploadFilesStory(
                                              _file!, story['_id'], 'story');
                                          print(
                                              'subida de archicos completado');

                                          statusForm.statusUpload = false;

                                          // Map<String, dynamic> story =
                                          //     await storyServices.createStory(textData!);
                                          // print(story);

                                          //                             final publicationServices =
                                          //                                 Provider.of<PublicationServices>(context,
                                          //                                     listen: false);
                                          //                             final uploadFileServices =
                                          //                                 Provider.of<FilesServices>(context,
                                          //                                     listen: false);

                                          //                             if (_formKey.currentState!.validate()) {
                                          //                               _formKey.currentState!.save();

                                          //                               publication.title = _title;
                                          //                               publication.description = _description;

                                          // // isWindows
                                          //                               if (Platform.isWindows || Platform.isMacOS) {
                                          //                                 if (_file!.isEmpty) {
                                          //                                   statusForm.statusUpload = true;

                                          //                                   publicationServices.createPublication(
                                          //                                       _title, _description);
                                          //                                   print('ingresando si narchivos');
                                          //                                   print(
                                          //                                       'Título: $_title, Descripción: $_description');
                                          //                                   statusForm.statusUpload = false;

                                          //                                   return null;
                                          //                                 } else {
                                          //                                   statusForm.statusUpload = true;

                                          //                                   String idPublication =
                                          //                                       await publicationServices
                                          //                                           .createPublication(
                                          //                                               _title, _description);

                                          //                                   await uploadFileServices
                                          //                                       .uploadFilesPublicacion(
                                          //                                           _file!, idPublication, 'publication');
                                          //                                   statusForm.statusUpload = false;
                                          //                                 }
                                          //                               } else {
                                          // // isAndroid or isIos

                                          //                                 // for phones
                                          //                                 if (fileSend == null) {
                                          //                                   statusForm.statusUpload = true;

                                          //                                   await publicationServices.createPublication(
                                          //                                       _title, _description);
                                          //                                   print('ingresando si narchivos');
                                          //                                   print(
                                          //                                       'Título: $_title, Descripción: $_description');
                                          //                                   statusForm.statusUpload = false;

                                          //                                   return null;
                                          //                                 } else {
                                          //                                   statusForm.statusUpload = true;

                                          //                                   String idPublication =
                                          //                                       await publicationServices
                                          //                                           .createPublication(
                                          //                                               _title, _description);

                                          //                                   await uploadFileServices
                                          //                                       .uploadFilesPublicacion2(fileSend!,
                                          //                                           idPublication, 'publication');

                                          //                                   statusForm.statusUpload = false;
                                          //                                 }
                                          //                               }
                                          //                             }

                                          // publicationServices.allPublication();
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 5),
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
                        )
                      ],
                    ),
                  ],
                ),
                // opcion solo para moviles
              )
            : SingleChildScrollView(
                child: SizedBox(
                  height: size.height * 0.98,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      const Text(
                        'Las historias que se publiquen solo estara disponible el tiempo que sera designado',
                        style: TextStyle(fontSize: 20),
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      TextField(
                        controller: _textController,
                        autofocus: false,
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
                        height: 15,
                      ),
                      Card(
                        elevation: 2,
                        borderOnForeground: true,
                        shadowColor: Colors.black,
                        surfaceTintColor: Colors.red,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                const Text('FECHA DE EXPIRACION'),
                                expiredAt == null
                                    ? Container()
                                    : Text(
                                        expiredAt.toString().substring(0, 10)),
                                ElevatedButton(
                                    onPressed: () async {
                                      _selectDate(context);
                                    },
                                    child: const Text('Seleccionar Fecha')),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
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
                                final storyServices =
                                    Provider.of<StoryServices>(context,
                                        listen: false);
                                final uploadFile = Provider.of<FilesServices>(
                                    context,
                                    listen: false);

                                if (expiredAt == null) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Message"),
                                        content: const Text(
                                            "Tienes que selecionar la fecha de expiracion"),
                                        actions: [
                                          TextButton(
                                            child: const Text("Aceptar"),
                                            onPressed: () {
                                              // Acción a realizar cuando el usuario presiona el botón "Aceptar"
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          // TextButton(
                                          //   child: Text("Cancelar"),
                                          //   onPressed: () {
                                          //     Navigator.of(context).pop();
                                          //   },
                                          // ),
                                        ],
                                      );
                                    },
                                  );

                                  return null;
                                }

                                // el data pude servacioj en la cual se creaer vacio  se retorna el id  para la actualizacion
                                if (Platform.isWindows || Platform.isMacOS) {
                                  // PREGUNTA SI NO ES VACION SI NO HACE  LA PÉTICION HTTP
                                  if (_file!.isEmpty) {
                                    print(
                                        'tienees que agregar el contenido  o una imagen ');
                                    statusForm.statusUpload = true;

                                    Map<String, dynamic> story =
                                        await storyServices.createStory(
                                            _textController.text, expiredAt!);

                                    statusForm.statusUpload = false;

                                    return null;
                                  } else {
                                    Map<String, dynamic> story =
                                        await storyServices.createStory(
                                            _textController.text, expiredAt!);
                                    print(story['_id']);

                                    await uploadFile.uploadFilesStory(
                                        _file!, story['_id'], 'story');
                                    print('subida de archicos completado');
                                    return null;
                                  }
                                } else {
                                  // isAndroid or isIos
                                  // falta las validaciones

                                  // for phones
                                  if (fileSend == null) {
                                    statusForm.statusUpload = true;

                                    Map<String, dynamic> story =
                                        await storyServices.createStory(
                                            _textController.text, expiredAt!);
                                    print(story['_id']);
                                    print('histoaria si archivo');

                                    statusForm.statusUpload = false;
                                    return null;

                                    // showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     return AlertDialog(
                                    //       title: const Text("Message"),
                                    //       content: const Text(
                                    //           "Tiens que selecionar un archivo"),
                                    //       actions: [
                                    //         TextButton(
                                    //           child: Text("Aceptar"),
                                    //           onPressed: () {
                                    //             // Acción a realizar cuando el usuario presiona el botón "Aceptar"
                                    //             Navigator.of(context).pop();
                                    //           },
                                    //         ),
                                    //       ],
                                    //     );
                                    //   },
                                    // );
                                    // return null;

                                  } else {
                                    statusForm.statusUpload = true;

                                    Map<String, dynamic> story =
                                        await storyServices.createStory(
                                            _textController.text, expiredAt!);
                                    print(story['_id']);

                                    await uploadFile.uploadFilesStory2(
                                        fileSend, story['_id'], 'story');
                                    print('subida de archicos completado');
                                    statusForm.statusUpload = false;
                                    return null;
                                  }
                                }

                                // await storyServices.getAllStory();
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 5),
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
      ),
    );
  }

  // / / funciuon para las fechas
  _selectDate(BuildContext context) async {
    // DateTime selectedDate = DateTime.now();

    // varaible que guarda la fecha seleccionada
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: fecha,
      firstDate: DateTime(1990),
      lastDate: DateTime(2050),
      // cambaira el texto de los botones
      helpText: 'Seleccionar Fecha ',
      cancelText: 'Cancelar',
      confirmText: 'Guardar',
      // locale: const Locale('es', 'MX'),
    );

    // si para una de stas condiciones actualizamos el  datos
    if (selected != null && selected != fecha) {
      fecha = selected;
      expiredAt = selected;
      // dateTime.selectDateTime = selected;
      setState(() {});
      //  dateServices.
    }
  }

  _show(BuildContext context, Size size) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.only(right: 20),
          title: const Text(
            "Selecciona el  archivo",
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
                // ElevatedButton(
                //   child: const SizedBox(
                //       width: 200, child: Center(child: Text('PDF'))),
                //   onPressed: () async {
                //     Navigator.pop(context);
                //     // filePdf = await pickFilePdf();
                //     filePdf = await SelectedFileType.pickFilePdf();
                //     fileSend = filePdf;

                //     if (filePdf != null) {
                //       typeExtends = filePdf!.path.split('.');
                //       extend = typeExtends[typeExtends.length - 1];
                //     }

                //     setState(() {});
                //     // final path =
                //     //     filePdf!.files.first;
                //   },
                // ),
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
                width: size.width * 0.5,
                height: 200,
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
