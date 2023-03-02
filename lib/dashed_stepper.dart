library dashed_stepper;

import 'package:flutter/material.dart';

class DashedStepper extends StatelessWidget {
  const DashedStepper({
    super.key,
    this.length = 3,
    this.step = 0,
    this.icons,
    this.labels,
    this.height,
    this.labelColor,
    this.indicatorColor,
    this.disabledColor,
    this.lineHeight,
    this.dotSize,
  })  : assert((icons == null || icons.length == length),
            'icons length must be the same as length'),
        assert((labels == null || labels.length == length),
            'labels length must be the same as length');
  final int length;
  final int step;
  final List<Widget>? icons;
  final List<String>? labels;
  final double? height;
  final Color? labelColor;
  final Color? indicatorColor;
  final Color? disabledColor;
  final double? lineHeight;
  final double? dotSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          length,
          (index) {
            return Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icons != null)
                    Container(
                      height: height ?? 40,
                      alignment: Alignment.topCenter,
                      child: icons![index],
                    ),
                  _HorizStep(
                    dotSize: dotSize,
                    height: lineHeight,
                    activeColor: indicatorColor,
                    inActiveColor: disabledColor,
                    length: size.maxWidth / length,
                    left: index < step,
                    right: index < step - 1,
                    roundedLeft: index == 0
                        ? true
                        : index < step
                            ? false
                            : true,
                    roundedRight: index == length - 1
                        ? true
                        : index < step - 1
                            ? false
                            : true,
                  ),
                  const SizedBox(height: 8),
                  if (labels != null)
                    Text(
                      labels![index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: labelColor ?? Colors.grey,
                      ),
                    )
                ],
              ),
            );
          },
        ),
      );
    });
  }
}

class _HorizStep extends StatelessWidget {
  const _HorizStep({
    this.left = false,
    this.right = false,
    this.length = 100,
    this.roundedLeft = true,
    this.roundedRight = true,
    this.activeColor,
    this.inActiveColor,
    this.height,
    this.dotSize,
  });
  final bool left;
  final bool right;
  final double length;
  final bool roundedLeft;
  final bool roundedRight;
  final Color? activeColor;
  final Color? inActiveColor;
  final double? height;
  final double? dotSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Line(
              width: length / 2,
              isActive: left,
              roundedLeft: roundedLeft,
              color: activeColor,
              disabledColor: inActiveColor,
              height: height,
            ),
            _Line(
              width: length / 2,
              isActive: right,
              roundedRight: roundedRight,
              color: activeColor,
              disabledColor: inActiveColor,
              height: height,
            ),
          ],
        ),
        _Dot(
          size: dotSize ?? 20,
          color: left
              ? activeColor ?? Colors.blue
              : inActiveColor ?? Colors.grey[300],
        ),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    this.width = 10,
    this.color,
    this.height,
    this.disabledColor,
    this.isActive = true,
    this.roundedLeft = true,
    this.roundedRight = true,
  });
  final double width;
  final double? height;
  final Color? color;
  final Color? disabledColor;
  final bool isActive;
  final bool roundedLeft;
  final bool roundedRight;

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return Container(
        width: width,
        height: height ?? 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: roundedLeft ? const Radius.circular(50) : Radius.zero,
            right: roundedRight ? const Radius.circular(50) : Radius.zero,
          ),
          color: color ?? Colors.blue,
        ),
      );
    } else {
      return Row(
        children: List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.only(left: 2),
            width: width / 3 - 2,
            height: height ?? 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: roundedLeft ? const Radius.circular(50) : Radius.zero,
                right: roundedRight ? const Radius.circular(50) : Radius.zero,
              ),
              color: disabledColor ?? Colors.grey[300],
            ),
          ),
        ),
      );
    }
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    this.size = 5,
    this.color,
  });

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Material(
        shape: const StadiumBorder(),
        color: color ?? Colors.black,
      ),
    );
  }
}
