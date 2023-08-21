import 'dart:io';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/publication_services.dart';
import 'package:sistema_escolar_prepa/models/publication.dart';

import '../Services/file_services.dart';

class ScreenUpdatePublcation extends StatefulWidget {
  const ScreenUpdatePublcation({Key? key}) : super(key: key);

  @override
  _ScreenCreatePublicationState createState() =>
      _ScreenCreatePublicationState();
}

class _ScreenCreatePublicationState extends State<ScreenUpdatePublcation> {
  // key para el for
  final _formKey = GlobalKey<FormState>();
  // controller  for tile and description
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _title = '';
  String _description = '';
  List<XFile>? _file;

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

  @override
  Widget build(BuildContext context) {
// vamos a recivir el parametro en el modal router
    Publication publication =
        ModalRoute.of(context)?.settings.arguments as Publication;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar publicaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: publication.title,
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
                  width: 300,
                  child: TextFormField(
                    initialValue: publication.description,
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
                  height: 30,
                ),
                widgetOpload(file: _file),

                // ElevatedButton(
                //   onPressed: _getImage,
                //   child: const Text('Seleccionar imagen'),
                // ),
                // _image == null
                //     ? const Text('No se ha seleccionado ninguna imagen')
                //     : Image.file(_image),

                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  autofocus: true,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final publicationServices =
                          Provider.of<PublicationServices>(context,
                              listen: false);
                      final uploadFileServices =
                          Provider.of<FilesServices>(context, listen: false);
                      publication.title = _title;
                      publication.description = _description;

                      await publicationServices.updateaPublication(publication);
                      await uploadFileServices.uploadFilesPublicacion(
                          _file!, publication.id!, 'publication');

// final publicationServices =
//                           Provider.of<PublicationServices>(context,
//                               listen: false);
//                       publication.title = _title;
//                       publication.description = _description;
//                       publicationServices.updateaPublication(publication);
//                       print('Título: $_title, Descripción: $_description');
                    }
                  },
                  child: Text('Publcar'),
                ),
              ],
            ),
          ),
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
