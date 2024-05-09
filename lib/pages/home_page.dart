import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:client/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/note_model.dart';
import '../my_app/setup.dart';
import 'new_note_page.dart';
import 'note_page.dart';

class HomePage extends StatefulWidget {
  File? file;
  HomePage({super.key, this.file});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isImageSelected = false;

  Widget cardDesign(
      {required String title, required String subtitle, String? path, required int index}) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotePage(index: index)));
            },
            autoClose: false,
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "Edit",
            borderRadius: BorderRadius.circular(20),
          ),
          SlidableAction(
            onPressed: (context) async {
              index += 1;
              bool a = await HttpService.delete(index: index);
              if(a){
                String? data = await HttpService.getData();
                noteList = List<NoteModel>.from(jsonDecode(data!).map((e)=>NoteModel.fromJson(e)));
                setState(() {});
              }else{
                log("false");
              }
            },
            autoClose: false,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete",
            borderRadius: BorderRadius.circular(20),
          )
        ],
      ),
      child: GestureDetector(
        child: Card(
          color: Colors.white,
          child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: Text(DateFormat.yMMMd().add_jms().format(noteList[index].dateTime)),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Note App"),
        titleTextStyle: const TextStyle(
            fontSize: 24, color: Colors.black
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          noteList.isEmpty
              ? Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 400),
              child: Text(
                "You do not have any notes yet",
                style: GoogleFonts.quicksand(
                    fontSize: 24, color: Colors.black),
              ),
            ),
          )
              : Expanded(
            child: ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                return cardDesign(
                    title: noteList[index].title,
                    subtitle: noteList[index].text,
                    index: index
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewNotePage()));
          },
          child: Text(
            "+",
            style: GoogleFonts.quicksand(fontSize: 28),
          )),
    );
  }

}



