# FOTOMU - Upload Sekali, Passive Income Selamanya

Aplikasi web untuk jual beli foto event dengan fitur AI face search.

## 🚀 Fitur Utama
- **ROBOMU**: Scan wajah untuk menemukan foto pribadi
- **HomeFeed**: Posting dan interaksi sosial
- **Sell**: Upload foto event untuk dijual
- **DM Chat**: Sistem chat real-time simulasi
- **Theme Toggle**: Dark/Light mode
- **Responsive**: Mobile-first design

## 🔒 Keamanan
- API keys disembunyikan di server-side
- Semua operasi sensitif melalui backend
- Face detection menggunakan face-api.js

## 🛠 Setup Development

### Backend
```bash
cd backend
npm install
npm start
# atau untuk development
npm run dev
```

### Frontend
Buka `Fotomu.html` di browser. Backend harus running di `http://localhost:3000`.

## 📦 Production Deployment

### Backend
1. Deploy ke platform seperti Vercel, Heroku, atau Railway
2. Set environment variables:
   - SUPABASE_URL
   - SUPABASE_ANON_KEY
   - EMAILJS_SERVICE_ID
   - EMAILJS_TEMPLATE_ID
   - EMAILJS_PUBLIC_KEY
   - EMAILJS_PRIVATE_KEY

### Frontend
1. Update `API_BASE` di `Fotomu.html` ke URL production backend
2. Deploy HTML statis ke GitHub Pages, Netlify, atau Vercel

## 📱 Cara Penggunaan
1. **ROBOMU**: Klik scan wajah untuk menemukan foto Anda
2. **Sell**: Upload foto event, sistem akan detect wajah otomatis
3. **HomeFeed**: Buat post, like, dan comment
4. **DM**: Chat dengan pengguna lain (simulasi)

## 🧠 Teknologi
- **Frontend**: HTML, CSS (Tailwind), JavaScript
- **Backend**: Node.js, Express, Multer
- **Database**: Supabase (storage & potential DB)
- **AI**: face-api.js untuk face detection
- **Email**: EmailJS untuk notifikasi
- **Icons**: Lucide

## 📝 Catatan
- Face detection berjalan di client-side untuk performa
- Upload dan email handling di server-side untuk keamanan
- Chat adalah simulasi, bisa dikembangkan dengan WebSocket

Enjoy building with FOTOMU! 🎉
