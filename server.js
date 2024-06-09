const express = require('express');
const { Client } = require('pg');
const path = require('path');
const app = express();
const port = 3000;

app.use(express.static(path.join(__dirname, 'fe')));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const client = new Client({
  host: 'localhost',
  database: 'fixed',
  user: 'postgres',
  password: 'admin',
  port: 5432,
});

client.connect()
  .then(() => console.log('Connected to PostgreSQL database'))
  .catch(err => console.error('Connection error', err.stack));

app.get('/', (req, res) => res.sendFile(path.join(__dirname, 'fe', 'index.html')));
app.get('/dashboard', (req, res) => res.sendFile(path.join(__dirname, 'fe', 'thongtinxevao.html')));
app.get('/register', (req, res) => res.sendFile(path.join(__dirname, 'fe', 'dangkytaikhoan.html')));
app.get('/infokhachhang', (req, res) => res.sendFile(path.join(__dirname, 'fe', 'infokhachhang.html')));
app.get('/infovecuakhachhang', (req, res) => res.sendFile(path.join(__dirname, 'fe', 'infovecuakhachhang.html')));
app.get('/infonhanvien',(req,res) => res.sendFile(path.join(__dirname,'fe','infonhanvien.html')));
//Đăng nhập
app.post('/login', async (req, res) => {
  const { email, password } = req.body;
  try {
    const result = await client.query('SELECT email, vaitro FROM nguoidung WHERE email = $1 AND matkhau = $2', [email, password]);
    if (result.rows.length > 0) {
      const account = result.rows[0];
      res.json({ success: true, account: account });
    } else {
      res.json({ success: false, message: "No user found with the provided credentials." });
    }
  } catch (error) {
    console.error('Error authenticating user:', error);
    res.status(500).json({ success: false, error: 'Error authenticating user' });
  }
});
//Đăng ký tài khoản
app.post('/register', async (req, res) => {
  const { email, password, fullName, gender, dob, address, hometown, phoneNumber, role } = req.body;
  try {
    await client.query('INSERT INTO nguoidung (email, matkhau, hoten, gioitinh, ngsinh, diachi, quequan, sdt, vaitro) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)', [email, password, fullName, gender, dob, address, hometown, phoneNumber, role]);
    res.json({ success: true, message: "User registration successful." });
  } catch (error) {
    console.error('Error registering user:', error);
    res.status(500).json({ success: false, error: 'Error registering user' });
  }
});
//Xe vào
app.post('/submit-xevao', async (req, res) => {
  const { mand, mathekvl, biensoxe, tenloaixe, mabaidoxe } = req.body;

  console.log('Received data:', { mand, mathekvl, biensoxe, tenloaixe, mabaidoxe });

  try {
    const query = `
      INSERT INTO ChiTietRaVao (Mand, MaTheKVL, BienSoXe, TenLoaiXe, MaBaiDoXe, ThoiGianVao)
      VALUES ($1, $2, $3, $4, $5, NOW())
    `;
    const values = [
      mand || null,
      mathekvl || null,
      tenloaixe === 'Xe dap' ? null : biensoxe,
      tenloaixe,
      mabaidoxe
    ];

    console.log('Executing query:', query, 'with values:', values);

    await client.query(query, values);

    res.json({ success: true, message: 'Thông tin đã được lưu trữ thành công!' });
  } catch (error) {
    console.error('Error inserting data into ChiTietRaVao:', error);
    res.status(500).json({ success: false, error: 'Đã xảy ra lỗi, vui lòng thử lại sau.' });
  }
});
//Xe ra
app.post('/submit-xera', async (req, res) => {
  const { mand, mathekvl, biensoxe, mabaidoxe } = req.body;
  console.log('Received data:', { mand, mathekvl, biensoxe, mabaidoxe });

  if (!mand && !mathekvl) {
    return res.status(400).json({ success: false, message: 'Vui lòng nhập mã người dùng hoặc mã thẻ khách vãng lai.' });
  }
  if (!mabaidoxe) {
    return res.status(400).json({ success: false, message: 'Vui lòng nhập mã bãi đỗ xe.' });
  }
  if (biensoxe && !mabaidoxe) {
    return res.status(400).json({ success: false, message: 'Vui lòng nhập mã bãi đỗ xe.' });
  }

  try {
    let query = `
      SELECT ThoiGianRa FROM ChiTietRaVao 
      WHERE ((Mand = $1 AND $1 IS NOT NULL) 
      OR (MaTheKVL = $2 AND $2 IS NOT NULL)) 
      AND mabaidoxe = $4
      AND (biensoxe = $3 OR $3 IS NULL)  -- Thêm điều kiện OR cho biensoxe
      AND ThoiGianRa IS NULL
    `;
    let values = [mand || null, mathekvl || null, biensoxe || null, mabaidoxe];

    console.log('Executing query:', query, 'with values:', values);
    const result = await client.query(query, values);

    if (result.rows.length > 0) {
      let updateQuery = `
        UPDATE ChiTietRaVao 
        SET ThoiGianRa = NOW() 
        WHERE ((Mand = $1 AND $1 IS NOT NULL) 
        OR (MaTheKVL = $2 AND $2 IS NOT NULL)) 
        AND mabaidoxe = $4
        AND (biensoxe = $3 OR $3 IS NULL)  -- Thêm điều kiện OR cho biensoxe
        AND ThoiGianRa IS NULL
      `;
      const updateResult = await client.query(updateQuery, values);
      if (updateResult.rowCount > 0) {
        res.json({ success: true, message: 'Thời gian ra của xe đã được cập nhật thành công.' });
      } else {
        res.json({ success: false, message: 'Không thể cập nhật thời gian ra của xe. Vui lòng thử lại.' });
      }
    } else {
      res.json({ success: false, message: 'Không tồn tại bản ghi phù hợp trong cơ sở dữ liệu.' });
    }
  } catch (error) {
    console.error('Error updating ChiTietRaVao:', error);
    res.status(500).json({ success: false, error: 'Đã xảy ra lỗi, vui lòng thử lại sau.' });
  }
});

