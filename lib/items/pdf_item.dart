import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:library_app/components/constant.dart';
import 'package:library_app/components/global_componnets.dart';
import 'package:library_app/dummy_data/pdf_files_datd.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../models/result_model.dart';
import '../next_screen.dart';

class PdfItem extends StatefulWidget {

  final   pdf;

  PdfItem(this.pdf);



  @override
  _PdfItemState createState() => _PdfItemState();
}

class _PdfItemState extends State<PdfItem> {




  void _viewFile() async {
    final _url =
        widget.pdf.fileLink;
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {

    }
  }




  int counter=0;

 final _prefs = SharedPreferences.getInstance();
  DateTime initDate;
  var resultDate;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();


  }



  @override
  Widget build(BuildContext context) {
    void _viewFile2() async {
      final SharedPreferences prefs = await _prefs;
      var secoundDate=DateTime.parse( prefs.getString('date'));
      resultDate = DateTime.now().difference(secoundDate).inSeconds.toInt();

      print('      هدااااااااا الوقت بالدقائق  $resultDate');

      if(counter<3){
        print('conter$counter');
        final _url =
            'http://www.africau.edu/images/default/sample.pdf';
        if (await canLaunch(_url)) {
          await launch(_url);
        } else {
          print('Something went wrong');
        }
        if(resultDate>30)
          setState(() {
            counter=counter+1;
          });
        print(' $counter هداااااااااااااااا الكونتر ');

      }
      else {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  NextScreen()),
        ).then((value)async {
          await  prefs.setString('date', DateTime.now().toIso8601String());
          print('تم التخزيييييييييييييييييييين');
          var now=DateTime.parse( prefs.getString('date'));
          String formattedTime = DateFormat.Hm().format(now);
          counter=0;
          resultDate=0;
          print(now);


        });
      }

    }

    return Column(
      children: [


        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10).add(EdgeInsets.only(top: 8 , bottom: 2)),
          child: Column(
            children: [

              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: 70.0,
                      maxHeight: 170.0,
                    ),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,

                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
                      child: SizedBox(
                        width: 400,
                        child: myText(
                            widget.pdf.name,
                            13,
                            FontWeight.w400

                        ),
                      ),
                    ),),

                  widget.pdf.isNew ?    Transform.rotate(
                    angle:0, //set the angel
                    child: ClipPath(
                      clipper: CustomTriangleClipper(),
                      child: Container(
                        alignment: Alignment.topRight,
                        width: 50,
                        height: 50,
                        color: Colors.green,
                        child: Transform.rotate(
                          angle: 170.4,

                          child:  Text(

                            "جديد",
                            style:  GoogleFonts.cairo(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ) : Container(),

                ],
              ),

              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),

                    )
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myPdfRowItem(
                          "تحميل",
                          Icon(Icons.arrow_circle_down , color: Colors.white,),
                              (){
                            showDialog(
                              context: context,
                              // barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),

                                  ),
                                  title : myText(
                                    "هل تريد بالتأكيد حفظ الملف ؟ ",
                                    14,
                                    FontWeight.w400,
                                  ),
                                  actions: <Widget>[

                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child:   Text(
                                        "إغلاق",
                                        style:  GoogleFonts.cairo(
                                          fontSize: 13.sp,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),

                                    TextButton(
                                      onPressed:()=> _viewFile2,
                                      child:  Text(
                                        "تنزيل",
                                        style:  GoogleFonts.cairo(
                                          fontSize: 13.sp,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );


                          }
                      ),

                      myPdfRowItem(
                        "مشاركة",
                        Icon(Icons.share , color: Colors.white,),
                        
                        ()async{
                          var readLines = ['${widget.pdf.name}', ' ${widget.pdf.appLink}'];
                          String getNewLineString() {
                            StringBuffer sb =  StringBuffer();
                            for (String line in readLines) {
                              sb.write(line + "\n");
                            }
                            return sb.toString();
                          }
                          if(widget.pdf.name.isNotEmpty){
                            await Share.share(getNewLineString());
                            
                          }
                        },
                      ),


                    ],
                  ),
                ),
              ),

            ],
          ),
        ),

      ],
    );
  }
}



class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

/*


Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(0, 7),
                blurRadius: 5.0,
                spreadRadius: 0),
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: Offset(5, 0),
                blurRadius:3.0,
                spreadRadius: 0),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Icon(
                Icons.download_outlined,
                color: Colors.black,
              ),
              SizedBox(
                width: 5.w,
              ),

              CircleAvatar(
                child: myText("200", 14, FontWeight.w600),
                backgroundColor: Colors.grey.shade300.withOpacity(0.5),
              ),

              SizedBox(width: 10,),

              SizedBox(
                width: 230.w,
                child:  myText(
                    "مذكرة لغة عربية مستر محمد صلاح شرح و تدريبات",
                    12,
                    FontWeight.w600
                ),
              ),

            ],
          ),
        ),
      ),
 */