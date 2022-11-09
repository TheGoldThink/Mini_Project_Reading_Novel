// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reading_novel_mini_project/screens/widgets/novel.dart';
import 'package:reading_novel_mini_project/service/providers/profileProvider.dart';
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
    final isloading =
        Provider.of<NovelProvider>(context).state == novelState.loading;
    final isError =
        Provider.of<NovelProvider>(context).state == novelState.error;
    List novelss = Provider.of<NovelProvider>(context).isinovelnya;
    List datauser = Provider.of<UserProviders>(context).isiProfile;
    return isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : isError || novelss.isEmpty
            ? const Center(
                child: Text("Saat ini anda sedang dalam mode offline"),
              )
            : MasonryGridView.count(
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                crossAxisSpacing: 15,
                mainAxisSpacing: 8,
                itemCount: novelss.length,
                itemBuilder: ((context, index) {
                  return DaftarNovel(
                    novell: novelss[index],
                    user: datauser[0],
                  );
                }));
  }
}
