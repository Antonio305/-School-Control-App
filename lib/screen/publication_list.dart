import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:sistema_escolar_prepa/Services/file_services.dart';
import 'package:sistema_escolar_prepa/Services/publication_services.dart';
import 'package:sistema_escolar_prepa/models/publication.dart';

class ScreenListPublication extends StatefulWidget {
  const ScreenListPublication({Key? key}) : super(key: key);

  @override
  State<ScreenListPublication> createState() => _ScreenListPublicationState();
}

class _ScreenListPublicationState extends State<ScreenListPublication> {
  List<Publication> publication = [];

  @override
  void initState() {
    // TODO: implement initState
    publication = [];
  }

  List<String> links = [
    'https://www.mundogatos.com/Uploads/mundogatos.com/ImagenesGrandes/fotos-de-gatitos-7.jpg',
    'https://i.pinimg.com/originals/f0/50/45/f05045dac9cb83f7665e8634581f5151.jpg',
    'https://i.pinimg.com/originals/f0/50/45/f05045dac9cb83f7665e8634581f5151.jpg',
    'https://i.pinimg.com/originals/f0/50/45/f05045dac9cb83f7665e8634581f5151.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final publicationServices = Provider.of<PublicationServices>(context);
    //  publicationServices.
    publication = publicationServices.publication;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: const Text('Lista de publicacon')),
        body: Padding(
          padding: Platform.isAndroid || Platform.isIOS
              ? const EdgeInsets.symmetric(horizontal: 0, vertical: 0)
            : const EdgeInsets.symmetric(horizontal: 50),
          child: publication.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Wrap(
                    children: List.generate(publication.length, (index) {
                      return CardPublication(
                          publication: publication, size: size, links: links, index: index,);
                    }),
                  ),
                ),
        ));
  }
}

class CardPublication extends StatelessWidget {
  const CardPublication(
      {Key? key,
      required this.publication,
      required this.size,
      required this.links,
      required this.index})
      : super(key: key);

  final List<Publication> publication;
  final Size size;
  final List<String> links;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'update_publication',
            arguments: publication[index]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:3),
        child: Card(
          semanticContainer: true,
          margin: const EdgeInsets.all(0),
          // color: Colors.red,
          child: SizedBox(
            width: Platform.isAndroid || Platform.isIOS ? size.height : 280,
            // height: 200,
            // color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.person, size: 35),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: Platform.isAndroid || Platform.isIOS
                        ? size.width * 0.78
                        : 220,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(publication[index].author!.name +
                            " " +
                            publication[index].author!.lastName +
                            " " +
                            publication[index].author!.secondName),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(publication[index].title),
                        SizedBox(
                          // width: 220,
                          width: Platform.isAndroid || Platform.isIOS
                              ? size.width * 0.78
                              : 220,

                          height:
                              publication[index].description == null ? 310 : 300,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                links.first,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          // ListView(
                          //   scrollDirection: Axis.vertical,
                          //   children: List.generate(links.length,
                          //       (index) {
                          //     return Padding(
                          //       padding: const EdgeInsets.all(3.0),
                          //       child: Image.network(links[index]),
                          //     );
                          //   }),
                          // ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        publication[index].description == null
                            ? const SizedBox()
                            : Text(
                                publication[index].description!,
                                overflow: TextOverflow.visible,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
