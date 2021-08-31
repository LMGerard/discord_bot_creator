import 'package:flutter/material.dart';

class ScrollableListButtons extends StatelessWidget {
  final Iterable list;
  final Function(int) callback;
  ScrollableListButtons({required this.list, required this.callback});
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              final element = list.elementAt(index);

              return AspectRatio(
                aspectRatio: 1 / 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          Colors.primaries[index % Colors.primaries.length],
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () => callback(index),
                  child: FittedBox(child: Text(element)),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 10),
          ),
        ),
      ),
    );
  }
}
