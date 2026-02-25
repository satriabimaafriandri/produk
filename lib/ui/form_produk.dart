import 'package:flutter/material.dart';

class FormProduk extends StatelessWidget {
  final TextEditingController kodeController;
  final TextEditingController namaController;
  final TextEditingController hargaController;

  const FormProduk({
    super.key,
    required this.kodeController,
    required this.namaController,
    required this.hargaController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildField(kodeController, "Kode Produk", Icons.qr_code),
        _buildField(namaController, "Nama Produk", Icons.label),
        _buildField(hargaController, "Harga", Icons.attach_money, isNumber: true),
      ],
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, IconData icon, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: ctrl,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) => value!.isEmpty ? "$label harus diisi" : null,
      ),
    );
  }
}