import 'package:flutter/material.dart';
import 'package:nzdoc_maps_mobile/domain/models/location_model.dart';

class LocationSheet extends StatelessWidget {
  const LocationSheet({super.key, required this.data, required this.onClose});

  final Location data;
  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.3,
        maxChildSize: 1,
        snapSizes: [0.3, 1],
        snap: true,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: ListView(
              controller: scrollController,
              physics: ClampingScrollPhysics(),
              children: [
                CloseButton(onPressed: onClose),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Additional Content Here',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5000),
              ],
            ),
          );
        },
      ),
    );
  }
}
