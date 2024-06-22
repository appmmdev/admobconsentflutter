import 'package:flutter/material.dart';

import 'intializationhelper.dart';

class InitializedScreen extends StatefulWidget {
  final Widget targetWidget;

  const InitializedScreen({super.key, required this.targetWidget});

  @override
  State<InitializedScreen> createState() => _InitializedScreenState();
}

class _InitializedScreenState extends State<InitializedScreen> {
  final _initializedHelper = IntializationHelper();

  @override
  void initState() {
    // TODO: implement initState

    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _initialize() async {
    final navigator = Navigator.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializedHelper.intialize();
      navigator.pushReplacement(
          MaterialPageRoute(builder: (_) => widget.targetWidget));
    });
  }
}
