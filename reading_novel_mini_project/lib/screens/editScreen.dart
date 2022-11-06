// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_novel_mini_project/models/user_model.dart';
import 'package:reading_novel_mini_project/service/providers/provider.dart';

class editScreen extends StatefulWidget {
  editScreen({
    super.key,
  });

  @override
  State<editScreen> createState() => _editScreenState();
}

class _editScreenState extends State<editScreen> {
  TextEditingController fname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController about = TextEditingController();
  UserModel? updateuser;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    fname.dispose();
    lname.dispose();
    phone.dispose();
    about.dispose();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updateuser = ModalRoute.of(context)!.settings.arguments as UserModel?;
    if (updateuser != null) {
      fname.text = updateuser!.fName;
      lname.text = updateuser!.lName;
      email.text = updateuser!.email;
      phone.text = updateuser!.phone;
      about.text = updateuser!.about;
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
                child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      label: Text('First Name'),
                      hintText: 'Bambang',
                    ),
                    validator: (value) {
                      if (value == null || value.length < 2) {
                        return 'Silakan input nama yang valid';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    controller: fname,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      label: Text('Last Name'),
                      hintText: 'Bambang',
                    ),
                    validator: (value) {
                      if (value == null || value.length < 2) {
                        return 'Silakan input nama yang valid';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    controller: lname,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      label: Text('Phone Number'),
                      hintText: '081234567890',
                    ),
                    validator: (value) {
                      if (value == null || value.length < 10) {
                        return 'Silakan input nomor telepon yang valid';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: phone,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      label: Text('Email'),
                      hintText: 'hm@gmail.com',
                    ),
                    validator: (email) {
                      if (email != null && email.length < 5) {
                        return 'Tolong Masukkan Email Yang Benar';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    controller: email,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    // Handles Form Validation
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length > 50) {
                        return 'Please describe yourself but keep it under 200 characters.';
                      }
                      return null;
                    },
                    minLines: 6,
                    maxLines: null,

                    controller: about,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.description),
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 100),
                        hintMaxLines: 3,
                        hintText: 'Bagaimana Perasaanmu'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final valid = formKey.currentState!.validate();
                      if (valid) {
                        updateData(updateuser!);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade400),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ))));
  }

  updateData(UserModel user) async {
    formKey.currentState!.save();
    final u = UserModel(
        id: user.id,
        fName: fname.text,
        lName: lname.text,
        email: email.text,
        phone: phone.text,
        about: about.text);
    await Provider.of<Novels>(context, listen: false).updateuser(u);
  }
}
