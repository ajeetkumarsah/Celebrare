import 'package:celebrare/model/text_properties.dart';
import 'package:celebrare/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('celebrare'),
      ),
      body: Stack(
        children: homeProvider.texts.asMap().entries.map((entry) {
          int index = entry.key;
          TextProperties textProperties = entry.value;
          return Positioned(
            left: textProperties.position.dx,
            top: textProperties.position.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                homeProvider.moveText(
                    index, textProperties.position + details.delta);
              },
              child: Text(
                textProperties.text,
                style: GoogleFonts.getFont(
                  textProperties.fontFamily,
                  color: textProperties.color,
                  fontSize: textProperties.fontSize,
                ),
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTextDialog();
            },
          );
        },
      ),
    );
  }
}

class AddTextDialog extends StatefulWidget {
  const AddTextDialog({super.key});

  @override
  _AddTextDialogState createState() => _AddTextDialogState();
}

class _AddTextDialogState extends State<AddTextDialog> {
  final _textController = TextEditingController();
  String _fontFamily = 'Roboto';
  Color _color = Colors.black;
  double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Text'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Text'),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _fontFamily,
              items: [
                'Roboto',
                'Lobster',
                'Pacifico',
                'Open Sans',
                'Merriweather',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _fontFamily = newValue;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            DropdownButton<double>(
              value: _fontSize,
              items: [
                10.0,
                12.0,
                14.0,
                16.0,
                18.0,
                20.0,
                22.0,
                24.0,
                26.0,
                28.0,
                30.0
              ].map((double value) {
                return DropdownMenuItem<double>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (double? newValue) {
                if (newValue != null) {
                  setState(() {
                    _fontSize = newValue;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Pick Color'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: _color,
                          onColorChanged: (Color color) {
                            setState(() {
                              _color = color;
                            });
                          },
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Got it'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          child: const Text('Add'),
          onPressed: () {
            if (_textController.text.isNotEmpty) {
              final textProperties = TextProperties(
                text: _textController.text,
                fontFamily: _fontFamily,
                color: _color,
                fontSize: _fontSize,
                position: const Offset(50, 50),
              );
              Provider.of<HomeProvider>(context, listen: false)
                  .addText(textProperties);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
