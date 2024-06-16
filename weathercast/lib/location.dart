import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error(
        'Location services are disabled.'); //Error แล้วแจ้ง (คำที่แจ้งเตือน)
  }
  permission = await Geolocator.checkPermission(); //ขอใช้ GPS
  if (permission == LocationPermission.denied) {
    //ถามว่าได้ไหม
    permission = await Geolocator.requestPermission(); //ไม่ได้ขออีกรอบ
    if (permission == LocationPermission.denied) {
      //ในกรณีที่ขอเข้าถึงไม่ได้อีก
      return Future.error(
          'Location permissions are denied'); //ถ้าขอไม่ได้แจ้งเตือน
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
