import 'package:flutter/material.dart';
import 'package:metatube/service/file_service.dart';
import 'package:metatube/utils/app_theme.dart';
import 'package:metatube/widgets/custom_text_filed.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FileService fileService = FileService();

  @override
  void initState() {
    super.initState();
    addListeners();
  }

  void addListeners() {
    List<TextEditingController> controllers = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagsController,
    ];

    for (TextEditingController controller in controllers) {
      controller.addListener(onFieldsChange);
    }
  }

  onFieldsChange() {
    setState(() {
      fileService.fieldsNotEmpty =
          fileService.titleController.text.isNotEmpty &&
              fileService.descriptionController.text.isNotEmpty &&
              fileService.tagsController.text.isNotEmpty;
    });
  }
  removeListeners(){
    List<TextEditingController> controllers = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagsController,
    ];

    for (TextEditingController controller in controllers) {
      controller.removeListener(onFieldsChange);
    }
  }
  @override
  void dispose() {
    removeListeners();
    super.dispose();
  }
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _button(() =>fileService.newFile(context), "New File"),
                Row(
                  children: [
                    _iconButon(() =>fileService.uploadFile(context), Icons.upload),
                    _iconButon(() =>fileService.selectNewFolder(context), Icons.folder),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            CustomTextField(
              hintText: "Enter Video Title",
              maxLength: 100,
              maxLine: 3,
              controller: fileService.titleController,
            ),
            const SizedBox(
              height: 40,
            ),
            CustomTextField(
              hintText: "Enter Video Description",
              maxLength: 5000,
              maxLine: 5,
              controller: fileService.descriptionController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: "Enter Video Tags",
              maxLength: 300,
              maxLine: 4,
              controller: fileService.tagsController,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _button(fileService.fieldsNotEmpty?() =>fileService.saveFile(context):null, "Save File"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _button(Function()? function, String text) {
    return ElevatedButton(
      onPressed: function,
      style: AppTheme.elevatedButtonStyle,
      child: Text(text),
    );
  }

  _iconButon(Function()? function, IconData icon) {
    return IconButton(
      onPressed: function,
      color: AppTheme.medium,
      splashRadius: 20,
      splashColor: AppTheme.accent,
      iconSize: 20,
      icon: Icon(icon),
    );
  }
}
