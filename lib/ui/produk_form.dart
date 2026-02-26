import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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

  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    _kodeController = TextEditingController(text: widget.produk?.kode ?? '');
    _namaController = TextEditingController(text: widget.produk?.nama ?? '');
    _hargaController = TextEditingController(text: widget.produk?.harga?.toString() ?? '');
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _imageBytes = bytes;
          _base64Image = base64Encode(bytes);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal mengambil gambar")),
      );
    }
  }

  Future<void> simpan() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      bool isEdit = widget.produk != null;
      String url = isEdit ? BaseUrl.update : BaseUrl.create;

      Map<String, dynamic> bodyData = {
        'kode': _kodeController.text,
        'nama': _namaController.text,
        'harga': int.parse(_hargaController.text),
      };

      if (isEdit) bodyData['id'] = widget.produk!.id;
      if (_base64Image != null) bodyData['gambar'] = _base64Image;

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode(bodyData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] != null) throw Exception(data['error']);
        
        if (!mounted) return;
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data berhasil disimpan"), backgroundColor: Colors.black87),
        );
      } else {
        throw Exception('Status: ${response.statusCode}');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.redAccent),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String judul = widget.produk == null ? "Tambah Produk" : "Edit Produk";

    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih bersih
      appBar: AppBar(
        title: Text(judul, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0, // Hilangkan bayangan header
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Foto Produk",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 12),
                
                // --- AREA PILIH GAMBAR ELEGANT ---
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300, width: 1.5),
                    ),
                    child: _buildImagePreview(),
                  ),
                ),
                const SizedBox(height: 30),

                // --- FORM INPUT TEKS ---
                FormProduk(
                  kodeController: _kodeController,
                  namaController: _namaController,
                  hargaController: _hargaController,
                ),
                
                const SizedBox(height: 40),
                
                // --- TOMBOL SIMPAN ELEGANT ---
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : simpan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Warna hitam solid
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            "Simpan Perubahan",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, letterSpacing: 0.5),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget pembantu untuk menampilkan preview gambar
  Widget _buildImagePreview() {
    if (_imageBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.memory(_imageBytes!, fit: BoxFit.cover, width: double.infinity),
      );
    } 
    else if (widget.produk?.gambar != null && widget.produk!.gambar!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.network(
          BaseUrl.imageUrl + widget.produk!.gambar!,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) => Center(
            child: Icon(Icons.broken_image_outlined, size: 40, color: Colors.grey.shade400),
          ),
        ),
      );
    } 
    else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt_outlined, size: 36, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text(
            "Pilih foto dari galeri",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      );
    }
  }
}