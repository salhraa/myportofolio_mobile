### Tugas 8

1. Perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop() yaitu:
Navigator.push(): Membuka halaman baru di atas halaman sebelumnya. Halaman sebelumnya tetap tersimpan sehingga pengguna dapat kembali menggunakan tombol Back.
Navigator.pushReplacement(): Membuka halaman baru sekaligus menggantikan halaman sebelumnya. Halaman sebelumnya tidak lagi menjadi bagian dari tumpukan navigasi.
Navigator.pop(): Menutup halaman yang sedang dibuka dan kembali ke halaman sebelumnya.
Opsi Home pada drawer menggunakan Navigator.pushReplacement() menuju MyHomePage(). Tujuannya agar pengguna kembali ke halaman utama tanpa menumpuk halaman utama yang baru di atas halaman sebelumnya.

2. Sususnan Scaffold, appbar, dan drawer untuk menjaga struktur halaman tetap konsisten:
Scaffold mengatur komponen utama halaman, seperti AppBar, Drawer, dan body.
AppBar menampilkan bagian atas halaman, seperti judul dan tombol menu untuk membuka drawer.
Drawer menyediakan navigasi agar pengguna dapat berpindah ke halaman lain melalui menu samping.
Contoh penerapan warna tema portofolio adalah penggunaan warna colorScheme.primary pada AppBar dan colorScheme.secondary pada kartu informasi. Dengan menggunakan warna dari tema aplikasi, halaman utama dan halaman formulir dapat mempertahankan identitas visual yang sama tanpa harus menentukan warna secara berulang.

3. Tata letak formulir dipilih untuk formulir karena menggunakan Column untuk menyusun komponen input secara vertikal agar pengguna dapat mengisi data secara berurutan.
peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas yaitu untuk membuat formulir lebih rapi, nyaman digunakan, dan dapat menyesuaikan berbagai ukuran layar tanpa membuat komponen tertutup atau sulit dijangkau. Contoh widget pendukung yang digunakan yaitu Padding, SizeBox, SingleChildScrollView.

4. GlobalKey<FormState> digunakan untuk mengakses dan mengelola kondisi form. validator berisi aturan untuk memeriksa apakah input yang dimasukkan pengguna sudah valid, sedangkan validate() menjalankan seluruh fungsi validator ketika tombol Simpan ditekan. Jika semua input valid, proses penyimpanan dapat dilanjutkan. Namun, jika ada input yang tidak valid, aplikasi akan menampilkan pesan kesalahan dan membatalkan penyimpanan.Contoh nilai yang ditolak yaitu kolom judul proyek karena wajib diisi. Pemilihan jenis input atau papan ketik saja belum cukup karena tidak menjamin data yang dimasukkan selalu sesuai aturan aplikasi. Misalnya, keyboard numerik hanya membantu pengguna memasukkan angka, tetapi tidak memastikan bahwa angka tersebut berada dalam rentang yang diperbolehkan. Oleh karena itu, validasi tetap diperlukan sebelum data disimpan.
