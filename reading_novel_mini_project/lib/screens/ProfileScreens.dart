// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_novel_mini_project/screens/editScreen.dart';
import 'package:reading_novel_mini_project/service/providers/profileProvider.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({super.key});

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  @override
  Widget build(BuildContext context) {
    final isloading =
        Provider.of<UserProviders>(context).state == UserState.loading;
    final isError =
        Provider.of<UserProviders>(context).state == UserState.error;
    List profile = Provider.of<UserProviders>(context).isiProfile;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : isError || profile.isEmpty
            ? const Center(
                child: Text("Saat ini anda sedang dalam mode offline"),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  Container(),
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const editScreen(),
                                          settings: RouteSettings(
                                              arguments: profile[0])),
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.43,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  double innerHeight = constraints.maxHeight;
                                  double innerWidth = constraints.maxWidth;
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: innerHeight * 0.72,
                                          width: innerWidth,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 80,
                                              ),
                                              Text(
                                                '${profile[0].fName} ${profile[0].lName}',
                                                style: TextStyle(
                                                  color: Colors
                                                      .blueAccent.shade400,
                                                  fontSize: 37,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Phone',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        profile[0].phone,
                                                        style: TextStyle(
                                                          color: Colors
                                                              .blueAccent
                                                              .shade400,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Email',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        profile[0].email,
                                                        style: TextStyle(
                                                          color: Colors
                                                              .blueAccent
                                                              .shade400,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        child: Center(
                                          child: Image.network(
                                            'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                                            width: innerWidth * 0.45,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: height * 0.5,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'About Me',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 27,
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 2.5,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: height * 0.10,
                                      decoration: const BoxDecoration(),
                                      child: Text(
                                        profile[0].about,
                                        style: TextStyle(
                                          color: Colors.blueAccent.shade400,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
  }
}
