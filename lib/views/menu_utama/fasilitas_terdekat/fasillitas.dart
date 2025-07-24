import 'package:flutter/material.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/maps_view_model.dart';
import 'package:provider/provider.dart';


class FasilitasPage extends StatelessWidget {
  const FasilitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MapsViewModel>(
      builder: (context, model, _) => Scaffold(
          appBar: AppBar(
            title: Text('Tampilan List Fasilitas'),
          ),
          body: ListView.builder(
            itemCount: model.dataMembers.length,
            itemBuilder: (c, i) {
              return Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorLibrary.primary,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.13,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          color: ColorLibrary.shadow,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(model.dataMembers[i].name!,),
                        Text(model.dataMembers[i].regencyId!),
                        Text(model.dataMembers[i].long.toString()),
                        Text(model.dataMembers[i].lat.toString()),
                        Text(model.dataMembers[i].membersCount.toString()),
                      ],
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
