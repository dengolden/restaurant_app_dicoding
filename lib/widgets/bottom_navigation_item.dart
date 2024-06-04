import 'package:flutter/material.dart';
import 'package:restaurant_app_1/shared/theme.dart';

class BottomNavigationItem extends StatefulWidget {
  final String imageUrl;
  final bool isActive;
  final String title;

  const BottomNavigationItem({
    required this.imageUrl,
    this.title = '',
    this.isActive = false,
  });

  @override
  State<BottomNavigationItem> createState() => _BottomNavigationItemState();
}

class _BottomNavigationItemState extends State<BottomNavigationItem> {
  @override
  Widget build(BuildContext context) {
    bool isActive = widget.isActive;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 27,
          height: 27,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                widget.imageUrl,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? whiteColor : Colors.transparent,
          ),
        ),
      ],
    );
  }
}
