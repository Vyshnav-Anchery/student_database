import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    XFile? myfile;
    late Uint8List imagebytes;
    late var compressed;
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
            appBar: AppBar(title: const Text("Add Students")),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 50, left: 30, right: 30),
                child: Column(
                  children: [
                    Text("Enter details",
                        style: GoogleFonts.secularOne(
                            textStyle: const TextStyle(fontSize: 30))),
                    Form(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter name',
                                label: Text("Name")),
                            controller: nameEditingController,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter age',
                                label: Text("Age")),
                            controller: ageEditingController,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter phone number',
                                label: Text("Contact")),
                            controller: numberEditingController,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter address',
                                label: Text("Address")),
                            controller: addressEditingController,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter blood group',
                                label: Text("Blood Group")),
                            controller: bloodEditingController,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter batch',
                                label: Text("Batch")),
                            controller: stdEditingController,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            child: myfile != null ? Text(myfile!.path) : null,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                myfile = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                imagebytes = await myfile!.readAsBytes();
                                compressed =
                                    await FlutterImageCompress.compressWithList(
                                  imagebytes,
                                  quality: 85,
                                );
                              },
                              child: const Text("Pick Image From Gallery")),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () {
                                addBloc.add(
                                  AddClickedEvent(
                                    name: nameEditingController.text,
                                    address: addressEditingController.text,
                                    age: int.parse(ageEditingController.text),
                                    bloodgrp: bloodEditingController.text,
                                    number:
                                        int.parse(numberEditingController.text),
                                    division: stdEditingController.text,
                                    image: compressed,
                                  ),
                                );
                              },
                              child: const Text("add"))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
