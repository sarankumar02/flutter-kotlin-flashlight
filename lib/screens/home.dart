import 'package:flutter/material.dart';
import 'package:kotlin_flashlight/repository/platform_repo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repository = PlatformRepository();
  bool torchOn = false;
  late Size screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: screenSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                torchOn = await _repository.turnOnOrOffFlashLight();
                print("TORCH $torchOn");
                setState(() {});
              },
              child: Text(torchOn ? 'Torch on' : 'Torch off'))
        ],
      ),
    ));
  }
}
