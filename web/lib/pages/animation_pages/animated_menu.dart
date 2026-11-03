import 'package:flutter/material.dart';

class AnimatedMenu extends StatefulWidget {
  const AnimatedMenu({super.key});

  @override
  State<AnimatedMenu> createState() => _AnimatedMenuState();
}

class _AnimatedMenuState extends State<AnimatedMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;
  late final Animation<Offset> _offset;
  late final Animation<double> _settingsProgress;
  late final Animation<Offset> _settingsOffset;
  late final Animation<Offset> _cameraOffset;
  late final Animation<Offset> _editOffset;
  late final Animation<double> _cameraProgress;
  late final Animation<double> _editProgress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _rotation = Tween<double>(begin: 0, end: 0.125).animate(_controller);
    _offset = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(_controller);

    _settingsProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _cameraProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.75, curve: Curves.easeOut),
    );

    _editProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    );

    _settingsOffset = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(_settingsProgress);

    _cameraOffset = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(_cameraProgress);

    _editOffset = Tween<Offset>(
      begin: Offset(0.2, 0.75),
      end: Offset.zero,
    ).animate(_editProgress);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeTransition(
          opacity: _editProgress,
          child: SlideTransition(
            position: _editOffset,
            child: IconButton.filled(onPressed: () {}, icon: Icon(Icons.edit)),
          ),
        ),
        const SizedBox(height: 6),
        FadeTransition(
          opacity: _cameraProgress,
          child: SlideTransition(
            position: _cameraOffset,
            child: IconButton.filled(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt),
            ),
          ),
        ),
        const SizedBox(height: 6),
        FadeTransition(
          opacity: _settingsProgress,
          child: SlideTransition(
            position: _settingsOffset,
            child: IconButton.filled(
              onPressed: () {},
              icon: const Icon(Icons.settings),
            ),
          ),
        ),
        const SizedBox(height: 6),
        IconButton.filled(
          onPressed: () {
            _controller.isDismissed
                ? _controller.forward()
                : _controller.reverse();
          },
          icon: RotationTransition(turns: _rotation, child: Icon(Icons.add)),
        ),
      ],
    );
  }
}
