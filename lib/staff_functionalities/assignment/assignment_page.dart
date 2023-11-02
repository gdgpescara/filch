import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../common_functionalities/widgets/dark_map_container.dart';

class AssignmentPage extends StatelessWidget {
  const AssignmentPage({super.key});

  static const routeName = 'assignment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: DarkMapContainer(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.65,
              height: MediaQuery.sizeOf(context).width * 0.65,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: MobileScanner(
                onDetect: (barcodes) {},
                scanWindow: Rect.fromCenter(
                  center: Offset(
                    MediaQuery.sizeOf(context).width / 2,
                    kToolbarHeight + 24 + MediaQuery.sizeOf(context).width / 2,
                  ),
                  width: MediaQuery.sizeOf(context).width * 0.65,
                  height: MediaQuery.sizeOf(context).width * 0.65,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: Text('Item n. $index'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
