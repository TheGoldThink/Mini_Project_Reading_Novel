// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_novel_mini_project/models/user_model.dart';
import 'package:reading_novel_mini_project/service/providers/profileProvider.dart';

class editScreen extends StatefulWidget {
  const editScreen({
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
  late List<String> bambang;
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
      bambang = updateuser!.favorite;
    }
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black,
                ),
                padding: const EdgeInsets.all(20),
                child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
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
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length > 60) {
                                return 'Jangan melebihi 60 karakter';
                              }
                              return null;
                            },
                            minLines: 6,
                            maxLines: null,
                            controller: about,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                                label: Text('About Me'),
                                icon: Icon(Icons.description),
                                alignLabelWithHint: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 15, 10, 100),
                                hintMaxLines: 6,
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Menyinmpan data baru...',
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent.shade400),
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ))),
              ),
            ],
          ),
        ));
  }

  updateData(UserModel user) async {
    formKey.currentState!.save();
    final u = UserModel(
      id: user.id,
      fName: fname.text,
      lName: lname.text,
      email: email.text,
      phone: phone.text,
      about: about.text,
      favorite: bambang,
    );
    await Provider.of<UserProviders>(context, listen: false).updateuser(u);
  }
}
