import 'package:flutter/material.dart';
import 'package:media_vault/presentation/auth/local_auth/widgets/num_pad_field.dart';
import 'package:media_vault/presentation/auth/local_auth/widgets/pin_value.dart';

// A separate bloc would be overkill for this widget,
// as all the state is only used in this widget and nothing elsewhere in the app.
class NumPad extends StatefulWidget {
  final Function(String) onSubmit;
  const NumPad({required this.onSubmit, Key? key}) : super(key: key);

  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  final _pin = <String>["_", "_", "_", "_"];

  void _onNumPadFieldTap(int index) {
    if (!_pin.contains("_")) {
      return; // Do nothing if all fields are filled
    }
    final indexToUpdate = _pin.indexOf("_");
    setState(() {
      _pin[indexToUpdate] = index.toString();
    });
  }

  void _onRemoveFieldTap() {
    if (_pin.contains("_")) {
      final indexToUpdate = _pin.indexOf("_") - 1;
      if (indexToUpdate >= 0) {
        setState(() {
          _pin[indexToUpdate] = "_";
        });
      }
    } else {
      setState(() {
        _pin.last = "_";
      });
    }
  }

  void handleSubmit() {
    // submit pin
    widget.onSubmit(_pin.join());

    // reset pin
    setState(() {
      for (var i = 0; i < _pin.length; i++) {
        _pin[i] = "_";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          PinValue(digits: _pin),
          const SizedBox(height: 16),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(9, (index) {
              return NumPadField(
                label: '${index + 1}',
                onTap: () => _onNumPadFieldTap(index + 1),
              );
            }),
          ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(3, (index) {
              if (index == 0) {
                return NumPadField(
                    icon: const Icon(
                      Icons.backspace,
                      size: 36,
                    ),
                    onTap: _onRemoveFieldTap);
              } else if (index == 1) {
                return NumPadField(
                  label: "0",
                  onTap: () => _onNumPadFieldTap(0),
                );
              } else {
                return NumPadField(
                    icon: const Icon(
                      Icons.check,
                      size: 36,
                    ),
                    onTap: () {
                      if (_pin.contains("_")) {
                        return;
                      }
                      handleSubmit();
                    });
              }
            }),
          )
        ],
      ),
    );
  }
}
