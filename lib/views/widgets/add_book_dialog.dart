import 'package:flutter/material.dart';

import '../../models/books_model.dart';

class AddBookDialog extends StatefulWidget {
  const AddBookDialog({super.key});

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pdfUrlController = TextEditingController();
  final _coverImageUrlController = TextEditingController();
  final _publishedDate = TextEditingController();
  String _genre = '';
  String _categoryId = '';

  // void _selectPublishedDate(BuildContext context) async {
  //   final DateTime? selectedDate = await showDatePicker(
  //     context: context,
  //     initialDate: _publishedDate,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (selectedDate != null && selectedDate != _publishedDate) {
  //     setState(() {
  //       _publishedDate = selectedDate;
  //     });
  //   }
  // }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final book = BooksModel(
        id: '', // Generate or fetch ID as needed
        title: _titleController.text,
        author: _authorController.text,
        description: _descriptionController.text,
        pdfUrl: _pdfUrlController.text,
        coverImageUrl: _coverImageUrlController.text,
        publishedDate: _publishedDate.text,
        genre: _genre,
        categoryId: _categoryId,
      );

      // Handle the created book model (e.g., save to database)
      print('Book Model Created: ${book.title}');

      Navigator.of(context).pop(); // Close the dialog
    }
  }

  bool _isValidURL(String url) {
    final urlPattern = r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$';
    final regex = RegExp(urlPattern);
    return regex.hasMatch(url);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Book'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an author';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pdfUrlController,
                decoration: InputDecoration(labelText: 'PDF URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a PDF URL';
                  }
                  if (!_isValidURL(value)) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _coverImageUrlController,
                decoration: InputDecoration(labelText: 'Cover Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a cover image URL';
                  }
                  if (!_isValidURL(value)) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Text(
              //           "Published Date: {DateFormat('yyyy-MM-dd').format(_publishedDate)}"),
              //     ),
              //     IconButton(
              //       icon: Icon(Icons.calendar_today),
              //       onPressed: () => _selectPublishedDate(context),
              //     ),
              //   ],
              // ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
