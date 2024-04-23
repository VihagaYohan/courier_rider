import 'package:flutter/material.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';
import 'package:flutter/widgets.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class UIDropDown extends StatefulWidget {
  final String placeholderText;
  final List<dynamic> optionList;
  final FormFieldValidator<String>? validator;
  final ValueChanged? onChanged;

  const UIDropDown(
      {super.key,
      required this.placeholderText,
      required this.optionList,
      required this.validator,
      this.onChanged});

  @override
  State<UIDropDown> createState() => _UIDropDownState();
}

class _UIDropDownState extends State<UIDropDown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    Color backgroundColor =
        Brightness.dark == brightness ? AppColors.dark : AppColors.white;

    return DropdownButtonFormField(
      value: dropdownValue,
      hint: UITextView(
        text: widget.placeholderText,
        textStyle:
            Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
      ),
      /*  onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      }, */
      onChanged: widget.onChanged,
      items: widget.optionList.map<DropdownMenuItem<String>>((var item) {
        return DropdownMenuItem<String>(
            value: item.id,
            child: UITextView(
              text: item.name,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 12),
            ));
      }).toList(),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      icon: const Icon(Icons.expand_more),
      dropdownColor: backgroundColor,
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      validator: widget.validator,
    );
  }
}
