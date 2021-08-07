import 'package:beco_passenger/stores/map_store.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

class MyMapWidget extends StatefulWidget {
  const MyMapWidget({Key? key});

  @override
  State<StatefulWidget> createState() => MyMapWidgetState();
}

class MyMapWidgetState extends State<MyMapWidget> {
  MapStore mapStore = MapStore();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mapStore = Provider.of<MapStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                initialCameraPosition: mapStore.initialCameraPosition,
                onMapCreated: mapStore.onMapCreated,
                markers: Set<Marker>.of(mapStore.markers),
                polylines: {
                  if (mapStore.info != null)
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Color(0xff15192C),
                      width: 5,
                      points: mapStore.info!.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
              ),
              if (mapStore.info != null)
                Positioned(
                  top: 45,
                  left: MediaQuery.of(context).size.width / 4,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Color(0xff15192C),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Text(
                      '${mapStore.info!.totalDistance}, ${mapStore.info!.totalDuration}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
