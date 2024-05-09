import 'dart:convert';
import 'package:client/services/http_service.dart';
import 'package:flutter/cupertino.dart';
import '../models/note_model.dart';

List<NoteModel> noteList = [];

Future<void> setup()async{
  WidgetsFlutterBinding.ensureInitialized();
  // noteList = await HiveService.getData();

  String? data = await HttpService.getData();
  if(data!=null){
    noteList = List<NoteModel>.from(jsonDecode(data).map((e)=>NoteModel.fromJson(e)));
  }
}