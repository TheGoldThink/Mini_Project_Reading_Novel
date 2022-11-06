import 'package:flutter/material.dart';
import 'package:reading_novel_mini_project/screens/detailview.dart';
import '../../models/novelModeldata.dart';

class DaftarNovel extends StatefulWidget {
  final IsiNovel novell;
  const DaftarNovel({super.key, required this.novell});

  @override
  State<DaftarNovel> createState() => _DaftarNovelState();
}

class _DaftarNovelState extends State<DaftarNovel> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Image.network(widget.novell.image),
        ),
        Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              color: Colors.black26,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                          text: widget.novell.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ))),
            ),
          ],
        )
      ]),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailView(
                  gambar: widget.novell.image,
                  nama: widget.novell.name,
                  sinopsis: widget.novell.sinopsis,
                  genre: widget.novell.genre,
                  chapter: widget.novell.ch),
            ));
      },
    );
  }
}
