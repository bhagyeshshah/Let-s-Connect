// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_connect/utils/lc_permission_utils.dart';
import 'package:lets_connect/utils/translation_service.dart';
import 'package:path/path.dart' as path;


class LcImagePicker{
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickUpImageFile(BuildContext context, String? name) async{
    bool allow = await LcPermissionUtils.validateFilePickerPermission(context: context);
    if(!allow){
      return null;
    }
    File? file;
    String result = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => const FileSelectionDialogBody(),
    );
    if(result == translationService.text('key_camera')){
      file = await _pickImageFile(name: name);
    }

    else if(result == translationService.text('key_gallery')){
      file = await _pickImageFile(source: ImageSource.gallery, name: name);
    }
    return file;
  }

  static Future<File?> _pickImageFile({bool isVideo = false, ImageSource source = ImageSource.camera, String? name})async{
      XFile? pickedFile;
      if(isVideo){
        pickedFile = await _picker.pickVideo(source: source);
      }
      else{
        pickedFile = await _picker.pickImage(source: source);
      }
      if (pickedFile != null) {
        String finalPath = _getFinalFilePath(pickedFile: pickedFile);
        var renameFile = File(pickedFile.path).renameSync(finalPath);
        File file = File(renameFile.path);
        return file;
      }
      return null;
    }

  static String _getFinalFilePath({required XFile pickedFile, String? name}) {
    final String dir = path.dirname(pickedFile.path);
    final String extension = path.extension(pickedFile.path);
    return path.join(dir, '${name ?? DateTime.now().millisecondsSinceEpoch}_image$extension');
  }
}

class FileSelectionDialogBody extends StatefulWidget {
  const FileSelectionDialogBody({super.key});

  @override
  State<FileSelectionDialogBody> createState() => _FileSelectionDialogBodyState();
}

class _FileSelectionDialogBodyState extends State<FileSelectionDialogBody> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor
        ),
        child: Column(
           mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildItem(title: translationService.text('key_camera')!),
            // _buildItem(title: translationService.text('key_video')!),
            _buildItem(title: translationService.text('key_gallery')!),
            // _buildItem(title: translationService.text('key_files')!),
            _buildItem(title: translationService.text('key_cancel')!),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({required String title}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).maybePop(title);
        },
        child: Text(
          title
        ),
      ),
    );
  }
}