import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database/features/addstudent/bloc/add_student_bloc.dart';

import '../../features/details/bloc/details_bloc.dart';

class CustomFormWidget extends StatelessWidget {
  var bloc;
  var image;
  bool option;
  bool enabled;
  String? name;
  int? age;
  String? address;
  String? contact;
  String? bloodgroup;
  String? batch;
  int? index;

  CustomFormWidget({
    super.key,
    required this.bloc,
    required this.option,
    required this.enabled,
    this.name,
    this.age,
    this.address,
    this.contact,
    this.bloodgroup,
    this.batch,
    this.index,
    this.image,
  });

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController ageEditingController = TextEditingController();
  final TextEditingController numberEditingController = TextEditingController();
  final TextEditingController addressEditingController =
      TextEditingController();
  final TextEditingController bloodEditingController = TextEditingController();
  final TextEditingController stdEditingController = TextEditingController();
  var myfile;
  late Uint8List imagebytes;
  var compressed;

  @override
  Widget build(BuildContext context) {
    nameEditingController.text = name ?? "";
    ageEditingController.text = age?.toString() ?? "";
    numberEditingController.text = contact ?? "";
    addressEditingController.text = address ?? "";
    bloodEditingController.text = bloodgroup ?? "";
    stdEditingController.text = batch ?? "";
    return Form(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                enabled: enabled,
                border: const OutlineInputBorder(),
                hintText: 'Enter name',
                label: const Text("Name")),
            controller: nameEditingController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                enabled: enabled,
                border: const OutlineInputBorder(),
                hintText: 'Enter age',
                label: const Text("Age")),
            controller: ageEditingController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                enabled: enabled,
                border: const OutlineInputBorder(),
                hintText: 'Enter phone number',
                label: const Text("Contact")),
            controller: numberEditingController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                enabled: enabled,
                border: const OutlineInputBorder(),
                hintText: 'Enter address',
                label: const Text("Address")),
            controller: addressEditingController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                enabled: enabled,
                border: const OutlineInputBorder(),
                hintText: 'Enter blood group',
                label: const Text("Blood Group")),
            controller: bloodEditingController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                enabled: enabled,
                border: const OutlineInputBorder(),
                hintText: 'Enter batch',
                label: const Text("Batch")),
            controller: stdEditingController,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () async {
                myfile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                imagebytes = await myfile!.readAsBytes();
                compressed = await FlutterImageCompress.compressWithList(
                  imagebytes,
                  quality: 85,
                );
              },
              child: const Text("Pick Image From Gallery")),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              bloc.add(
                option
                    ? AddClickedEvent(
                        name: nameEditingController.text,
                        address: addressEditingController.text,
                        age: int.parse(ageEditingController.text),
                        bloodgrp: bloodEditingController.text,
                        number: numberEditingController.text,
                        division: stdEditingController.text,
                        image: compressed,
                      )
                    : UpdateStudentEvent(
                        index: index!,
                        name: nameEditingController.text,
                        address: addressEditingController.text,
                        age: int.parse(ageEditingController.text),
                        bloodgrp: bloodEditingController.text,
                        number: numberEditingController.text,
                        division: stdEditingController.text,
                        image: compressed ?? image,
                      ),
              );
            },
            child: option ? const Text("Add") : const Text("Update"),
          ),
        ],
      ),
    );
  }
}
