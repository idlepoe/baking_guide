import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/progress_list_controller.dart';

class ProgressListView extends GetView<ProgressListController> {
  const ProgressListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProgressListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProgressListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
