import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/components/CustomButton.dart';
import 'package:rebio/components/CustomTextField.dart';
import 'package:rebio/theme/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Filltodo extends StatefulWidget {
  const Filltodo({super.key});

  @override
  State<Filltodo> createState() => _FilltodoState();
}

class _FilltodoState extends State<Filltodo> {
  String? _selectedImage;
  final taskTitleController = TextEditingController();
  final taskDetailsController = TextEditingController();
  int? points;
  bool enableEditingTaskTitle = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      if (args.containsKey('taskTitle')) enableEditingTaskTitle = false;
      taskTitleController.text = (args['taskTitle'] as String?) ?? "";
      points = args['points'] as int?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(top: 64.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Made an ", style: GoogleFonts.notoSans(fontSize: 24, fontWeight: FontWeight.w600)),
                  Text("impact", style: GoogleFonts.notoSans(fontSize: 24, fontWeight: FontWeight.w700, color: primary)),
                  Text(" today?", style: GoogleFonts.notoSans(fontSize: 24, fontWeight: FontWeight.w600)),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 64.0, right: 64.0),
                  child: Text("Let's take a minute to tell others what you contributed!", style: GoogleFonts.notoSans(fontSize: 16), textAlign: TextAlign.center,)
                )
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: 8.0)),
                    SizedBox(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            )
                          ]
                        ),
                        
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [            
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text("1", style: GoogleFonts.notoSans(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8.0)),
                                  Text(
                                    "Task Information",
                                    style: GoogleFonts.notoSans(fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              CustomTextInput(label: "Task Title", hintText: "What did you do today?", controller: taskTitleController, enabled: enableEditingTaskTitle),
                              SizedBox(height: 16),
                              CustomTextInput(label: "Task Details", hintText: "Tell us in detail what you have done today ...", controller: taskDetailsController, maxLines: 4),  
                            ],
                          ),
                        ),
                      )
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 32.0)),
                    SizedBox(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            )
                          ]
                        ),
                        
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text("2", style: GoogleFonts.notoSans(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8.0)),
                                  Text(
                                    "Attachment",
                                    style: GoogleFonts.notoSans(fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Show your work, upload a picture of your action!",
                                style: GoogleFonts.notoSans(fontSize: 14, color: Colors.grey.withValues(alpha: 1.0)),
                              ),
                              SizedBox(height: 6),
                              GestureDetector(
                                onTap: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  setState(() {
                                    _selectedImage = pickedFile.path;
                                  });
                                }
                              },
                              child: Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey.withValues(alpha: 0.5)),
                                ),
                                child: _selectedImage == null
                                ? Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add_a_photo, color: primary),
                                        SizedBox(width: 8),
                                        Text(
                                          "Upload Image",
                                          style: GoogleFonts.notoSans(color: primary),
                                        ),
                                      ],
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(_selectedImage!),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 120,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 32.0)),
                    CustomButton(
                      text: "Submit your work", 
                      onPressed: () {
                        Navigator.pop(context);
                      }
                    )
                  ]
                )
              )
            ]
          )
        )
      ),
    );
  }
}