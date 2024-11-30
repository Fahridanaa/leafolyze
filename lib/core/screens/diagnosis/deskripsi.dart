class DiseaseData {
  final String name;
  final String description;
  final List<String> treatments;

  const DiseaseData({
    required this.name,
    required this.description,
    required this.treatments,
  });
}

class DiseaseDataProvider {
  static final Map<int, DiseaseData> diseases = {
    1: DiseaseData(
      name: 'Bacterial Spot',
      description: 'Penyakit ini disebabkan oleh bakteri Xanthomonas campestris pv. vesicatoria. Ditandai dengan munculnya bintik hitam kecil pada daun, batang, atau buah tomat. Daun yang terinfeksi akan menguning dan gugur, menghambat pertumbuhan tanaman.',
      treatments: [
        'Gunakan benih yang bebas dari patogen',
        'Hindari menyiram tanaman dari atas (overhead irrigation)',
        'Semprotkan fungisida berbahan tembaga atau antibiotik seperti streptomisin sesuai dosis',
        'Jaga kebersihan lahan dan buang daun yang terinfeksi'
      ],
    ),
    2: DiseaseData(
      name: 'Early Blight',
      description: 'Disebabkan oleh jamur Alternaria solani, penyakit ini menyebabkan bercak cokelat melingkar dengan lingkaran konsentris pada daun. Gejala biasanya muncul pada daun tua terlebih dahulu.',
      treatments: [
        'Terapkan rotasi tanaman untuk mencegah penumpukan patogen',
        'Semprotkan fungisida seperti klorotalonil atau mankozeb',
        'Hindari kelembaban berlebih di sekitar tanaman'
      ],
    ),
    3: DiseaseData(
      name: 'Healthy',
      description: 'Tanaman tomat yang sehat memiliki daun hijau segar, tanpa bercak atau kerusakan. Pertumbuhan tanaman optimal dengan hasil buah berkualitas tinggi.',
      treatments: [
        'Gunakan varietas tahan penyakit',
        'Pastikan penyiraman dan pemupukan dilakukan dengan benar',
        'Jaga sanitasi lahan agar bebas dari patogen'
      ],
    ),
    4: DiseaseData(
      name: 'Late Blight',
      description: 'Penyakit ini disebabkan oleh jamur Phytophthora infestans. Gejalanya adalah bercak basah yang berwarna cokelat kehitaman pada daun, batang, dan buah, terutama saat kondisi cuaca lembap.',
      treatments: [
        'Gunakan varietas tomat tahan hawar akhir',
        'Semprotkan fungisida berbahan aktif metalaksil atau dimetomorf',
        'Buang dan musnahkan tanaman yang terinfeksi berat'
      ],
    ),
    5: DiseaseData(
      name: 'Leaf Mold',
      description: 'Penyakit ini disebabkan oleh jamur Cladosporium fulvum. Gejala meliputi bercak kuning di permukaan atas daun dan pertumbuhan jamur hijau keabu-abuan di bagian bawah daun.',
      treatments: [
        'Jaga ventilasi di rumah kaca atau area pertanaman agar tidak lembap',
        'Gunakan fungisida seperti azoksistrobin atau difenokonazol',
        'Potong dan buang daun yang terinfeksi'
      ],
    ),
    6: DiseaseData(
      name: 'Target Spot',
      description: 'Disebabkan oleh jamur Corynespora cassiicola, penyakit ini menyebabkan bercak cokelat berbentuk lingkaran dengan pusat terang seperti target. Dapat menyerang daun, batang, dan buah.',
      treatments: [
        'Terapkan rotasi tanaman dan hindari penanaman terlalu rapat',
        'Semprotkan fungisida seperti klorotalonil atau mankozeb',
        'Buang bagian tanaman yang terinfeksi untuk mencegah penyebaran'
      ],
    ),
    7: DiseaseData(
      name: 'Black Spot',
      description: 'Bercak hitam pada daun tomat sering disebabkan oleh infeksi jamur Alternaria spp. atau bakteri tertentu. Gejala berupa bercak gelap kecil yang berkembang menjadi besar, disertai kerusakan jaringan daun.',
      treatments: [
        'Gunakan benih bebas patogen dan lakukan sterilisasi tanah jika perlu',
        'Semprotkan fungisida berbahan tembaga atau klorotalonil',
        'Hindari menyiram tanaman terlalu sering atau membiarkan tanah tergenang'
      ],
    ),
  };

}
