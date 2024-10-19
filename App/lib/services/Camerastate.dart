import 'package:camera/camera.dart';

class Camerastate {
  List<CameraDescription> cameras;
  
  Camerastate(this.cameras);

  get firstCamera => cameras.first;

}