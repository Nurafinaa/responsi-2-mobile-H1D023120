import 'package:flutter/material.dart';
import 'package:responsi2_mobile_paket2_h1d023120/model/inventaris.dart';
import 'package:responsi2_mobile_paket2_h1d023120/bloc/inventaris_bloc.dart';
import 'package:responsi2_mobile_paket2_h1d023120/ui/inventaris_page.dart';
import 'package:responsi2_mobile_paket2_h1d023120/ui/inventaris_form.dart';
import 'package:responsi2_mobile_paket2_h1d023120/widget/warning_dialog.dart';

class InventarisDetail extends StatelessWidget {
  final Inventaris inv;
  const InventarisDetail({Key? key, required this.inv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          'Detail Item Nazwamart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => InventarisForm(inv: inv),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_rounded),
            onPressed: () {
              _showDeleteConfirmation(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
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
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.inventory_2_rounded,
                      size: 50,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    inv.nama ?? '-',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildQuickInfo(
                        icon: Icons.shopping_cart_rounded,
                        label: 'Stok',
                        value: '${inv.jumlah ?? 0}',
                      ),
                      const SizedBox(width: 24),
                      _buildQuickInfo(
                        icon: Icons.attach_money_rounded,
                        label: 'Harga',
                        value: 'Rp ${inv.harga ?? 0}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informasi Detail',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailCard(
                    icon: Icons.label_rounded,
                    title: 'Nama Item',
                    value: inv.nama ?? '-',
                    color: const Color(0xFF4CAF50),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailCard(
                    icon: Icons.money_rounded,
                    title: 'Harga Satuan',
                    value: 'Rp ${_formatNumber(inv.harga ?? 0)}',
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  _buildDetailCard(
                    icon: Icons.inventory_rounded,
                    title: 'Jumlah Stok',
                    value: '${inv.jumlah ?? 0} unit',
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _buildDetailCard(
                    icon: Icons.calendar_today_rounded,
                    title: 'Tanggal Masuk',
                    value: _formatDate(inv.tanggalMasuk ?? '-'),
                    color: Colors.purple,
                  ),
                  const SizedBox(height: 12),
                  _buildDetailCard(
                    icon: Icons.event_busy_rounded,
                    title: 'Tanggal Kedaluwarsa',
                    value: _formatDate(inv.tanggalKedaluwarsa ?? '-'),
                    color: Colors.red,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => InventarisForm(inv: inv),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit_rounded),
                            label: const Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7D32),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showDeleteConfirmation(context);
                            },
                            icon: const Icon(Icons.delete_rounded),
                            label: const Text(
                              'Hapus',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfo({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  String _formatDate(String date) {
    if (date == '-') return date;
    try {
      final parts = date.split('-');
      if (parts.length == 3) {
        final months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'Mei',
          'Jun',
          'Jul',
          'Agu',
          'Sep',
          'Okt',
          'Nov',
          'Des'
        ];
        return '${parts[2]} ${months[int.parse(parts[1]) - 1]} ${parts[0]}';
      }
    } catch (e) {
      return date;
    }
    return date;
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.warning_rounded,
                color: Colors.red,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Konfirmasi Hapus',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'Apakah Anda yakin ingin menghapus item ini? Tindakan ini tidak dapat dibatalkan.',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            child: const Text(
              'Batal',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Hapus',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.pop(context);
              _deleteItem(context);
            },
          ),
        ],
      ),
    );
  }

  void _deleteItem(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF2E7D32),
        ),
      ),
    );

    InventarisBloc.deleteInventaris(inv.id!).then((success) {
      Navigator.pop(context);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item berhasil dihapus!'),
            backgroundColor: Color(0xFF2E7D32),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const InventarisPage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => WarningDialog(
            description: 'Gagal menghapus item',
          ),
        );
      }
    }).catchError((err) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (_) => WarningDialog(
          description: err.toString(),
        ),
      );
    });
  }
}