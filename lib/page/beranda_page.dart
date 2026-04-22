import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:simple_alert_dialog/simple_alert_dialog.dart';
import 'package:project_4/page/profile_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPage();
}

class _BerandaPage extends State<BerandaPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jabatanController = TextEditingController();
  final TextEditingController _profesiController = TextEditingController();
  final TextEditingController _tentangController = TextEditingController();
  final TextEditingController _expRoleController = TextEditingController();
  final TextEditingController _expCompanyController = TextEditingController();
  final TextEditingController _pendidikanController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _selectedProvinsi;
  String? _selectedKota;
  String? _startYear;
  String? _endYear;

  // Data Dummy Bertingkat (Cascading) untuk Provinsi & Kota
  final Map<String, List<String>> _lokasiData = {
    'Banten': ['Tangerang Selatan', 'Tangerang', 'Serang', 'Cilegon'],
    'DKI Jakarta': [
      'Jakarta Selatan',
      'Jakarta Pusat',
      'Jakarta Barat',
      'Jakarta Timur',
      'Jakarta Utara',
    ],
    'Jawa Barat': ['Bandung', 'Bogor', 'Depok', 'Bekasi'],
    'Jawa Tengah': ['Semarang', 'Surakarta', 'Magelang'],
    'Jawa Timur': ['Surabaya', 'Malang', 'Sidoarjo'],
  };

  final List<String> _years = List.generate(
    30,
    (index) => (DateTime.now().year - index).toString(),
  );

  void _showFormTambahData() {
    // Kosongkan semua field
    _namaController.clear();
    _jabatanController.clear();
    _profesiController.clear();
    _tentangController.clear();
    _expRoleController.clear();
    _expCompanyController.clear();
    _pendidikanController.clear();
    _emailController.clear();
    _phoneController.clear();
    _selectedProvinsi = null;
    _selectedKota = null;
    _startYear = null;
    _endYear = null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Lengkapi Detail Profil",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Informasi Dasar",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildTextField(
                                "Nama Lengkap",
                                Icons.person,
                                _namaController,
                              ),

                              // ====== DROPDOWN LOKASI ======
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildDropdown(
                                      "Provinsi",
                                      Icons.map,
                                      _lokasiData.keys.toList(),
                                      _selectedProvinsi,
                                      (val) {
                                        setModalState(() {
                                          _selectedProvinsi = val;
                                          _selectedKota =
                                              null; // Reset kota saat provinsi diganti
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildDropdown(
                                      "Kota",
                                      Icons.location_city,
                                      _selectedProvinsi != null
                                          ? _lokasiData[_selectedProvinsi]!
                                          : [],
                                      _selectedKota,
                                      (val) => setModalState(
                                        () => _selectedKota = val,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // ============================
                              _buildTextField(
                                "Jabatan",
                                Icons.work,
                                _jabatanController,
                              ),
                              _buildTextField(
                                "Profesi",
                                Icons.business_center,
                                _profesiController,
                              ),
                              _buildTextField(
                                "Tentang Saya",
                                Icons.info_outline,
                                _tentangController,
                                maxLines: 3,
                              ),

                              const SizedBox(height: 15),
                              const Text(
                                "Pengalaman",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildTextField(
                                "Posisi / Role",
                                Icons.badge,
                                _expRoleController,
                              ),
                              _buildTextField(
                                "Nama Perusahaan",
                                Icons.apartment,
                                _expCompanyController,
                              ),

                              // ====== DROPDOWN TAHUN ======
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildDropdown(
                                      "Tahun Mulai",
                                      Icons.calendar_today,
                                      _years,
                                      _startYear,
                                      (val) =>
                                          setModalState(() => _startYear = val),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildDropdown(
                                      "Tahun Selesai",
                                      Icons.event,
                                      ['Sekarang', ..._years],
                                      _endYear,
                                      (val) =>
                                          setModalState(() => _endYear = val),
                                    ),
                                  ),
                                ],
                              ),

                              // ============================
                              const SizedBox(height: 15),
                              const Text(
                                "Pendidikan & Kontak",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildTextField(
                                "Sekolah / Universitas",
                                Icons.school,
                                _pendidikanController,
                              ),

                              _buildTextField(
                                "Email",
                                Icons.email,
                                _emailController,
                                keyboardType: TextInputType.emailAddress,
                                customValidator: (value) {
                                  if (value == null || value.trim().isEmpty)
                                    return 'Email tidak boleh kosong';
                                  if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  ).hasMatch(value))
                                    return 'Format email tidak valid';
                                  return null;
                                },
                              ),

                              _buildTextField(
                                "Nomor Telepon",
                                Icons.phone,
                                _phoneController,
                                keyboardType: TextInputType.phone,
                                customValidator: (value) {
                                  if (value == null || value.trim().isEmpty)
                                    return 'Nomor Telepon tidak boleh kosong';
                                  if (!RegExp(r'^\+?[0-9]+$').hasMatch(value))
                                    return 'Hanya boleh berisi angka';
                                  if (value.length < 9 || value.length > 15)
                                    return 'Harus 9 - 15 digit';
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              SimpleAlertDialog.show(
                                context,
                                assetImagepath: AnimatedImage.confirm,
                                buttonsColor: Colors.green,
                                title: AlertTitleText("Konfirmasi Simpan"),
                                content: AlertContentText(
                                  "Apakah Anda yakin semua data yang dimasukkan sudah benar dan sesuai?",
                                ),
                                onConfirmButtonPressed: (ctx) {
                                  // SIMPAN DATA YANG TELAH DIKOMBINASI
                                  profileNotifier.value = UserProfile(
                                    nama: _namaController.text,
                                    lokasi:
                                        '$_selectedKota, $_selectedProvinsi, Indonesia', // Penggabungan Lokasi
                                    jabatan: _jabatanController.text,
                                    profesi: _profesiController.text,
                                    tentangSaya: _tentangController.text,
                                    expRole: _expRoleController.text,
                                    expCompany: _expCompanyController.text,
                                    expYear:
                                        '$_startYear - $_endYear', // Penggabungan Tahun
                                    pendidikan: _pendidikanController.text,
                                    email: _emailController.text,
                                    phone: _phoneController.text,
                                  );

                                  Navigator.pop(ctx);
                                  Navigator.pop(context);

                                  CherryToast.success(
                                    inheritThemeColors: true,
                                    title: const Text(
                                      "Berhasil menambahkan data detail!",
                                    ),
                                    borderRadius: 10,
                                  ).show(context);
                                },
                              );
                            } else {
                              CherryToast.error(
                                inheritThemeColors: true,
                                title: const Text(
                                  "Mohon perbaiki data yang belum sesuai!",
                                ),
                                borderRadius: 10,
                              ).show(context);
                            }
                          },
                          child: const Text(
                            "Simpan Data",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // WIDGET KHUSUS DROPDOWN (BARU)
  Widget _buildDropdown(
    String label,
    IconData icon,
    List<String> items,
    String? selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        isExpanded:
            true, // Mencegah teks kepanjangan melampaui batas (overflow)
        value: selectedValue,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: items.isEmpty
            ? null
            : onChanged, // Disable jika item kosong (menunggu Provinsi)
        validator: (value) => value == null ? '$label wajib diisi' : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF0A66C2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? customValidator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator:
            customValidator ??
            (value) {
              if (value == null || value.trim().isEmpty)
                return '$label tidak boleh kosong';
              return null;
            },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF0A66C2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A66C2),
        title: const Text("Beranda", style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 400,
              child: Card(
                elevation: 8,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "LinkedIn",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A66C2),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Kelola Data Profil Anda",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Tambah Data",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          onPressed: () {
                            _showFormTambahData();
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          label: const Text(
                            "Hapus Data",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          onPressed: () {
                            SimpleAlertDialog.show(
                              context,
                              assetImagepath: AnimatedImage.warning,
                              buttonsColor: Colors.red,
                              title: AlertTitleText("Apakah kamu yakin?"),
                              content: AlertContentText(
                                "Apakah anda yakin ingin menghapus data di Detail Profil?",
                              ),
                              onConfirmButtonPressed: (ctx) {
                                profileNotifier.value =
                                    UserProfile(); // Reset pakai default kosong

                                CherryToast.success(
                                  inheritThemeColors: true,
                                  title: const Text(
                                    "Data detail profil berhasil dihapus!",
                                  ),
                                  borderRadius: 10,
                                ).show(context);

                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
