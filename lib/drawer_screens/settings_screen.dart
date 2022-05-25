import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/components/constant.dart';
import 'package:library_app/components/global_componnets.dart';
import 'package:library_app/components/my_drawer.dart';

import '../shared/local/cache_helper.dart';
import 'home_screen/cubit/home_cubit.dart';




class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool _switchValue=true;


  @override
  Widget build(BuildContext context) {
    LibraryCubit cubit = LibraryCubit.get(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child:  Scaffold(
        backgroundColor: primaryColor,
        drawer: MyDrawer(),
        body: SafeArea(
          child: Column(
            children: [


              SizedBox(
                height: (MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top)*0.25,
                child: LayoutBuilder(
                  builder: (ctx,constraint)
                  =>Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: constraint.maxHeight*0.3,

                        child: Row(
                          children: [
                            Builder(
                              builder: (BuildContext ctx) {
                                return IconButton(
                                  icon: CircleAvatar(
                                    backgroundColor:
                                    Colors.grey.shade100.withOpacity(0.3),
                                    child: Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    Scaffold.of(ctx).openDrawer();
                                  },
                                  tooltip: MaterialLocalizations.of(context)
                                      .openAppDrawerTooltip,
                                );
                              },
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Image.network("${cubit.appModel.app.logo}", width:  170,height: constraint.maxHeight*0.7,),
                    ],
                  ),
                ),
              ),





              Container(
                width: double.infinity,
                height: (MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top)*0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [

                    SizedBox(height: 60,),

                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 2.0, // has the effect of softening the shadow
                              spreadRadius: 2.0, // has the effect of extending the shadow
                              offset: Offset(0, // horizontal, move right 10
                                5.0, // vertical, move down 10
                              ),
                            )
                          ],
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              myText(
                                  "الوضع المظلم",
                                  14,
                                  FontWeight.w300
                              ),

                              CupertinoSwitch(
                                value: _switchValue,
                                onChanged: (value)async {

                                  setState(() {
                                    _switchValue = value;
                                  });
                                },
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


              ),
            ],
          ),
        ),

      ),
    );
  }
}
