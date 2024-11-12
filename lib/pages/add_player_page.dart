import 'package:flutter/material.dart';
import '../data/models/player_card.dart';

class AddPlayerPage extends StatefulWidget {
  final void Function(PlayerCard) onSubmit;

  const AddPlayerPage({super.key, required this.onSubmit});

  @override
  State<AddPlayerPage> createState() => _AddPlayerPageState();
}

class _AddPlayerPageState extends State<AddPlayerPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _photoUrlController = TextEditingController();

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newPlayerCard = PlayerCard(
        playerCardId: 0,
        footballerName: _nameController.text,
        description: _descriptionController.text,
        photoUrl: _photoUrlController.text,
      );

      widget.onSubmit(newPlayerCard);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавить нового футболиста"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Имя футболиста"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите имя';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Описание"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите описание';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _photoUrlController,
                decoration: const InputDecoration(labelText: "URL фотографии"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите URL изображения';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
