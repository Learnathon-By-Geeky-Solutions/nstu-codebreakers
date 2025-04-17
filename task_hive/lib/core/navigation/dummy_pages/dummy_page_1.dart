import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_hive/core/navigation/routes.dart';

class DummyPage1 extends StatelessWidget {
  const DummyPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dummy Page 1'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go(MyRoutes.dummyPage2);
          },
          child: const Text('Go to Dummy Page 2'),
        ),
      ),
    );
  }
}
