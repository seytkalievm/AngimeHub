import 'package:flutter/material.dart';


class BottomBarIcon extends StatelessWidget{
  final bool isSelected;
  final IconData icon;
  const BottomBarIcon({
    Key? key,
    required this.isSelected,
    required this.icon
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return isSelected ? _selected() : _notSelected();
  }

  Widget _selected(){
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        Container(
          color:
          const Color.fromARGB(255, 11, 191, 184),
          height: 2,
          width: 24,
          margin: const EdgeInsets.fromLTRB(1, 6, 1, 0),
        )
      ],
    );
  }

  Widget _notSelected(){
    return Column(children: [
      Icon(
        icon,
        color: const Color.fromARGB(255, 156, 160, 199),
        size: 24,
      ),
      Container(
        color: const Color.fromARGB(255, 42, 45, 71),
        height: 2,
        width: 24,
        margin: const EdgeInsets.fromLTRB(1, 6, 1, 0),
      )
    ]
    );
  }

}