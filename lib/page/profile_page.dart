import 'package:flutter/material.dart';

// ================= GLOBAL STATE =================
class UserProfile {
  String nama;
  String lokasi;
  String jabatan;
  String profesi;
  String tentangSaya;
  String expRole;
  String expCompany;
  String expYear;
  String pendidikan;
  String email;
  String phone;

  UserProfile({
    this.nama = "",
    this.lokasi = "",
    this.jabatan = "",
    this.profesi = "",
    this.tentangSaya = "",
    this.expRole = "",
    this.expCompany = "",
    this.expYear = "",
    this.pendidikan = "",
    this.email = "",
    this.phone = "",
  });
}

// Mengosongkan data saat aplikasi pertama kali dijalankan
final ValueNotifier<UserProfile> profileNotifier = ValueNotifier(UserProfile());
// ================================================

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDetailVisible = false;
  final Color primaryColor = const Color(0xFF0A66C2); // LinkedIn Blue

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserProfile>(
      valueListenable: profileNotifier,
      builder: (context, profileData, child) {
        bool isDataEmpty = profileData.nama.isEmpty;

        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ================= HEADER (DIBUAT STATIS) =================
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 180,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://media.licdn.com/dms/image/v2/D5616AQFQ-5whuUIUMw/profile-displaybackgroundimage-shrink_350_1400/profile-displaybackgroundimage-shrink_350_1400/0/1729172902860?e=1778112000&v=beta&t=wXNXC3xKu8gD1dBlBSrP9Nlh_shFFhvlR4uBkVvEfnQ',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -50,
                        left: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.white,
                          child: const CircleAvatar(
                            radius: 48,
                            backgroundImage: NetworkImage(
                              'https://media.licdn.com/dms/image/v2/D5603AQE9Et_ZG6Rgnw/profile-displayphoto-shrink_800_800/B56ZQWuWq0HIAc-/0/1735548038326?e=1778112000&v=beta&t=hdRd2rGHLqv28V9EuFXN_PFKANbuidxq9IojeniFhuk',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 60),
                  const Text(
                    "M. Rafid Tsabitdly",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Tangerang Selatan, Banten, Indonesia",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Founder & CEO",
                    style: TextStyle(color: Colors.black54),
                  ),

                  const SizedBox(height: 16),

                  // ================= STATS =================
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _statItem("Project", isDataEmpty ? "0" : "4"),
                          _divider(),
                          _statItem("Followers", isDataEmpty ? "0" : "2532"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= BUTTON =================
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isDetailVisible = true;
                      });
                    },
                    child: Text(
                      "Lihat Detail Profil",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ================= DETAIL =================
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState: isDetailVisible
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: const SizedBox(),
                    secondChild: _buildDetailSection(profileData, isDataEmpty),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ================= DETAIL SECTION (DINAMIS) =================
  Widget _buildDetailSection(UserProfile data, bool isEmpty) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          _modernCard(
            "Informasi",
            Icons.person,
            Column(
              children: [
                _item("Nama Lengkap", isEmpty ? "-" : data.nama),
                _item("Lokasi", isEmpty ? "-" : data.lokasi),
                _item("Jabatan", isEmpty ? "-" : data.jabatan),
                _item("Profesi", isEmpty ? "-" : data.profesi),
              ],
            ),
          ),
          _modernCard(
            "Tentang Saya",
            Icons.info_outline,
            Text(
              isEmpty ? "-" : data.tentangSaya,
              style: const TextStyle(height: 1.5),
            ),
          ),
          _modernCard(
            "Pengalaman",
            Icons.work_outline,
            isEmpty
                ? const Text("-")
                : Column(
                    children: [
                      _experienceItem(
                        data.expRole,
                        data.expCompany,
                        data.expYear,
                      ),
                    ],
                  ),
          ),
          _modernCard(
            "Pendidikan",
            Icons.school_outlined,
            Text(isEmpty ? "-" : data.pendidikan),
          ),
          _modernCard(
            "Kontak",
            Icons.contact_mail_outlined,
            isEmpty
                ? const Text("-")
                : Column(
                    children: [
                      _contactItem(Icons.email, data.email),
                      _contactItem(Icons.phone, data.phone),
                    ],
                  ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              setState(() {
                isDetailVisible = false;
              });
            },
            child: const Text(
              "Tutup Detail",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ================= COMPONENT =================
  Widget _modernCard(String title, IconData icon, Widget child) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              title,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _experienceItem(String role, String company, String year) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: primaryColor.withOpacity(0.1),
            child: Icon(Icons.work, size: 18, color: primaryColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(company, style: TextStyle(color: Colors.grey[600])),
                Text(
                  year,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: primaryColor),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  Widget _statItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(value),
      ],
    );
  }

  Widget _divider() {
    return Container(height: 30, width: 1, color: Colors.grey[300]);
  }
}
