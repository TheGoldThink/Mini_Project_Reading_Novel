// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:Mini_Project_Reading_Novel/screens/widgets/novel.dart';
import '../../service/providers/provider.dart';
import 'package:provider/provider.dart';

class novelViewModel extends StatefulWidget {
  const novelViewModel({super.key});

  @override
  State<novelViewModel> createState() => _novelViewState();
}

class _novelViewState extends State<novelViewModel> {
  @override
  Widget build(BuildContext context) {
    final isloading = Provider.of<Novels>(context).state == novelState.loading;
    final isError = Provider.of<Novels>(context).state == novelState.error;
    List novelss = Provider.of<Novels>(context).isinovelnya;
    return isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : isError
            ? const Center(
                child: Text("Gagal Load T_T ma"),
              )
            : MasonryGridView.count(
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                crossAxisSpacing: 15,
                mainAxisSpacing: 8,
                itemCount: novelss.length,
                itemBuilder: ((context, index) {
                  return DaftarNovel(novell: novelss[index]);
                }));
  }
}
