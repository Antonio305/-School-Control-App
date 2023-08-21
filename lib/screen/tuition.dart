import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/tuition_services.dart';
import 'package:sistema_escolar_prepa/models/tuition.dart';
import 'package:sistema_escolar_prepa/widgets/text_fileds.dart';

class ScreenTuition extends StatefulWidget {
  const ScreenTuition({Key? key}) : super(key: key);

  @override
  State<ScreenTuition> createState() => _ScreenTuitionState();
}

class _ScreenTuitionState extends State<ScreenTuition> {
  // variblae para guargar la matricula

  String tuition = '';
  TextEditingController textTuition = TextEditingController();
  // para la validacion del campo del Formulario
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Tuitions> tuitions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tuition = textTuition.text;
    onLoading();
  }

  @override
  Widget build(BuildContext context) {
    final tServices = Provider.of<TuitionServices>(context);
    tuitions = tServices.tuitions;
    print(tuitions);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matricula'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                width: 600,
                // width: size.width,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(children: [
                      Flexible(
                        child: TextField(
                          decoration: InputDecorations.authDecoration(
                              hintText: 'Matricula',
                              labelText:
                                  'INGRESA LA MATRICULA QUE DESEA BUSCAR'),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      TextButton(onPressed: () {}, child: const Text('BUSCAR'))
                    ]),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.7,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.4,
                      // color: Colors.red,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('LISTA DE MATRICULAS'),
                            Flexible(
                                child: ListView.builder(
                              itemCount: tuitions.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(tuitions[index].tuition),
                                  leading: CircleAvatar(
                                      child: Text(index.toString())),
                                  onTap: () {},
                                );
                              },
                            ))
                          ]),
                    ),
                    Container(
                      // color: Colors.blue,
                      width: size.width * 0.4,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              decoration: InputDecorations.authDecoration(
                                  hintText: 'Matricula',
                                  labelText: 'INGRESA LA MATRICULA'),
                              onChanged: (value) {
                                tuition = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingresa la matricula';
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate())
                                // return null;
                                {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      final tuitionServices =
                                          Provider.of<TuitionServices>(context,
                                              listen: false);
                                      return AlertDialog(
                                        title:
                                            const Text('Confirmar matricula'),
                                        content: Text(tuition),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                await tuitionServices
                                                    .creatTuition(tuition);
                                                Navigator.of(context).pop();
                                              },
                                              child:
                                              tuitionServices.status == true ? Row(
                                                children: [
                                                  Text('Creando...'),
                                                  CircularProgressIndicator(),
                                                ],
                                              ) :
                                               const Text('Aceptar')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancelar'))
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text('AGREGAR MATRICULA')),
                        ],
                      )),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void onLoading() async {
    final tuitionServices =
        Provider.of<TuitionServices>(context, listen: false);
    await tuitionServices.getAllTuition();
  }
}
