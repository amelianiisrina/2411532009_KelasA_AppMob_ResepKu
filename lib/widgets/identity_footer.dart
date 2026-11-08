import 'package:flutter/material.dart';

const String kNim = '2411532009';
const String kNama = 'Niisrina Amelia';

class IdentityFooter extends StatelessWidget {
  const IdentityFooter({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded (
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: child
          ),
        ),
        Material (
          color: Colors.black87,
          child: SafeArea (
            top: false,
            child: SizedBox(
              width: double.infinity,
              child: Padding (
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text (
                  '$kNim • $kNama',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}