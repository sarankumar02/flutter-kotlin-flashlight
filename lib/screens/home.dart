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
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text("Flashlight kotlin",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ))),
        body: Container(
          padding: const EdgeInsets.all(20),
          width: screenSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.5,
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.red,
                child: Image.asset(
                  torchOn
                      ? 'assets/images/torch_on.png'
                      : 'assets/images/torch_off.png',
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    torchOn = await _repository.turnOnOrOffFlashLight();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                      primary: torchOn ? Colors.white : Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      )),
                  child: Text(
                    torchOn ? 'Torch on' : 'Torch off',
                    style:
                        TextStyle(color: torchOn ? Colors.black : Colors.white),
                  ))
            ],
          ),
        ));
  }
}
