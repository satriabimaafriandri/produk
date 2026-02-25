import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:produk_app/models/api.dart';
import 'package:produk_app/models/produk.dart';
import 'package:produk_app/ui/form_produk.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;
  const ProdukForm({super.key, this.produk});

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  late TextEditingController _kodeController;
  late TextEditingController _namaController;
  late TextEditingController _hargaController;

  @override
  void initState() {
    super.initState();
    _kodeController = TextEditingController(text: widget.produk?.kode ?? '');
    _namaController = TextEditingController(text: widget.produk?.nama ?? '');
    _hargaController = TextEditingController(text: widget.produk?.harga?.toString() ?? '');
  }

  Future<void> simpan() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // 1. Tentukan URL (Create atau Update)
      bool isEdit = widget.produk != null;
      String url = isEdit ? BaseUrl.update : BaseUrl.create;

      // 2. Buat objek produk. PENTING: ID harus disertakan jika Edit!
      Map<String, dynamic> bodyData = {
        'kode': _kodeController.text,
        'nama': _namaController.text,
        'harga': int.parse(_hargaController.text),
      };

      if (isEdit) {
        bodyData['id'] = widget.produk!.id; // Masukkan ID agar PHP tahu data mana yang diupdate
      }

      print("URL: $url");
      print("Body dikirim: ${jsonEncode(bodyData)}");

      // 3. Kirim Request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json', 
          'Accept': 'application/json'
        },
        body: jsonEncode(bodyData),
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] != null) {
          throw Exception(data['error']);
        }
        
        if (!mounted) return;
        Navigator.pop(context, true); // Kembali dengan sukses
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data berhasil disimpan"), backgroundColor: Colors.green),
        );
      } else {
        throw Exception('Gagal menyimpan. Status: ${response.statusCode}');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String judul = widget.produk == null ? "Tambah Produk" : "Edit Produk";

    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormProduk(
                    kodeController: _kodeController,
                    namaController: _namaController,
                    hargaController: _hargaController,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : simpan,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("SIMPAN", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}