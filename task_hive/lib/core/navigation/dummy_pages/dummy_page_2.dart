import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes.dart';

class DummyPage2 extends StatelessWidget {
  const DummyPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dummy Page 2'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go(MyRoutes.dummyPage1);
          },
          child: const Text('Go to Dummy Page 1'),
        ),
      ),
    );
  }
}
