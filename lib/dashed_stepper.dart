library dashed_stepper;

import 'package:flutter/material.dart';

class DashedStepper extends StatelessWidget {
  const DashedStepper({
    super.key,
    this.length = 3,
    this.currentIndex = 0,
    this.onChanged,
    this.topChildren,
    this.quotes,
  });
  final int length;
  final int currentIndex;
  final ValueChanged<int>? onChanged;
  final List<Widget>? topChildren;
  final List<String>? quotes;

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
                  if (topChildren != null)
                    Container(
                      height: 50,
                      alignment: Alignment.topCenter,
                      child: topChildren![index],
                    ),
                  HorizStep(
                    length: size.maxWidth / length,
                    left: index < currentIndex,
                    right: index < currentIndex - 1,
                    roundedLeft: index == 0
                        ? true
                        : index < currentIndex
                            ? false
                            : true,
                    roundedRight: index == length - 1
                        ? true
                        : index < currentIndex - 1
                            ? false
                            : true,
                  ),
                  const SizedBox(height: 8),
                  if (quotes != null)
                    Text(
                      quotes![index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[300],
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

class HorizStep extends StatelessWidget {
  const HorizStep({
    super.key,
    this.left = false,
    this.right = false,
    this.length = 100,
    this.roundedLeft = true,
    this.roundedRight = true,
  });
  final bool left;
  final bool right;
  final double length;
  final bool roundedLeft;
  final bool roundedRight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Line(
              width: length / 2,
              isActive: left,
              roundedLeft: roundedLeft,
            ),
            Line(
              width: length / 2,
              isActive: right,
              roundedRight: roundedRight,
            ),
          ],
        ),
        Dot(
          size: 20,
          color: left ? Colors.blue : Colors.grey[300],
        ),
      ],
    );
  }
}

class Line extends StatelessWidget {
  const Line({
    super.key,
    this.width = 10,
    this.height = 4,
    this.color,
    this.disabledColor,
    this.isActive = true,
    this.roundedLeft = true,
    this.roundedRight = true,
  });
  final double width;
  final double height;
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
        height: height,
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
            height: height,
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

class Dot extends StatelessWidget {
  const Dot({
    super.key,
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
