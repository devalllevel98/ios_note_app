import 'package:flutter/material.dart';
import 'package:noteapp/models/note_model.dart';
import 'package:noteapp/utils/helpers/helpers.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({super.key, required this.value, required this.onTapFavorite});

  final NoteModel value;
  final Function() onTapFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: ShapeDecoration(
        color: Color(value.color!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  value.title.isEmpty ? value.content : value.title,
                  maxLines: null,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: maxWidth * 0.07,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timeFormat(value.time!),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(.5),
                      fontSize: maxWidth * 0.04,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTapFavorite,
                    child: Icon(
                      value.isFavorite!
                          ? Icons.favorite
                          : Icons.favorite_border_rounded,
                      size: maxWidth * 0.06,
                      color: value.isFavorite!
                          ? Colors.red[700]
                          : Colors.black.withOpacity(.5),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
