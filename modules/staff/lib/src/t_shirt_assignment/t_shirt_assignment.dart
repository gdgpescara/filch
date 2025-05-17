import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ui/ui.dart';

import 'state/t_shirt_assignment_cubit.dart';

class TShirtAssignment extends StatelessWidget {
  const TShirtAssignment({super.key, required this.onDone});

  final ValueChanged<BuildContext> onDone;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TShirtAssignmentCubit>(
      create: (context) => GetIt.I(),
      child: BlocListener<TShirtAssignmentCubit, TShirtAssignmentState>(
        listener: (context, state) {
          switch (state) {
            case TShirtAssigning():
              LoaderOverlay.show(
                context,
                message: t.staff.t_shirt_assignment.page.assigning,
              );
            case TShirtAssignFailure():
              LoaderOverlay.hide(context);
              onDone(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.staff.t_shirt_assignment.page.error),
                  backgroundColor: appColors.error.seed,
                ),
              );
            case TShirtAssigned():
              LoaderOverlay.hide(context);
              onDone(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.staff.t_shirt_assignment.page.success),
                  backgroundColor: appColors.success.seed,
                ),
              );
            default:
              break;
          }
        },
        child: Background(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(t.staff.t_shirt_assignment.page.title),
            ),
            body: Center(
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.65,
                height: MediaQuery.sizeOf(context).width * 0.65,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Builder(
                  builder: (context) {
                    return MobileScanner(
                      controller: MobileScannerController(
                        detectionSpeed: DetectionSpeed.noDuplicates,
                        formats: [BarcodeFormat.qrCode],
                      ),
                      onDetect: (barcodes) {
                        final user = barcodes.barcodes.firstOrNull?.rawValue;
                        if (user != null) {
                          context
                              .read<TShirtAssignmentCubit>()
                              .assignTShirt(user);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
