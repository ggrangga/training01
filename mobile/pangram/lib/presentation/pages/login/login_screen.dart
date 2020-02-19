import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_app/presentation/mixins/validation_mixin.dart';
import 'package:demo_app/common/routes/routes.dart';
import 'package:demo_app/presentation/pages/login/blocs/bloc.dart';
import 'package:demo_app/presentation/pages/login/blocs/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  createState(){
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  bool isValid = true;
  Bloc loginBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loginBloc = Provider.instance.loginBloc(true);
  }

  @override
  Widget build(context) {
   
    return new Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(  
          child: Column(
            children: <Widget>[
              Form(
                child: Column(
                  children: [
                    Container(margin: EdgeInsets.only(bottom: 200.0)),
                    nameFIeld(loginBloc),
                    loginFIeld(loginBloc),
                    Container(margin: EdgeInsets.only(bottom: 25.0)),
                    submitButton(loginBloc),
                  ],
                ),
              ),
            ]
          )
        )
      )
    );
  }

  Widget nameFIeld(Bloc bloc){
    return StreamBuilder(
      stream: bloc.name,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: bloc.changeName,
          decoration: InputDecoration(
            hintText: 'Fill your name!',
          ),
        );
      },
    );
  }

  Widget loginFIeld(Bloc bloc){
    return StreamBuilder(
      stream: bloc.token,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: bloc.changeToken,
          decoration: InputDecoration(
            hintText: 'Token from omdbapi.com',
            errorText: isValid ? snapshot.error : "Incorrect token!",
          ),
        );
      },
    );
  }
  
  Widget submitButton(Bloc bloc){
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Login!'),
          onPressed: snapshot.hasData ? () async {
            isValid = await bloc.submitLogin();
           
            if(isValid){
              SharedPreferences prefs = await SharedPreferences.getInstance();
              bloc.token.listen((value) {
                prefs.setString('token', value);
              });
                        
              Navigator.of(context).pushNamed(Routes.dashboard,
                    arguments: 'Go to => Dashboard');
            }else
               setState(() {isValid = isValid;});
            
          } : null,
        );
      },
    );
  }

  @override void dispose() {
    loginBloc.dispose();
    super.dispose();
  }
}