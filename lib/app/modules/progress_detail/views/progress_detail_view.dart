import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/progress_detail_controller.dart';

class ProgressDetailView extends GetView<ProgressDetailController> {
  const ProgressDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProgressDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProgressDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
