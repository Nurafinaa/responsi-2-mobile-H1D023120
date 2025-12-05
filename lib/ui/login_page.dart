import 'package:flutter/material.dart';
import 'package:responsi2_mobile_paket2_h1d023120/bloc/login_bloc.dart';
import 'package:responsi2_mobile_paket2_h1d023120/helpers/user_info.dart';
import 'package:responsi2_mobile_paket2_h1d023120/ui/inventaris_page.dart';
import 'package:responsi2_mobile_paket2_h1d023120/ui/registrasi_page.dart';
import 'package:responsi2_mobile_paket2_h1d023120/widget/warning_dialog.dart';
import 'package:responsi2_mobile_paket2_h1d023120/widget/success_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nazwamart - Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailTextboxController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v!.isEmpty ? 'Email harus diisi' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordTextboxController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (v) => v!.isEmpty ? 'Password harus diisi' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  var validate = _formKey.currentState!.validate();
                  if (validate && !_isLoading) _submit();
                },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Login'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegistrasiPage()),
                  );
                },
                child: const Text('Registrasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    setState(() {
      _isLoading = true;
    });

    LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) async {
      print("==== LOGIN RESULT ====");
      print("status: ${value.status}");
      print("message: ${value.message}");
      print("data: ${value.data}");

      if (value.status == true) {
        await UserInfo().setUserID(value.data?.id ?? 0);
        await UserInfo().setNama(value.data?.nama ?? "");
        await UserInfo().setEmail(value.data?.email ?? "");

        if (!mounted) return;
        
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => SuccessDialog(
            description: 'Login berhasil',
            okClick: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const InventarisPage()),
                (route) => false,
              );
            },
          ),
        );
      } else {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (_) =>
              WarningDialog(description: 'Login gagal, cek kredensial'),
        );
      }
    }).catchError((err) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => WarningDialog(description: err.toString()),
      );
    }).whenComplete(() {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
}