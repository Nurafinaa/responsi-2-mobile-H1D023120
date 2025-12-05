import 'package:flutter/material.dart';
import 'package:responsi2_mobile_paket2_h1d023120/model/inventaris.dart';
import 'package:responsi2_mobile_paket2_h1d023120/bloc/inventaris_bloc.dart';
import 'inventaris_page.dart';
import 'package:responsi2_mobile_paket2_h1d023120/widget/warning_dialog.dart';

class InventarisForm extends StatefulWidget {
  final Inventaris? inv;
  const InventarisForm({Key? key, this.inv}) : super(key: key);

  @override
  _InventarisFormState createState() => _InventarisFormState();
}

class _InventarisFormState extends State<InventarisForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _nama = TextEditingController();
  final _harga = TextEditingController();
  final _jumlah = TextEditingController();
  final _tglMasuk = TextEditingController();
  final _tglKadaluarsa = TextEditingController();

  String title = "Tambah Inventaris Nazwamart";
  String buttonText = "SIMPAN";

  @override
  void initState() {
    super.initState();
    if (widget.inv != null) {
      title = "Ubah Inventaris Nazwamart";
      buttonText = "UBAH";

      _nama.text = widget.inv!.nama ?? '';
      _harga.text = widget.inv!.harga?.toString() ?? '';
      _jumlah.text = widget.inv!.jumlah?.toString() ?? '';
      _tglMasuk.text = widget.inv!.tanggalMasuk ?? '';
      _tglKadaluarsa.text = widget.inv!.tanggalKedaluwarsa ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2E7D32),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.inventory_2_rounded,
                      size: 40,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.inv == null
                        ? 'Tambah Item Baru'
                        : 'Edit Item',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.inv == null
                        ? 'Isi form di bawah untuk menambah item'
                        : 'Perbarui informasi item Anda',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _nama,
                      label: 'Nama Item',
                      icon: Icons.shopping_bag_rounded,
                      hint: 'Masukkan nama item',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _harga,
                      label: 'Harga',
                      icon: Icons.attach_money_rounded,
                      hint: 'Masukkan harga',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _jumlah,
                      label: 'Jumlah',
                      icon: Icons.numbers_rounded,
                      hint: 'Masukkan jumlah',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _tglMasuk,
                      label: 'Tanggal Masuk',
                      icon: Icons.calendar_today_rounded,
                      hint: 'YYYY-MM-DD',
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: Color(0xFF2E7D32),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (date != null) {
                          _tglMasuk.text =
                              "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _tglKadaluarsa,
                      label: 'Tanggal Kedaluwarsa',
                      icon: Icons.event_busy_rounded,
                      hint: 'YYYY-MM-DD',
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: Color(0xFF2E7D32),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (date != null) {
                          _tglKadaluarsa.text =
                              "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  widget.inv == null ? simpan() : ubah();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    widget.inv == null
                                        ? Icons.save_rounded
                                        : Icons.update_rounded,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    buttonText,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2E7D32),
              size: 20,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(color: Colors.grey[400]),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: (v) => v!.isEmpty ? '$label wajib diisi' : null,
      ),
    );
  }

  void simpan() {
    setState(() => _isLoading = true);

    Inventaris inv = Inventaris(
      nama: _nama.text,
      harga: int.parse(_harga.text),
      jumlah: int.parse(_jumlah.text),
      tanggalMasuk: _tglMasuk.text,
      tanggalKedaluwarsa: _tglKadaluarsa.text,
    );

    InventarisBloc.addInventaris(inv).then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data berhasil disimpan!'),
            backgroundColor: Color(0xFF2E7D32),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const InventarisPage()),
        );
      }
    }).catchError((err) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => WarningDialog(description: err.toString()),
        );
      }
    }).whenComplete(() {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  void ubah() {
    setState(() => _isLoading = true);

    Inventaris inv = Inventaris(
      id: widget.inv!.id,
      nama: _nama.text,
      harga: int.parse(_harga.text),
      jumlah: int.parse(_jumlah.text),
      tanggalMasuk: _tglMasuk.text,
      tanggalKedaluwarsa: _tglKadaluarsa.text,
    );

    InventarisBloc.updateInventaris(inv).then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data berhasil diupdate!'),
            backgroundColor: Color(0xFF2E7D32),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const InventarisPage()),
        );
      }
    }).catchError((err) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => WarningDialog(description: err.toString()),
        );
      }
    }).whenComplete(() {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }
}