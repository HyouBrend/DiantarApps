import 'package:flutter/material.dart';
import 'package:diantar_jarak/theme/theme.dart';

class PergantianStatus extends StatefulWidget {
  final String? initialValue;
  final void Function(String) onChanged;

  const PergantianStatus({
    Key? key,
    this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PergantianStatusState createState() => _PergantianStatusState();
}

class _PergantianStatusState extends State<PergantianStatus> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? 'Belum Dikirim';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColorPalette.surfaceColor,
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: const Text('Select', style: TextStyle(color: Colors.black)),
          dropdownColor: CustomColorPalette.surfaceColor,
          iconEnabledColor: CustomColorPalette.textColor,
          items: <String>[
            'Sudah Dikirim',
            'Belum Dikirim',
            'Tidak Dikirim',
            'Salah Input'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
            if (newValue != null) {
              widget.onChanged(newValue);
            }
          },
        ),
      ),
    );
  }
}
