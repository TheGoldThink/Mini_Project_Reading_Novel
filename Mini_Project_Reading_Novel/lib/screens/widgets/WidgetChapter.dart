// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:mini_Project_Reading_Novel/screens/ReadNovelScreen.dart';

class ChapterViewWidget extends StatelessWidget {
  String judul, image;
  int index;
  List bambang;
  ChapterViewWidget(
      {super.key,
      required this.judul,
      required this.index,
      required this.bambang,
      required this.image});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReadNovel(
                        index: index,
                        novel: bambang,
                        gambar: image,
                      )));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          margin: const EdgeInsets.only(bottom: 16),
          width: size.width - 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(38.5),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 33,
                color: const Color(0xFFD3D3D3).withOpacity(.84),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: judul,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black26,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.fade),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
                onPressed: (() {}),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
