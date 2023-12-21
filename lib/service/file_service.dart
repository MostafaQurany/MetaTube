import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metatube/utils/snack_bar_utils.dart';


class FileService{
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

  bool fieldsNotEmpty = false;



  // make the new save the file step
  /*
  * 1- make the field that will use
  * 2- make the function that will save the file
  * --- the function will be with to scenario
  *     1- if we on a fill so we will write the file
  *     2- if we don't have a file, we will get the dir then create new one   */

  File? _selectedFile ;
  String _selectedFileDir = "";


  void saveFile(BuildContext context)async  {
    final title = titleController.text;
    final description = descriptionController.text;
    final tags = tagsController.text;
    final content = "Title:\n\n$title\n\nDescription:\n\n$description\n\nTags:\n\n$tags";

    try{
      if(_selectedFile!=null){
        await _selectedFile!.writeAsString(content);
      }else{
        final toDayDate = getToDayDate();
        String metatubeDirPath = _selectedFileDir;
        if(metatubeDirPath.isEmpty){
          final director = await FilePicker.platform.getDirectoryPath();
          _selectedFileDir = metatubeDirPath = director!;
        }
        final filePath = '$metatubeDirPath\\{$toDayDate} - $title - metaTube.txt';
        final newFile = File(filePath);
        await newFile.writeAsString(content);
      }
      SnakeBarUtils.showSnakBar(context, Icons.check_circle, "File Saved Successfully");

    }catch(e){
      SnakeBarUtils.showSnakBar(context, Icons.error_rounded, "File Not Saved");

    }

  }


  // upload the file
  /*
  * 1-  get the file
  * 2- check if the file is not null
  * 3- get the contented
  * 4- set values to the controllers
  * */

  void uploadFile(BuildContext context)async {
    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if(result != null){
        _selectedFile = File(result.files.first.path!);
        final content = await _selectedFile!.readAsString();
        final liens = content.split("\n\n");
        titleController.text=liens[1];
        descriptionController.text=liens[3];
        tagsController.text=liens[5];
        SnakeBarUtils.showSnakBar(context, Icons.upload_file, "File uploading");

      }
      else{
        SnakeBarUtils.showSnakBar(context, Icons.error, "No Selected File");
      }
    }
    catch(e){
      SnakeBarUtils.showSnakBar(context, Icons.error, "No Selected File");
    }

  }

  // create a new file is to clear all the data

  void newFile(BuildContext context) async{
    _selectedFile = null ;
    titleController.clear();
    descriptionController.clear();
    tagsController.clear();
    SnakeBarUtils.showSnakBar(context, Icons.cleaning_services_outlined, "New File Ready");
  }

  // select the new folder

  void selectNewFolder(BuildContext context)async{
    try{
      _selectedFile = null;
      String? directory = await FilePicker.platform.getDirectoryPath();
      _selectedFileDir = directory!;
      SnakeBarUtils.showSnakBar(context, Icons.folder, "Folder selected");
    }catch(e){
      SnakeBarUtils.showSnakBar(context, Icons.error, "No Folder selected");

    }
  }
  String getToDayDate(){
    final date = DateTime.now();
    final formatter = DateFormat("yyyy-MM-dd");
    final formattedDate = formatter.format(date);
    return formattedDate;
  }
}