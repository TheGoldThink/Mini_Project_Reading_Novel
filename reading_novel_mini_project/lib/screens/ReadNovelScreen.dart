// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class ReadNovel extends StatefulWidget {
  List novel;
  int index;
  String gambar;
  ReadNovel(
      {super.key,
      required this.index,
      required this.novel,
      required this.gambar});

  @override
  State<ReadNovel> createState() => _ReadNovelState();
}

class _ReadNovelState extends State<ReadNovel> {
  late int info = widget.index;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * .05),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      widget.novel[info][0],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            if (info != 0) {
                              scrollController.animateTo(0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn);
                              info -= 1;
                            } else {
                              Navigator.pop(context);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), //change border radius of this beautiful button thanks to BorderRadius.circular function
                          ),
                        ),
                        icon: Icon(info != 0
                            ? Icons.keyboard_arrow_left_sharp
                            : Icons.home),
                        label: Text(info != 0 ? "back" : "tittle")),
                    const Spacer(),
                    ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            if (info != widget.novel.length - 1) {
                              scrollController.animateTo(0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn);
                              info += 1;
                            } else {
                              Navigator.pop(context);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), //change border radius of this beautiful button thanks to BorderRadius.circular function
                          ),
                        ),
                        icon: Icon(info != widget.novel.length - 1
                            ? Icons.keyboard_arrow_right_sharp
                            : Icons.home),
                        label: Text(info != widget.novel.length - 1
                            ? "next"
                            : "tittle")),
                  ],
                ),
                Image.network(
                  widget.gambar,
                  height: size.height * .45,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      widget.novel[info][1],
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            if (info != 0) {
                              info -= 1;
                              scrollController.animateTo(0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn);
                            } else {
                              Navigator.pop(context);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), //change border radius of this beautiful button thanks to BorderRadius.circular function
                          ),
                        ),
                        icon: Icon(info != 0
                            ? Icons.keyboard_arrow_left_sharp
                            : Icons.home),
                        label: Text(info != 0 ? "back" : "tittle")),
                    SizedBox(
                      width: size.width * .18,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            scrollController.animateTo(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), //change border radius of this beautiful button thanks to BorderRadius.circular function
                          ),
                        ),
                        icon: const Icon(Icons.arrow_upward),
                        label: const Text("Top")),
                    const Spacer(),
                    ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            if (info != widget.novel.length - 1) {
                              scrollController.animateTo(0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn);
                              info += 1;
                            } else {
                              Navigator.pop(context);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), //change border radius of this beautiful button thanks to BorderRadius.circular function
                          ),
                        ),
                        icon: Icon(info != widget.novel.length - 1
                            ? Icons.keyboard_arrow_right_sharp
                            : Icons.home),
                        label: Text(info != widget.novel.length - 1
                            ? "next"
                            : "tittle")),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
