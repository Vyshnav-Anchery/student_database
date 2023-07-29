import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/add_student_bloc.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController ageEditingController = TextEditingController();
  final TextEditingController numberEditingController = TextEditingController();
  final TextEditingController addressEditingController =
      TextEditingController();
  final TextEditingController bloodEditingController = TextEditingController();
  final TextEditingController stdEditingController = TextEditingController();
  final AddStudentBloc addBloc = AddStudentBloc();
  late Uint8List imagebytes;
  late var compressed;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        listenWhen: (previous, current) => current is AddStudentState,
        buildWhen: (previous, current) => current is! AddStudentState,
        listener: (context, state) {
          if (state is AddStudentAddedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Student Added')));
          }
        },
        bloc: addBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    controller: nameEditingController,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    controller: ageEditingController,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    controller: numberEditingController,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    controller: addressEditingController,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    controller: bloodEditingController,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    controller: stdEditingController,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final myfile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        imagebytes = await myfile!.readAsBytes();
                        compressed =
                            await FlutterImageCompress.compressWithList(
                          imagebytes,
                          quality: 85,
                        );
                      },
                      child: const Text("Pick Image From Gallery")),
                  ElevatedButton(
                      onPressed: () {
                        addBloc.add(
                          AddClickedEvent(
                            name: nameEditingController.text,
                            address: addressEditingController.text,
                            age: int.parse(ageEditingController.text),
                            bloodgrp: bloodEditingController.text,
                            number: int.parse(numberEditingController.text),
                            division: stdEditingController.text,
                            image: compressed,
                          ),
                        );
                      },
                      child: const Text("add"))
                ],
              ),
            ),
          );
        });
  }
}
