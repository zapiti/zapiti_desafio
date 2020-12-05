import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/component/appbar/app_bar_custom.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_date_time.dart';
import 'package:zapiti_desafio/app/component/load/load_elements.dart';
import 'package:zapiti_desafio/app/component/select/select_button.dart';
import 'package:zapiti_desafio/app/component/textfield/custom_grey_textfield.dart';
import 'package:zapiti_desafio/app/models/pairs.dart';
import 'package:zapiti_desafio/app/routes/constants_routes.dart';
import 'package:zapiti_desafio/app/utils/date_utils.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

import '../../login_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final bloc = Modular.get<LoginBloc>();

  bool _loading = false;
  FocusNode myFocusNode;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        AppBarCustom("Cadastra"),
        Expanded(
            child: SingleChildScrollView(
          child: StreamBuilder(
              stream: bloc.isLoad,
              initialData: false,
              builder: (context, snapshot) {
                var _isLoadRequest = snapshot.data;
                return Column(
                  children: [
                    StreamBuilder<String>(stream: bloc.erroNameView,builder: (context,snapshotName)=>     Container(
                        margin: EdgeInsets.only(
                            right: 30, left: 30, top: 30, bottom: 5),
                        child: CustomGreyTextField(
                          enabled: !_isLoadRequest,
                          obscureText: false,
                          labelText: "Nome",errorText: snapshotName.data,onChanged: (text){
                          bloc.erroNameView.sink.add(null);
                        },
                          controller: bloc.nameController,
                          prefixIcon: Icon(
                            Icons.person,
                            size: 18,
                            color: AppThemeUtils.colorPrimary,
                          ),
                        ))),
                    StreamBuilder<String>(stream: bloc.erroEmailView,builder: (context,snapshotEmail)=>    Container(
                        margin: EdgeInsets.only(
                            right: 30, left: 30, top: 5, bottom: 5),
                        child: CustomGreyTextField(
                          enabled: !_isLoadRequest,
                          obscureText: false,
                          labelText: "E-mail",errorText: snapshotEmail.data,onChanged: (text){
                          bloc.erroEmailView.sink.add(null);
                        },
                          controller: bloc.emailController,
                          prefixIcon: Icon(
                            Icons.email,
                            size: 18,
                            color: AppThemeUtils.colorPrimary,
                          ),
                        ))),


                    StreamBuilder<String>(stream: bloc.erroPassView,builder: (context,snapshotPass)=>         Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: StreamBuilder<bool>(
                            stream: bloc.showPass.stream,
                            initialData: false,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshotHide) {
                              return Container(
                                  child: Card(
                                      color: AppThemeUtils.colorsGrey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        const BorderRadius.all(
                                          Radius.circular(18.0),
                                        ),
                                      ),
                                      child: TextField(
                                        enabled: !_isLoadRequest,
                                        obscureText: snapshotHide.data,
                                        decoration: InputDecoration(
                                          labelText: "Senha",
                                          errorText: snapshotPass.data,
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            size: 18,
                                            color: AppThemeUtils
                                                .colorPrimary,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              snapshotHide.data
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: AppThemeUtils
                                                  .colorPrimaryDark,
                                            ),
                                            onPressed: () {
                                              bloc.showPass.sink.add(
                                                  !snapshotHide.data);
                                            },
                                          ),
                                        ),
                                        onChanged: (text) {
                                          bloc.erroPassView.sink
                                              .add(null);
                                        },
                                        controller: bloc.passController,
                                      )));
                            }))),

                    _isLoadRequest
                        ? loadElements(context)
                        : Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: SizedBox(
                              width: 150,height: 45,
                              child: RaisedButton(
                                padding: EdgeInsets.all(5),
                                color: AppThemeUtils.colorPrimary80,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  "Cadastrar",
                                  style: AppThemeUtils.normalSize(
                                      color: AppThemeUtils.whiteColor),
                                ),
                                onPressed: () {
                                  bloc.signup(context);
                                },
                              ),
                            ),
                          ),
                    Container(
                        margin:EdgeInsets.only(
                            right: 30, left: 30, top: 5, bottom: 55),
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                            onPressed: () {
                              Modular.to.pushNamed(ConstantsRoutes.LOGIN_PAGE);
                            },
                            child: Text(
                              "Já possui acesso?!",
                              style: AppThemeUtils.smallSize(),
                            ))),
                  ],
                );
              }),
        ))
      ],
    ));
  }
}

