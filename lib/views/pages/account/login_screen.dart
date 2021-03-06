import 'package:flutter/material.dart';
import 'package:softify/bloc/auth_bloc.dart';
import 'package:softify/views/customWidget/CustomAppBar.dart';
import 'package:softify/views/customWidget/CustomButton.dart';
import 'package:softify/views/customWidget/loading_dialog.dart';
import 'package:softify/views/customWidget/error.dart';
import 'package:softify/views/customWidget/loading.dart';
import 'package:softify/model/LoginFormResponse.dart';
import 'package:softify/networking/ApiResponse.dart';
import 'package:softify/views/pages/account/forgot_password_screen.dart';
import 'package:softify/views/pages/account/registration_sceen.dart';
import 'package:softify/service/GlobalService.dart';
import 'package:softify/utils/AppConstants.dart';
import 'package:softify/utils/ButtonShape.dart';
import 'package:softify/utils/Const.dart';
import 'package:softify/utils/ValidationMixin.dart';
import 'package:softify/utils/shared_pref.dart';
import 'package:softify/utils/styles.dart';
import 'package:softify/utils/utility.dart';
import 'package:softify/views/pages/examSchedule/exam_schedule.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  GlobalService _globalService = GlobalService();
  AuthBloc _bloc;
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
    removeFocusFromInputField(context);
  }

  @override
  void initState() {
    super.initState();

    _bloc = AuthBloc();
    _bloc.fetchLoginFormData();

    _bloc.loginResponseStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        // save user session & goto home
        var session = SessionData();
        session
            .setUserSession(event.data.token, event.data.customerInfo)
            .then((value) {
          DialogBuilder(context).hideLoader();
          Navigator.of(context).pushNamedAndRemoveUntil('/', (r) => false);
        });
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, event.message, true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          _globalService.getString(Const.ACCOUNT_LOGIN),
          style: Theme.of(context).appBarTheme.textTheme.headline6,
        ),
      ),
      body: StreamBuilder<ApiResponse<LoginFormData>>(
        stream: _bloc.loginFormStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                return rootLayout(snapshot.data.data);
                break;
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () => _bloc.fetchLoginFormData(),
                );
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget rootLayout(LoginFormData formData) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (value) {
        if (!formData.usernamesEnabled &&
            (value == null || value.isEmpty || !isValidEmailAddress(value))) {
          return _globalService.getString(Const.LOGIN_EMAIL_REQ);
        }
        return null;
      },
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            color: Styles.textColor(context),
            fontSize: 16,
          ),
      onChanged: (value) => formData.email = value,
      decoration: InputDecoration(
          hintText: _globalService.getString(Const.LOGIN_EMAIL),
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, -5.0),
          suffixIcon: Icon(Icons.email_outlined)),
      textInputAction: TextInputAction.next,
    );

    final username = TextFormField(
      keyboardType: TextInputType.name,
      autofocus: false,
      validator: (value) {
        if (formData.usernamesEnabled && (value == null || value.isEmpty)) {
          return _globalService.getString(Const.USERNAME) +
              " " +
              _globalService.getString(Const.IS_REQUIRED);
        }
        return null;
      },
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            color: Styles.textColor(context),
            fontSize: 16,
          ),
      onChanged: (value) => formData.username = value,
      decoration: InputDecoration(
          hintText: _globalService.getString(Const.USERNAME),
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, -5.0),
          suffixIcon: Icon(Icons.person_outline_rounded)),
      textInputAction: TextInputAction.next,
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: _obscurePassword,
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            color: Styles.textColor(context),
            fontSize: 16,
          ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return _globalService.getString(Const.LOGIN_PASS_REQ);
        }
        return null;
      },
      onChanged: (value) => formData.password = value,
      decoration: InputDecoration(
        hintText: _globalService.getString(Const.LOGIN_PASS),
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, -5.0),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: _toggle,
        ),
      ),
      textInputAction: TextInputAction.done,
      maxLength: 30,
    );

    final loginButton = CustomButton(
        backgroundColor: Colors.blue,
        label: _globalService.getString(Const.LOGIN_LOGIN_BTN).toUpperCase(),
        shape: ButtonShape.Rounded,
        onClick: () {
          ExamSchedule();
        }
        // onClick: () {
        //   if (_formKey.currentState.validate()) {
        //     removeFocusFromInputField(context);
        //     _bloc.postLoginFormData(formData);
        //   }
        // },
        );

    final registerLabel = Row(
      children: [
        Spacer(),
        TextButton(
          child: Text(
            _globalService.getString(Const.LOGIN_FORGOT_PASS),
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontSize: 16, color: Colors.red),
          ),
          onPressed: () =>
              Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName),
        )
      ],
    );

    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppConstants.loginBackground),
                fit: BoxFit.cover)),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Spacer(
                flex: 3,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppConstants.loginPageIcon),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  margin: const EdgeInsets.only(bottom: 70),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey.shade400,
                      )),
                  elevation: 20,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 15.0),
                        formData.usernamesEnabled ? username : email,
                        SizedBox(height: 8.0),
                        password,
                        SizedBox(height: 10.0),
                        loginButton,
                        registerLabel
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExamSchedule(),
                      ),
                    );
                  },
                  child: Text('Exame Sechedule'))
            ],
          ),
        ),
      ),
    );
  }
}
