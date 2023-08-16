import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database/features/addstudent/bloc/add_student_bloc.dart';
import 'package:student_database/utils/constants/constants.dart';
import '../../features/details/bloc/details_bloc.dart';

// ignore: must_be_immutable
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
  String? latitude;
  String? longitude;

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
    this.latitude,
    this.longitude,
  });

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController ageEditingController = TextEditingController();
  final TextEditingController numberEditingController = TextEditingController();
  final TextEditingController addressEditingController =
      TextEditingController();
  final TextEditingController bloodEditingController = TextEditingController();
  final TextEditingController stdEditingController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  var myfile;
  late Uint8List imagebytes;
  var compressed;
  String? imageName;
  Position? location;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nameEditingController.text = name ?? "";
    ageEditingController.text = age?.toString() ?? "";
    numberEditingController.text = contact ?? "";
    addressEditingController.text = address ?? "";
    bloodEditingController.text = bloodgroup ?? "";
    stdEditingController.text = batch ?? "";
    locationController.text = latitude.toString();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Constants.formSized,
          TextFormField(
            decoration: InputDecoration(
              enabled: enabled,
              border: const OutlineInputBorder(),
              hintText: Constants.nameHint,
              label: Text(Constants.nameString),
            ),
            controller: nameEditingController,
          ),
          Constants.formSized,
          TextFormField(
            maxLength: 2,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              enabled: enabled,
              border: const OutlineInputBorder(),
              hintText: Constants.ageHint,
              label: Text(Constants.ageString),
            ),
            controller: ageEditingController,
          ),
          Constants.formSized,
          TextFormField(
            maxLength: 10,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              enabled: enabled,
              border: const OutlineInputBorder(),
              hintText: Constants.numberHint,
              label: Text(Constants.contactString),
            ),
            controller: numberEditingController,
          ),
          Constants.formSized,
          TextFormField(
            decoration: InputDecoration(
              enabled: enabled,
              border: const OutlineInputBorder(),
              hintText: Constants.addressHint,
              label: Text(Constants.addressString),
            ),
            controller: addressEditingController,
          ),
          Constants.formSized,
          TextFormField(
            decoration: InputDecoration(
              enabled: enabled,
              border: const OutlineInputBorder(),
              hintText: Constants.bloodHint,
              label: Text(Constants.bloodString),
            ),
            controller: bloodEditingController,
          ),
          Constants.formSized,
          TextFormField(
            decoration: InputDecoration(
              enabled: enabled,
              border: const OutlineInputBorder(),
              hintText: Constants.divisionHint,
              label: Text(Constants.divisionString),
            ),
            controller: stdEditingController,
          ),
          Constants.formSized,
          !option
              ? TextFormField(
                  decoration: InputDecoration(
                    enabled: enabled,
                    border: const OutlineInputBorder(),
                    hintText: Constants.divisionHint,
                    label: Text(Constants.locationString),
                  ),
                  controller: locationController,
                )
              : const SizedBox(),
          Constants.formSized,
          enabled
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: imagePick, child: Constants.imageButtonIcon),
                    ElevatedButton(
                        onPressed: locationpick,
                        child: Constants.locationButtonIcon),
                  ],
                )
              : const SizedBox(),
          Constants.formSized,
          enabled
              ? ElevatedButton(
                  onPressed: option ? add : update,
                  child: option
                      ? Constants.addButtonText
                      : Constants.updateButtonText,
                )
              : const SizedBox(),
          Constants.formSized,
        ],
      ),
    );
  }

  add() {
    bloc.add(AddClickedEvent(
      name: nameEditingController.text,
      address: addressEditingController.text,
      age: int.parse(ageEditingController.text),
      bloodgrp: bloodEditingController.text,
      number: numberEditingController.text,
      division: stdEditingController.text,
      image: compressed,
      latitude: location!.latitude.toString(),
      longitude: location!.longitude.toString(),
    ));
    _formKey.currentState!.reset();
  }

  update() {
    bloc.add(UpdateStudentEvent(
      index: index!,
      name: nameEditingController.text,
      address: addressEditingController.text,
      age: int.parse(ageEditingController.text),
      bloodgrp: bloodEditingController.text,
      number: numberEditingController.text,
      division: stdEditingController.text,
      image: compressed ?? image,
    ));
  }

  imagePick() async {
    myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    String imagePath = myfile.path;
    imageName = imagePath.split('/').last;
    imagebytes = await myfile!.readAsBytes();
    compressed =
        await FlutterImageCompress.compressWithList(imagebytes, quality: 85);
  }

  locationpick() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission Denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permission Are Permenantly Denied");
    }
    location = await Geolocator.getCurrentPosition();
  }
}