//           Expanded(
//               child: SingleChildScrollView(
//             child: StreamBuilder(
//                 stream: bloc.isLoad,
//                 initialData: false,
//                 builder: (context, snapshot) {
//                   var _isLoadRequest = snapshot.data;
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 15.0),
//                     child: Form(
//                         key  : _formkey,
//                         child : Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             SizedBox(height: 5.0),
//                             TextFormField(
//                               controller: bloc.nameController,
//                               validator:(input){
//                                 if(input.isEmpty){
//                                   return 'Please Enter Name';
//                                 }
//                                 else{
//                                   return null;
//                                 }
//                               },
//                               onTap: () {
//                                 FocusScopeNode currentFocus = FocusScope.of(context);
//                                 if (!currentFocus.hasPrimaryFocus) {
//                                   currentFocus.unfocus();
//                                 }
//                               },
//                             //  onSaved: (input)=> _name = input,
//                               decoration: InputDecoration(
//                                 labelText: 'Name',
//                               ),
//                             ),
//
//                             SizedBox(height: 10),
//                             TextFormField(
//                               focusNode: myFocusNode,controller: bloc.emailController,
//                               onTap: () {
//                                 FocusScopeNode currentFocus = FocusScope.of(context);
//                                 if (!currentFocus.hasPrimaryFocus) {
//                                   currentFocus.unfocus();
//                                 }
//                               },
//                               validator:(input){
//                                 if(input.isEmpty){
//                                   return 'Please type a Email';
//                                 }
//                                 else{
//                                   Pattern pattern =r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                                   RegExp regex = RegExp(pattern);
//                                   if(!regex.hasMatch(input))
//                                     return 'Enter valid Email';
//                                   else
//                                     return null;
//                                 }
//                               },
//                             //  onSaved: (input)=> _email = input,
//                               decoration: InputDecoration(
//                                 labelText: 'Email',
//                                 //   focusedBorder: UnderlineInputBorder(
//                                 //     borderSide: BorderSide(color: Colors.green)),
//                               ),
//                               keyboardType: TextInputType.emailAddress,
//                             ),
//                             SizedBox(height: 5.0),
//                             TextFormField(controller: bloc.passController,
//                               validator:(input){
//                                 if(input.length < 6 ){
//                                   return 'Your password needs to be atleast 6 characters';
//                                 }
//                                 else{
//                                   return null;
//                                 }
//                               },
//                               onTap: () {
//                                 FocusScopeNode currentFocus = FocusScope.of(context);
//                                 if (!currentFocus.hasPrimaryFocus) {
//                                   currentFocus.unfocus();
//                                 }
//                               },
//                              // onSaved: (input)=> _password = input,
//                               decoration: InputDecoration(
//                                 labelText: 'Password',
//                               ),
//                               obscureText: true,
//                             ),
//
//                             SizedBox(height: 20.0),
//                          _loading ?loadElements(context):   Container(
//                               height: 45.0,
//                               width: 150,
//                               child: Material(
//                                 borderRadius: BorderRadius.circular(22.0),
//                                 shadowColor: Colors.tealAccent,
//                                 color: Colors.teal,
//                                 elevation: 7.0,
//                                 child: GestureDetector(
//                                   onTap: (){
//                                     bloc.signup(context,_formkey);
//                                   },
//                                   child: Center(
//                                     child: Text(
//                                       'SIGN UP',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 15.0),
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Text(
//                                   'Already have an Account ?',
//                                 ),
//                                 SizedBox(width: 7.0),
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text(
//                                     'Login',
//                                     style: TextStyle(
//                                         color: Colors.teal,
//                                         fontWeight: FontWeight.bold,
//                                         decoration: TextDecoration.underline
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             )
//                           ],
//                         )
//                     ),
//                   );
//                 }),
//           ))
//         ],
//       ),
//     );
//   }
// }
