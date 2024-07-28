import 'package:celebrare/model/text_properties.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  List<TextProperties> _texts = [];
  int _selectedTextIndex = -1;

  List<TextProperties> get texts => _texts;
  int get selectedTextIndex => _selectedTextIndex;

  void addText(TextProperties textProperties) {
    _texts.add(textProperties);
    notifyListeners();
  }

  void updateText(TextProperties textProperties) {
    if (_selectedTextIndex >= 0 && _selectedTextIndex < _texts.length) {
      _texts[_selectedTextIndex] = textProperties;
      notifyListeners();
    }
  }

  void selectText(int index) {
    _selectedTextIndex = index;
    notifyListeners();
  }

  void moveText(int index, Offset position) {
    if (index >= 0 && index < _texts.length) {
      _texts[index] = _texts[index].copyWith(position: position);
      notifyListeners();
    }
  }
}
