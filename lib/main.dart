import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit/image.dart' as imgY;

import 'package:yandex_maps_mapkit/init.dart' as init;
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:yandex_maps_mapkit/mapkit_factory.dart';
import 'package:yandex_maps_mapkit/yandex_map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init.initMapkit(apiKey: "c0fbd72a-7821-468f-8476-90836fa8ff61");

  mapkit.onStart();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  
  @override
  State<MyApp> createState() => _MyAppState();
}

  
class _MyAppState extends State<MyApp> {
  
  late final list = MapObjectTapListenerImpl();

  MapWindow? _mapWindow;

  

  void _maps(MapWindow map_){

     const AlertDialog(title: Text("123"));
   
    _mapWindow = map_;

    _mapWindow?.map.mapType = MapType.Map;
    _mapWindow?.map.set2DMode(true);

    var prov = imgY.ImageProvider.fromImageProvider(const AssetImage("assets/bigMark.png"));

    _mapWindow?.map.move(
      const CameraPosition(
          Point(latitude: 55.751225, longitude: 37.62954),
          zoom: 17.0,
          azimuth: 0,//150.0,
          tilt: 0//30.0
        )
    );


    var placeMark = _mapWindow?.map.mapObjects.addPlacemarkWithImage(
      const Point(latitude: 55.751225, longitude: 37.62954),
      prov,
      );

      placeMark?.addTapListener(list);
      
  }
  
  @override
  Widget build(BuildContext context) {
    
    
    return MaterialApp(
      home: Scaffold(
        body: YandexMap(
          onMapCreated: _maps,
          

          )
          
      )
    );
  }
}

final class MapObjectTapListenerImpl implements MapObjectTapListener {


  @override
  bool onMapObjectTap(MapObject mapObject, Point point) {

    mapObject as PlacemarkMapObject;
    var prov = imgY.ImageProvider.fromImageProvider(const AssetImage("assets/ball_place_mark.png"));

    mapObject.setIcon(prov);
    

    //ScaffoldMessenger.of().showSnackBar(snackBar);
    return true;
  }
}

