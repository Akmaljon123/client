import 'dart:convert';
import 'dart:io';
import 'package:client/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../designs/note_page_design.dart';
import '../models/note_model.dart';
import '../my_app/setup.dart';
import 'home_page.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  late TextEditingController titleController;
  late TextEditingController textController;
  bool isCamera = false;
  bool isImageSelected = false;
  File? file;

  Future<void> createData({required NoteModel noteModel})async{
    String? data = await HttpService.post(data: noteModel.toJson());

    if(data!=null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey.shade400.withOpacity(0.975),
          content: const Text("Successfully created", style: TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center,),
          duration: const Duration(milliseconds: 2500),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          shape: const StadiumBorder(),
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey.shade400.withOpacity(0.975),
          content: const Text("Something went wrong", style: TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center,),
          duration: const Duration(milliseconds: 2500),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          shape: const StadiumBorder(),
        ),
      );
    }
  }

  @override
  void initState() {
    titleController = TextEditingController();
    textController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create a note"),
        centerTitle: true,
        titleTextStyle: GoogleFonts.quicksand(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w700
        ),
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context)=> HomePage()
                  ),
                      (route) => false
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: GestureDetector(
              onTap: ()async{
                NoteModel noteModel = NoteModel(
                  title: titleController.text,
                  text: textController.text,
                  dateTime: DateTime.now()
                );

                await createData(noteModel: noteModel);

                String? data = await HttpService.getData();
                if(data!=null){
                  noteList = List<NoteModel>.from(jsonDecode(data).map((e)=>NoteModel.fromJson(e)));
                }

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context)=> HomePage(file: file,)
                    ),
                    (route)=>false
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: const Icon(
                  Icons.save,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: NotePageDesign.textFormField(
                  controller: titleController,
                  cursorHeight: 40,
                  cursorColor: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  hintText: "Title"
              )
            ),
        
            Padding(
              padding: const EdgeInsets.only(bottom: 470, left: 40),
              child: NotePageDesign.textFormField(
                  controller: textController,
                  cursorHeight: 30,
                  cursorColor: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  hintText: "Your notes here"
              )
            ),
          ],
        ),
      ),
    );
  }
}
