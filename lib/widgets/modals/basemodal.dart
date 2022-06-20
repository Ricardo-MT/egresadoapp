import 'package:egresadoapp/widgets/bring_in_widgets/scale_in_wrapper.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';

import '../../utils/decorations.dart';

class MuiBaseModal extends StatelessWidget {
  final Widget? title;
  final Widget? child;
  const MuiBaseModal({Key? key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleInWrapper(
      index: 0,
      child: DecoratedBox(
        decoration: modalDecoration,
        child: ClipRRect(
          borderRadius: borderRadiusForControllers,
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.white,
            child: InkWell(
                child: Padding(
              padding: modalPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: title == null ? spacerZero : title!),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  child == null ? spacerZero : child!
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
