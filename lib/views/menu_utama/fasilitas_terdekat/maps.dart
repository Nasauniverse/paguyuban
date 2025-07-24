import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:paguyuban/others/colors.dart';
import 'package:paguyuban/provider/maps_view_model.dart';
import 'package:paguyuban/widget/loading.dart';
import 'package:provider/provider.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MapsViewModel>(builder: (context, model, _) {
      if (model.isLoading) {
        return LoadingWidget();
      }
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorLibrary.shadow),
          backgroundColor: Colors.transparent,
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Tampilan Maps ',
              style: GoogleFonts.dancingScript(
                  color: ColorLibrary.shadow,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorLibrary.primarySuperDark,
                  ColorLibrary.primaryLow,
                  ColorLibrary.primary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
          ),
        ),
        body: model.dataMembers.isEmpty
            ? Center(child: Text('Data anggota tidak tersedia'))
            : Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      maxZoom: 14,
                      initialCenter:
                          LatLng(-6.894976034482388, 107.54333213808722),
                    ),
                    children: [
                      model.openStreetMapTileLayer,
                      MarkerClusterLayerWidget(
                        options: MarkerClusterLayerOptions(
                          maxClusterRadius: 45,
                          size: const Size(40, 40),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(50),
                          markers: model.dataMembers
                              .map((mapsData) {
                                final lat = mapsData.lat;
                                final long = mapsData.long;

                                if (lat != null && long != null) {
                                  return Marker(
                                    point: LatLng(lat, long),
                                    width: 150,
                                    height: 150,
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: () async {
                                        String? address =
                                            await model.fetchAddress(lat, long);
                                        model.bottomSheetMaps(
                                            context, mapsData, address);
                                      },
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Icon(
                                              Icons.location_pin,
                                              size: 60,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Expanded(
                                            child: AutoSizeText(
                                              maxLines: 2,
                                              mapsData.name ??
                                                  'Lokasi yang tidak disebutkan namanya!',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return null; 
                              })
                              .whereType<Marker>() 
                              .toList(),
                          builder: (context, maps) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorLibrary.primary,
                              ),
                              child: Center(
                                child: Text(
                                  maps.length.toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: ColorLibrary.shadow),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  // ListView.builder(
                  //   itemCount: 10,
                  //   itemBuilder: (context, i) {
                  //     return Text(model.dataMembers[i].lat.toString());
                  //   },
                  // ),
                ],
              ),
      );
    });
  }
}
