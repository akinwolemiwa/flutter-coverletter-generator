import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:flutter/material.dart';

class AccordionWidget extends StatefulWidget {
  final String title;
  final String content;

  const AccordionWidget({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  State<AccordionWidget> createState() => _AccordionWidgetState();
}

class _AccordionWidgetState extends State<AccordionWidget> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListTile(
              iconColor: AppColors.header,
              focusColor: Colors.transparent,
              selectedColor: Colors.transparent,
              tileColor: Colors.transparent,
              selectedTileColor: Colors.transparent,
              title: Text(
                widget.title,
                style: textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.header,
                  fontSize: 16,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
                onPressed: () {
                  setState(() {
                    _showContent = !_showContent;
                  });
                },
              ),
            ),
          ),
          _showContent
              ? Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greys),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.content,
                      style: textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.greys.shade400,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
