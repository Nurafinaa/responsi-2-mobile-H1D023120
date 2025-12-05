import 'package:flutter/material.dart';
import 'package:responsi2_mobile_paket2_h1d023120/bloc/registrasi_bloc.dart';
import 'package:responsi2_mobile_paket2_h1d023120/widget/success_dialog.dart';
import 'package:responsi2_mobile_paket2_h1d023120/widget/warning_dialog.dart';
import 'package:responsi2_mobile_paket2_h1d023120/ui/login_page.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nazwamart - Registrasi')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                  validator: (v) => v!.length < 3 ? 'Nama minimal 3' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (v) =>
                      v!.isEmpty ? 'Email harus diisi' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (v) =>
                      v!.length < 6 ? 'Password minimal 6' : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    var valid = _formKey.currentState!.validate();
                    if (valid && !_isLoading) _submit();
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Registrasi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    setState(() {
      _isLoading = true;
    });

    RegistrasiBloc.registrasi(
      nama: _namaController.text,
      email: _emailController.text,
      password: _passwordController.text,
    ).then((value) {
      showDialog(
        context: context,
        builder: (_) => SuccessDialog(
          description: 'Registrasi berhasil',
          okClick: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginPage(),
              ),
            );
          },
        ),
      );
    }).catchError((err) {
      showDialog(
        context: context,
        builder: (_) => WarningDialog(
          description: err.toString(),
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
