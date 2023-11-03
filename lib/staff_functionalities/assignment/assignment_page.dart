import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../common_functionalities/widgets/dark_map_container.dart';
import '../../dependency_injection/dependency_injection.dart';
import 'state/assignment_cubit.dart';

class AssignmentPage extends StatelessWidget {
  const AssignmentPage({
    super.key,
    required this.points,
  });

  static const routeName = 'assignment';

  final int points;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssignmentCubit>(
      create: (context) => injector(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocSelector<AssignmentCubit, AssignmentState, List<String>>(
              selector: (state) => state is AssignmentInitial ? state.scannedUsers : [],
              builder: (context, users) {
                return IconButton(
                  onPressed: users.isNotEmpty ? () => context.read<AssignmentCubit>().assign(points) : null,
                  icon: const Icon(Icons.save),
                );
              },
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
                  onDetect: (barcodes) {
                    final scannedBarcodes = barcodes.barcodes.map((e) => e.rawValue).whereType<String>().toList();
                    context.read<AssignmentCubit>().onQrCodesScanned(scannedBarcodes);
                  },
                  /*scanWindow: Rect.fromCenter(
                    center: Offset(
                      MediaQuery.sizeOf(context).width / 2,
                      kToolbarHeight + 24 + MediaQuery.sizeOf(context).width / 2,
                    ),
                    width: MediaQuery.sizeOf(context).width * 0.65,
                    height: MediaQuery.sizeOf(context).width * 0.65,
                  ),*/
                ),
              ),
              const SizedBox(height: 16),
              BlocSelector<AssignmentCubit, AssignmentState, List<String>>(
                selector: (state) => state is AssignmentInitial ? state.scannedUsers : [],
                builder: (context, users) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(users[index]),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
