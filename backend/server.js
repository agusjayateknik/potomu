const express = require('express');
const multer = require('multer');
const cors = require('cors');
const { createClient } = require('@supabase/supabase-js');
const emailjs = require('@emailjs/nodejs');

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('../')); // Serve static files from parent directory (HTML, etc.)

// Configure multer for file uploads
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

// Supabase config
const SUPABASE_URL = 'https://nvamjwnariqqnftmudrg.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_qCjNnaPqnt_j6yfBTWLJyg_X-PQ2OhU';
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// EmailJS config
const EMAILJS_SERVICE_ID = 'service_1ycwelr';
const EMAILJS_TEMPLATE_ID = 'template_c6urgsp';
const EMAILJS_PUBLIC_KEY = '698LfVVbZo2xLmoOE';
const EMAILJS_PRIVATE_KEY = '698LfVVbZo2xLmoOE'; // Assuming same as public for this example, but in real use private key
const NAMA_FG = 'FG Anton';

emailjs.init({
  publicKey: EMAILJS_PUBLIC_KEY,
  privateKey: EMAILJS_PRIVATE_KEY,
});

// Routes

// Upload foto
app.post('/api/upload', upload.array('files'), async (req, res) => {
  try {
    const files = req.files;
    const uploadedPhotos = [];

    for (let file of files) {
      if (!file.mimetype.startsWith('image/')) continue;

      // Compress image (simple resize)
      const compressed = await compressImage(file.buffer);

      const fileName = `${Date.now()}-${file.originalname.replace(/[^a-zA-Z0-9.]/g, '_')}`;

      const { error } = await supabase.storage.from('foto').upload(fileName, compressed);
      if (error) throw error;

      const { data: { publicUrl } } = supabase.storage.from('foto').getPublicUrl(fileName);

      uploadedPhotos.push({
        id: Date.now() + Math.random(),
        nama: file.originalname.split('.')[0],
        harga: 5000,
        fotografer: '@kamu',
        src: publicUrl
      });
    }

    res.json({ success: true, photos: uploadedPhotos });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// Upload post
app.post('/api/upload-post', upload.single('files'), async (req, res) => {
  try {
    const file = req.file;
    const { caption, user } = req.body;

    if (!file || !file.mimetype.startsWith('image/')) {
      return res.status(400).json({ success: false, error: 'Invalid file' });
    }

    // Compress image
    const compressed = await compressImage(file.buffer);

    const fileName = `post-${Date.now()}-${file.originalname.replace(/[^a-zA-Z0-9.]/g, '_')}`;
    
    const { error } = await supabase.storage.from('foto').upload(fileName, compressed);
    if (error) throw error;

    const { data: { publicUrl } } = supabase.storage.from('foto').getPublicUrl(fileName);

    const post = {
      id: Date.now(),
      user: user,
      avatar: `https://i.pravatar.cc/40?u=${user}`,
      img: publicUrl,
      caption: caption,
      likes: [],
      comments: [],
      waktu: new Date().toISOString()
    };

    res.json({ success: true, post: post });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// Send email
app.post('/api/send-email', async (req, res) => {
  try {
    const { email, orderId, total, items, downloadUrl } = req.body;

    await emailjs.send(EMAILJS_SERVICE_ID, EMAILJS_TEMPLATE_ID, {
      buyer_email: email,
      order_id: orderId,
      fg_name: NAMA_FG,
      total_harga: 'Rp ' + total.toLocaleString('id-ID'),
      daftar_foto: items.map((item, i) => `${i+1}. ${item.nama}`).join('\n'),
      download_link: `Klik link ini untuk download:\n${downloadUrl}`
    });

    res.json({ success: true });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: error.text });
  }
});

// Helper function to compress image
function compressImage(buffer) {
  return new Promise((resolve, reject) => {
    const sharp = require('sharp'); // Assuming sharp is installed for image processing
    sharp(buffer)
      .resize(1200, 1200, { fit: 'inside' })
      .jpeg({ quality: 80 })
      .toBuffer()
      .then(resolve)
      .catch(reject);
  });
}

app.listen(port, () => {
  console.log(`FOTOMU backend running on port ${port}`);
});