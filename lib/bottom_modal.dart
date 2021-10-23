import 'package:flutter/material.dart';
import 'package:wifi_connect/wifi_module/wifi_module.dart';

class BottomModal extends StatefulWidget {
  final String name;

  const BottomModal({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<BottomModal> createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                label: Text('Password'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  WifiModule.connectWifiByName(
                    widget.name,
                    password: _controller.text,
                  );
                  Navigator.pop(context);
                }
              },
              color: Colors.green,
              child: const SizedBox(
                width: double.infinity,
                height: 48.0,
                child: Center(
                  child: Text('Connect'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
