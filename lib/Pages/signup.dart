import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmdd_application/Widget/bezierContainer.dart';
import 'package:rmdd_application/Pages/loginPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:cool_alert/cool_alert.dart';
class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  StreamSubscription<DataConnectionStatus> listener;
   @override
  void dispose(){
    listener.cancel();
    super.dispose();
  }
  checkInternet()async{
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    print("Last results: ${DataConnectionChecker().lastTryResults}");
     listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case DataConnectionStatus.disconnected:
         showToast('You are disconnected from the internet.',
              context: context,
              animation: StyledToastAnimation.fade,
              curve: Curves.linear,
              reverseCurve: Curves.linear);
        
          print('You are disconnected from the internet.');
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
   // await Future.delayed(Duration(seconds: 30));
    return await DataConnectionChecker().connectionStatus;


  }

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passWordController = new TextEditingController();

  Future sendData() async {
     DataConnectionStatus status = await checkInternet();
     if(status == DataConnectionStatus.connected){
       final url =
    Uri.parse("http://devotion.banjoadedokunandco.com/api/registration.php");
    var request = http.MultipartRequest('POST',url);
    request.fields['firstname'] = firstNameController.text;
    request.fields['lastname'] = lastNameController.text;
    request.fields['email'] = emailController.text;
    request.fields['phone'] = phoneController.text;
    request.fields['username'] = userNameController.text;
    request.fields['password'] = passWordController.text;
    var response = await request.send();
    if(response.statusCode == 200){
     CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Registration Successful!",
        );
          
    }else{
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Oops...",
          text: "Sorry, Something went wrong",
        );
    }

     }else if(status == DataConnectionStatus.disconnected){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("No Internet", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold ),),
            content: Text("Pls Check Your Internet And Try Again", style: TextStyle(color: Colors.red),),
            elevation: 10,
            backgroundColor: Colors.white,

          )
      );
     }
    

  }



  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }





  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'R',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.bodyText1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'M',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'DD',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          fillColor: Colors.deepOrangeAccent,
                          prefixIcon: Icon(Icons.person, color: Colors.deepOrangeAccent,),
                          border: OutlineInputBorder(),
                          labelText: 'First Name',
                          hintText: 'Enter Your First Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.all(15),
                      child: TextField(
                        controller:lastNameController,
                        decoration: InputDecoration(
                          fillColor: Colors.deepOrange,
                          prefixIcon: Icon(Icons.person_outline_outlined, color: Colors.deepOrange,),
                          border: OutlineInputBorder(),
                          labelText: 'Last Name',
                          hintText: 'Enter Your Last Name'
                        ),
                      ),
                    ),

                    Padding(
                      padding:EdgeInsets.all(15),
                      child: TextField(
                        controller:emailController,
                        decoration: InputDecoration(
                            fillColor: Colors.deepOrange,
                            prefixIcon: Icon(Icons.email, color: Colors.deepOrange,),
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter Your Last Name'
                        ),
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.all(15),
                      child: TextField(
                        obscureText: false,
                        controller:phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Colors.deepOrange,
                          prefixIcon: Icon(Icons.vpn_key_outlined, color: Colors.deepOrange,),
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                          hintText: 'Enter Your Phone Number',

                        ),
                      ),
                    ),

                    Padding(
                      padding:EdgeInsets.all(15),
                      child: TextField(
                        controller:userNameController,
                        decoration: InputDecoration(
                            fillColor: Colors.deepOrange,
                            prefixIcon: Icon(Icons.person_pin_sharp, color: Colors.deepOrange,),
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                            hintText: 'Enter Your User Name'
                        ),
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.all(15),
                      child: TextField(
                        obscureText: true,
                        controller:passWordController,
                        decoration: InputDecoration(
                            fillColor: Colors.deepOrange,
                            prefixIcon: Icon(Icons.vpn_key_outlined, color: Colors.deepOrange,),
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter Your Password',

                        ),
                      ),
                    ),


                    FlatButton(
                      onPressed: (){
                        if(firstNameController.text.isEmpty){
                              showToast(
                          'Enter Your Firstname',
                          context: context,
                          animation: StyledToastAnimation.fade,
                          curve: Curves.linear,
                          reverseCurve: Curves.linear);   
                        }else if(lastNameController.text.isEmpty){
                             showToast(
                          'Enter Your Lastname',
                          context: context,
                          animation: StyledToastAnimation.fade,
                          curve: Curves.linear,
                          reverseCurve: Curves.linear);   
                           

                        }else if(emailController.text.isEmpty){
                             showToast(
                          'Enter Your Email Address',
                          context: context,
                          animation: StyledToastAnimation.fade,
                          curve: Curves.linear,
                          reverseCurve: Curves.linear);   

                        }else if(phoneController.text.isEmpty){
                            showToast(
                          'Enter Your Phone',
                          context: context,
                          animation: StyledToastAnimation.fade,
                          curve: Curves.linear,
                          reverseCurve: Curves.linear);   

                        }else if(userNameController.text.isEmpty){
                             showToast(
                          'Enter Your Username',
                          context: context,
                          animation: StyledToastAnimation.fade,
                          curve: Curves.linear,
                          reverseCurve: Curves.linear);   

                        }else if(passWordController.text.isEmpty){
                            showToast(
                          'Enter Your Password',
                          context: context,
                          animation: StyledToastAnimation.fade,
                          curve: Curves.linear,
                          reverseCurve: Curves.linear);   

                        }else{
                           sendData();

                        }
                       

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: Offset(2, 4),
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ],
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
                        child: Text(
                          'Register Now',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
