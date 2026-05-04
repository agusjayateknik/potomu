# 🎉 FOTOMU - Setup & Panduan Lengkap

## ⚡ Quick Start

### Yang Paling Mudah - Buka Langsung!
```
1. Cari file: Fotomu.html
2. Double-click atau buka di browser
3. Selesai! Aplikasi siap pakai
```

**Tidak perlu instalasi apapun!** Semua berjalan di browser Anda.

---

## 📋 Persyaratan

### Minimal
- ✅ Browser modern (Chrome, Firefox, Safari, Edge)
- ✅ Koneksi internet (untuk load AI model face-api.js)

### Optional (untuk enhancement)
- Node.js + npm (jika ingin menambah backend)

---

## 🚀 Cara Menggunakan

### Tab 1: ROBOMU (Scan Wajah)
```
1. Klik "Mulai Scan Sekarang"
2. Izinkan akses kamera browser
3. Arahkan wajah ke kamera
4. Klik "Ambil Foto Wajah"
5. Konfirmasi apakah foto yang ditunjukkan adalah Anda
6. Foto yang match akan ditampilkan
7. Tambahkan ke keranjang dan checkout
```

### Tab 2: HomeFeed (Sosial)
```
1. Klik tombol "+ Post"
2. Pilih foto dan tulis caption
3. Klik "Post Sekarang"
4. Lihat dan interaksi dengan post (like, comment)
```

### Tab 3: Sell (Upload Foto)
```
1. Klik "Pilih Foto Event"
2. Pilih multiple foto dari event
3. Sistem otomatis compress gambar
4. Lihat statistik earning dan foto
```

### Tab 4: DM (Chat)
```
1. Chat list akan tampil
2. Klik untuk membuka percakapan
3. Tulis pesan dan kirim
4. Notifikasi badge untuk chat baru
```

---

## 📊 Data & Storage

Semua data disimpan lokal di browser (localStorage):

| Data | Lokasi | Ukuran Max |
|------|--------|-----------|
| Foto Event | `fotomu_foto` | ~50MB |
| Post Feed | `fotomu_posts` | ~10MB |
| Chat Messages | `fotomu_chats` | ~5MB |
| Orders | `order_*` | ~1MB |

**Catatan**: Clear browser cache akan menghapus semua data

---

## 🔧 Advanced: Setup Backend (Optional)

Jika ingin menggunakan backend Node.js:

### Prerequisites
```bash
# Install Node.js dari: https://nodejs.org/
node --version  # v14+ required
npm --version   # v6+ required
```

### Setup Backend
```bash
# 1. Masuk folder backend
cd backend

# 2. Install dependencies
npm install

# 3. Jalankan server
npm start
# Server akan berjalan di http://localhost:3000
```

### Update Frontend
Buka `Fotomu.html`, cari:
```javascript
const API_BASE = 'http://localhost:3000/api';
```

Ganti dengan backend URL Anda.

---

## 🌐 Deployment Production

### Frontend Only (Recommended)
1. Deploy `Fotomu.html` ke:
   - GitHub Pages
   - Netlify
   - Vercel
   - Any static hosting

### Dengan Backend
1. Deploy backend ke Vercel/Heroku/Railway
2. Set environment variables (API keys)
3. Update `API_BASE` di HTML ke production URL

---

## 🎯 Features Breakdown

### ROBOMU - AI Face Search
- ✅ Real-time wajah detection
- ✅ Face descriptor comparison
- ✅ Match confidence scoring
- ⚠️ Needs good lighting & clear face

### HomeFeed - Social
- ✅ Create posts dengan foto
- ✅ Like & comment interactions
- ✅ Story showcase
- ✅ Real-time updates

### Sell - Creator Dashboard
- ✅ Batch upload dengan compress
- ✅ Statistics (earnings, sold photos)
- ✅ Gallery management
- ✅ Price management

### DM - Messaging
- ✅ Chat history
- ✅ Unread badge
- ✅ Real-time simulation
- ⚠️ Messages baru every ~5 seconds (random)

---

## 🔐 Privacy & Security

```
❌ API Keys → TIDAK di client (aman!)
❌ User Data → Stored lokal saja
❌ Passwords → Tidak diimplementasikan
✅ Face Data → Hanya descriptor (bukan image)
✅ Chat → Terenkripsi lokal
```

---

## 🐛 Troubleshooting

### "Kamera tidak bisa diakses"
- ✅ Izinkan akses kamera di browser
- ✅ HTTPS atau localhost only
- ✅ Tidak boleh HTTP di domain publik

### "Face tidak terdeteksi"
- ✅ Pastikan pencahayaan cukup
- ✅ Wajah terlihat jelas
- ✅ Model AI sedang loading

### "Upload tidak bekerja"
- ✅ Browser support HTML5 FileAPI
- ✅ Ukuran file tidak terlalu besar
- ✅ Format JPG/PNG

### "Data hilang"
- ✅ Clear cache = hilang semua data
- ✅ Incognito mode tidak menyimpan
- ✅ Gunakan browser normal

---

## 💡 Tips & Tricks

1. **Foto Terbaik**: Ambil di cahaya terang, wajah langsung ke kamera
2. **Multiple Photos**: Bisa upload 10+ sekaligus, sistem akan compress
3. **Download Link**: Ada di alert, copy-paste untuk share ke pembeli
4. **Dark Mode**: Toggle di tombol sun/moon di header
5. **Local Dev**: Buka devtools (F12) untuk debug

---

## 📞 Support

Jika ada error atau pertanyaan:
1. Check console (F12 → Console tab)
2. Read error message carefully
3. Try refresh browser
4. Clear localStorage & try again

---

## 📄 License & Credits

- **Framework**: TailwindCSS, Lucide Icons
- **AI**: face-api.js
- **Hosting**: Supabase (optional)
- **Email**: EmailJS (optional)

Enjoy FOTOMU! 🎉✨