//Đăng ký vé
app.post('/dangkymuave', async (req, res) => {
  const { sdt, maloaive, soluongve } = req.body;

  try {
    const insertQuery = `
      INSERT INTO HoaDonMuaVe (MaND, NgayHD, MaLoaiVe, SoLuongVe)
      SELECT MaND, NOW(), $2, $3 FROM NguoiDung WHERE sdt = $1
      RETURNING *;
    `;
    const values = [sdt, maloaive, soluongve];
    //console.log('Sending data 2:', { mand, maloaiVe, soluongve });
    const result = await client.query(insertQuery, values);

    if (result.rows.length > 0) {
      res.json({ success: true, message: 'Đăng ký vé thành công', data: result.rows[0] });
    } else {
      res.json({ success: false, message: 'Không thể đăng ký vé' });
    }
  } catch (error) {
    console.error('Lỗi khi thêm dữ liệu:', error);
    res.status(500).json({ success: false, error: 'Đã xảy ra lỗi, vui lòng thử lại sau.' });
  }
});

//Thông tin nhân viên
app.post('/infonhanvien', async (req, res) => {
  const { email } = req.body;
  try {
      const result = await client.query('SELECT hoten, gioitinh, ngsinh, diachi, quequan, SDT, vaitro, baidoxe.diadiem FROM nguoidung JOIN nhanvien ON nguoidung.mand = nhanvien.mand join baidoxe on baidoxe.mabaidoxe=nhanvien.mabaidoxe WHERE email = $1', [email]);
      if (result.rows.length > 0) {
          const account = result.rows[0];
          res.json({ success: true, account: account });
      } else {
          res.json({ success: false, message: "No user found with the provided credentials." });
      }
  } catch (error) {
      console.error('Error authenticating user:', error);
      res.status(500).json({ success: false, error: 'Error authenticating user' });
  }
});
app.post('/infokhachhang', async (req, res) => {
  const { email } = req.body;
  try {
      const result = await client.query('SELECT hoten, gioitinh, ngsinh, diachi, quequan, sdt, vaitro FROM nguoidung WHERE email = $1', [email]);
      if (result.rows.length > 0) {
          const account = result.rows[0];
          res.json({ success: true, account: account });
      } else {
          res.json({ success: false, message: "No user found with the provided credentials." });
      }
  } catch (error) {
      console.error('Error authenticating user:', error);
      res.status(500).json({ success: false, error: 'Error authenticating user' });
  }
});

//Thông tin vé của khách hàng
app.post('/infovecuakhachhang', async (req, res) => {
  const { email, password } = req.body;
  try {
    const result = await client.query('SELECT lv.TenLoaiVe, v.NgayKichHoat, v.NgayHetHan, v.TrangThai FROM c_Ve v JOIN LoaiVe lv ON v.MaLoaiVe = lv.MaLoaiVe JOIN nguoidung nd ON v.Mand = nd.Mand  WHERE nd.Email = $1', [email]);
    if (result.rows.length > 0) {
      const account = result.rows[0];
      res.json({ success: true, account: account });
    } else {
      res.json({ success: false, message: "No user found with the provided credentials." });
    }
  } catch (error) {
    console.error('Error authenticating user:', error);
    res.status(500).json({ success: false, error: 'Error authenticating user' });
  }
});
app.listen(port, () => console.log(`Server is running on http://localhost:${port}`));