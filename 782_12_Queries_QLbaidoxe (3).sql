
             Các câu lệnh truy vấn  

Vũ Minh Hiếu 

1. In ra độ tuổi trung bình của những khách hàng mua vé trong năm ngoái 

SELECT AVG(EXTRACT(YEAR FROM AGE(NOW(), nd.NgSinh))) AS DoTuoiTrungBinh 

FROM HoaDonMuaVe hd 

JOIN NguoiDung nd ON hd.MaND = nd.MaND 

WHERE DATE_PART('year', hd.NgayHD) = DATE_PART('year', CURRENT_DATE) - 1; 

2. Đưa ra số lượng mỗi loại vé được bán trong ngày hôm nay, sắp xếp giảm dần theo số lượng vé được bán  

SELECT lv.MaLoaiVe, lv.TenLoaiVe, SUM(hd.SoLuongVe) AS SoLuongBan 

FROM HoaDonMuaVe hd 

JOIN LoaiVe lv ON hd.MaLoaiVe = lv.MaLoaiVe 

WHERE DATE(hd.NgayHD) = CURRENT_DATE 

GROUP BY lv.MaLoaiVe, lv.TenLoaiVe 

ORDER BY SoLuongBan DESC; 

3. Đưa ra loại xe ra vào nhiều nhất trong ngày hôm nay ở bãi đỗ xe 123 Parking Lot 

SELECT TenLoaixe, COUNT(*) AS SoLanRaVao 

FROM ChiTietRaVao 

WHERE DATE(ThoiGianVao) = CURRENT_DATE 

  AND MaBaiDoXe IN ( 

    SELECT MaBaiDoXe 

    FROM BaiDoXe 

    WHERE DiaDiem = '123 Parking Lot ' 

  ) 

GROUP BY TenLoaixe 

ORDER BY SoLanRaVao DESC 

LIMIT 1; 

4. Đưa ra thời gian xe vào sớm nhất và muộn nhất tại bãi đỗ xe 123 Parking Lot  

SELECT MIN(ThoiGianVao) AS ThoiGianVaoSomNhat, MAX(ThoiGianVao) AS ThoiGianVaoMuonNhat 

FROM ChiTietRaVao 

WHERE MaBaiDoXe IN ( 

    SELECT MaBaiDoXe 

    FROM BaiDoXe 

    WHERE DiaDiem = '123 Parking Lot' 

); 

5. Đưa ra thời hạn vé còn lại của người dùng có email là Vuminhhieu10102004@gmail.com 

SELECT MaVe, NgayHetHan - CURRENT_TIMESTAMP AS ThoiHanConLai 

FROM c_Ve 

WHERE MaND = ( 

    SELECT MaND 

    FROM NguoiDung 

    WHERE Email = 'Vuminhhieu10102004@gmail.com' 

); 

6. Đưa ra thông tin của người dùng có biển số xe là 70A-142.87 

SELECT * 

FROM NguoiDung 

WHERE MaND IN ( 

    SELECT MaND 

    FROM ChiTietRaVao 

    WHERE Biensoxe = '70A-142.87' 

); 

7. Đưa ra danh sách người dùng đã hết hạn vé  

SELECT nd.* 

FROM NguoiDung nd 

JOIN c_Ve ve ON nd.MaND = ve.MaND 

WHERE ve.NgayHetHan < CURRENT_TIMESTAMP; 

8. Đưa ra doanh thu của tất cả các bãi đỗ xe trong năm ngoái  

SELECT bx.MaBaiDoXe, SUM(lv.GiaVe * hdmv.SoLuongVe) AS DoanhThu 

FROM BaiDoXe bx 

JOIN NhanVien nv ON bx.MaBaiDoXe = nv.MaBaiDoXe 

JOIN NguoiDung nd ON nv.MaND = nd.MaND 

JOIN HoaDonMuaVe hdmv ON nd.MaND = hdmv.MaND 

JOIN LoaiVe lv ON hdmv.MaLoaiVe = lv.MaLoaiVe 

WHERE EXTRACT(YEAR FROM hdmv.NgayHD) = EXTRACT(YEAR FROM CURRENT_DATE) - 1 

GROUP BY bx.MaBaiDoXe; 

 

9. In ra thời gian đã làm việc của nhân viên có tên là “Vu Minh Hieu” tính từ ngày đầu tiên làm việc đến hiện tại theo đơn vị ngày 

SELECT nd.HoTen,  

       date_trunc('day', CURRENT_DATE) - date_trunc('day', MIN(ThoiGianVao)) AS SoNgayLamViec 

FROM ChiTietRaVao c 

JOIN NguoiDung nd ON c.MaND = nd.MaND 

WHERE nd.HoTen = 'Vu Minh Hieu' 

GROUP BY nd.HoTen; 

 

10. Đưa ra thông tin bãi đỗ xe có nhiều lượt ra vào nhất năm ngoái  

SELECT bx.MaBaiDoXe, bx.DiaDiem, COUNT(*) AS SoLuotRaVao 

FROM BaiDoXe bx 

JOIN ChiTietRaVao ctrv ON bx.MaBaiDoXe = ctrv.MaBaiDoXe 

WHERE EXTRACT(YEAR FROM ctrv.ThoiGianVao) = EXTRACT(YEAR FROM CURRENT_DATE) - 1 

GROUP BY bx.MaBaiDoXe, bx.DiaDiem 

ORDER BY SoLuotRaVao DESC 

LIMIT 1; 

 

Lê Ngọc Huy 

1. Lấy danh sách các vé đã bán theo loại vé 

SELECT  

    lv.TenLoaiVe,  

    COUNT(hdmv.MaHD) AS SoLuongVeDaBan  

   FROM  

    LoaiVe lv 

    JOIN HoaDonMuaVe hdmv ON lv.MaLoaiVe = hdmv.maloaive 

GROUP BY  

    lv.TenLoaiVe; 

 

2.Liệt kê số xe tương ứng với từng loại xe đang đỗ trong bãi đỗ xe có diadiem là ‘123 Parking Lot’ 

SELECT   

    ctra.TenLoaiXe, 

    COUNT(*) AS SoLuongXe 

FROM   

    ChiTietRaVao ctra 

    INNER JOIN BaiDoXe bdx ON ctra.mabaidoxe = bdx.mabaidoxe 

WHERE   

    bdx.DiaDiem = '123 Parking Lot' 

    AND ctra.ThoiGianRa IS NULL 

GROUP BY   

    ctra.TenLoaiXe; 

3. Lấy danh sách các vé bán ra trong ngày hôm nay 

SELECT  

    hdmv.MaHD,  

    nd.Email,  

    lv.TenLoaiVe,  

    hdmv.ngayhd,  

    hdmv.soluongve,  

    lv.GiaVe,  

    (hdmv.soluongve * lv.GiaVe) AS TongTien  

FROM  

    HoaDonMuaVe hdmv 

    JOIN NguoiDung nd ON hdmv.MaND = nd.MaND 

    JOIN LoaiVe lv ON hdmv.maloaive = lv.MaLoaiVe 

WHERE  

    hdmv.ngayhd = CURRENT_DATE; 

 

 

4. Lấy tất cả khách hàng và vé của họ 

SELECT nd.MaND, nd.Email, nd.HoTen, ve.MaVe, lv.TenLoaiVe, lv.GiaVe, ve.NgayKichHoat, ve.NgayHetHan, ve.TrangThai 

FROM NguoiDung nd 

JOIN C_Ve ve using(mand) 

JOIN LoaiVe lv using(maloaive) 

WHERE nd.vaitro = 'Khach hang'; 

5.Lấy thông tin loại vé đã được bán nhiều nhất 

SELECT  

    lv.MaLoaiVe,  

    lv.TenLoaiVe,  

    SUM(hdmv.soluongve) AS TongSoLuongVeDaBan 

FROM  

    LoaiVe lv 

    JOIN HoaDonMuaVe hdmv ON lv.MaLoaiVe = hdmv.maloaive 

GROUP BY  

    lv.MaLoaiVe, lv.TenLoaiVe 

ORDER BY  

    TongSoLuongVeDaBan DESC 

LIMIT 1; 

  

6.In ra số chỗ trống còn lại của từng bãi đỗ xe 

select diadiem,so_xe_con_lai from baidoxe;  

7.Lấy chi tiết ra vào cho 1 bãi đỗ xe cụ thể  

SELECT * FROM ChiTietRaVao 

WHERE MaBaiDoXe = 1; -- Thay '1' bằng mã bãi đỗ xe cụ thể 

  

8.Tính xem hôm nay đã có tổng bao nhiêu khách vào tất cả các bãi đỗ 

SELECT COUNT(*) AS TongSoKhach 

FROM ChiTietRaVao 

WHERE ThoiGianVao::date = CURRENT_DATE; 

  

9. Lấy thông tin tất cả nhân viên làm việc tại một bãi đỗ xe cụ thể 

 SELECT nv.MaNV, nd.Email, nd.HoTen, bdx.DiaDiem 

FROM NhanVien nv 

JOIN NguoiDung nd ON nv.MaND = nd.MaND 

JOIN BaiDoXe bdx ON nv.mabaidoxe = bdx.MaBaiDoXe 

WHERE bdx.MaBaiDoXe = 1; -- Thay '1' bằng mã bãi đỗ xe cụ thể 

10.In ra số xe đang đỗ trong từng bãi đỗ xe 

--- 

SELECT (soluongxetoida-so_xe_con_lai) as so_xe_dang_do ,mabaidoxe,diadiem FROM baidoxe; 

-- 

 

 

Nguyễn Huy Hoàng   

In ra số lượng hóa đơn mua vé trong năm 2024 

SELECT COUNT(*) AS SoLuongHoaDonMuaVe 

FROM HoaDonMuaVe 

WHERE EXTRACT(YEAR FROM NgayHD) = 2024; 

Đếm số lượng xe máy có trong bãi đỗ xe có diadiem là ‘200 Parking Lot’. 

SELECT COUNT(*) AS TongSoLuongXeMay 

FROM ChiTietRaVao 

WHERE TenLoaixe = 'Xe may' 

AND MaBaiDoXe IN ( 

    SELECT MaBaiDoXe 

    FROM BaiDoXe 

    WHERE DiaDiem = '200 Parking Lot' 

); 

 

In ra số vé còn đang sử dụng của khách hàng.  

SELECT COUNT(*) AS SoLuongVeDangSuDung 

FROM c_Ve 

WHERE TrangThai = 'Dang su dung'; 

 

In ra danh sách hóa đơn mua vé chi tiết. 

SELECT  

    hd.MaHD,  

    nd.HoTen AS TenNguoiDung,  

    nd.Email,  

    nd.SDT,  

    hd.NgayHD,  

    lv.TenLoaiVe,  

    lv.GiaVe,  

    hd.SoLuongVe,  

    (lv.GiaVe * hd.SoLuongVe) AS TongTien 

FROM  

    HoaDonMuaVe hd 

JOIN  

    NguoiDung nd ON hd.MaND = nd.MaND 

JOIN  

    LoaiVe lv ON hd.MaLoaiVe = lv.MaLoaiVe; 

  

  

Đếm xem có bao nhiêu vé tháng được mua. 

SELECT COUNT(hd.MaHD) AS SoLuongVeThang 

FROM HoaDonMuaVe hd 

JOIN LoaiVe lv ON hd.MaLoaiVe = lv.MaLoaiVe 

WHERE lv.TenLoaiVe = 'Ve thang'; 

  

Đếm xem có bao nhiêu khách hàng đăng kí dịch vụ. 

SELECT COUNT(MaND) AS SoLuongKhachHang 

FROM NguoiDung 

WHERE VaiTro = 'Khach hang'; 

  

In ra bãi đỗ xe có nhiều chỗ trống nhất hiện tại. 

SELECT  

    MaBaiDoXe,  

    DiaDiem,  

    so_xe_con_lai 

FROM  

    BaiDoXe 

ORDER BY  

    so_xe_con_lai DESC 

LIMIT 1; 

  

In ra bãi đỗ xe có ít chỗ trống nhất hiện tại. 

SELECT  

    MaBaiDoXe,  

    DiaDiem,  

    so_xe_con_lai 

FROM  

    BaiDoXe 

ORDER BY  

    so_xe_con_lai ASC 

LIMIT 1; 

  

In ra bãi đỗ xe có hiệu suất sử dụng đang là lớn nhất hiện tại. 

SELECT  

    MaBaiDoXe,  

    DiaDiem,  

    so_xe_con_lai,  

    SoLuongXeToiDa, 

    (so_xe_con_lai::float / SoLuongXeToiDa) AS HieuSuat 

FROM  

    BaiDoXe 

ORDER BY  

    HieuSuat ASC 

LIMIT 1; 

 Đếm xem người dùng có địa chỉ ở đâu là đông nhất 

SELECT DiaChi, COUNT(*) AS SoLuongNguoiDung 

FROM NguoiDung 

GROUP BY DiaChi 

ORDER BY SoLuongNguoiDung DESC 

LIMIT 1; 

 

  
Function & Trigger

--1.Function xử lí  bãi đỗ xe khi có khách vào:   

CREATE OR REPLACE FUNCTION ThemChiTietVao() 

RETURNS TRIGGER AS $$ 

DECLARE 

    MaTheKVL_Available INT; 

    SoXeConLai INT; 

BEGIN 

    -- Lay so xe con lai trong bai 

    SELECT so_xe_con_lai INTO SoXeConLai 

    FROM BaiDoXe 

    WHERE MaBaiDoXe = NEW.MaBaiDoXe; 

  

    -- Kiem tra xem xe con cho khong 

    IF SoXeConLai <= 0 THEN 

        RAISE EXCEPTION 'Bãi đỗ xe đã đầy.'; 

    END IF; 

  

    -- Tim ma the kvl nho nhat 

IF NEW.mand IS NULL OR NEW.tenloaixe='Xe dap' THEN 

    WITH AvailableCards AS ( 

        SELECT generate_series(1, 10000) AS MaTheKVL 

        EXCEPT 

        SELECT MaTheKVL 

        FROM ChiTietRaVao 

        WHERE MaBaiDoXe = NEW.MaBaiDoXe AND ThoiGianRa IS NULL 

    ) 

    SELECT MIN(MaTheKVL) INTO MaTheKVL_Available 

    FROM AvailableCards; 

  

    NEW.MaTheKVL := MaTheKVL_Available; 

    NEW.ThoiGianVao := CURRENT_TIMESTAMP; 

END IF; 

  

    -- Cap nhat so luong xe con lai 

    UPDATE BaiDoXe 

    SET so_xe_con_lai = so_xe_con_lai - 1 

    WHERE MaBaiDoXe = NEW.MaBaiDoXe; 

  

    RETURN NEW; 

END; 

$$ LANGUAGE plpgsql; 

  

CREATE TRIGGER trg_xe_vao 

BEFORE INSERT ON ChiTietRaVao 

FOR EACH ROW 

EXECUTE FUNCTION ThemChiTietVao(); 

 

   

   

  


--2.Function xử lí khách ra:  

 CREATE OR REPLACE FUNCTION CapNhatKhiXeRa() 

RETURNS TRIGGER AS $$ 

BEGIN 

    NEW.MaTheKVL := NULL; 

  

    -- Cap nhat so xe con lai 

    UPDATE BaiDoXe 

    SET so_xe_con_lai = so_xe_con_lai + 1 

    WHERE MaBaiDoXe = NEW.MaBaiDoXe; 

  

    RETURN NEW; 

END; 

$$ LANGUAGE plpgsql; 

  

CREATE TRIGGER trg_xe_ra 

BEFORE UPDATE ON ChiTietRaVao 

FOR EACH ROW 

WHEN (OLD.ThoiGianRa IS NULL AND NEW.ThoiGianRa IS NOT NULL) 

EXECUTE FUNCTION CapNhatKhiXeRa(); 

 

   

  

 

--3:Function xử lý về vé khi có khách vãng lai vào 

CREATE OR REPLACE FUNCTION update_hoadonmuave_khachvanglai() 

RETURNS TRIGGER AS $$ 

DECLARE 

    ma_loai_ve INTEGER; 

BEGIN 

    IF NEW.TenLoaiXe = 'Xe dap' AND NEW.MaND IS NULL THEN 

        ma_loai_ve := 2; 

    ELSIF NEW.TenLoaiXe = 'Xe may' AND NEW.MaND IS NULL THEN 

        ma_loai_ve := 1; 

    ELSIF NEW.TenLoaiXe = 'O to' AND NEW.MaND IS NULL THEN 

        ma_loai_ve := 5; 

    ELSIF NEW.TenLoaiXe = 'Xe may' AND NEW.MaND IS NOT NULL THEN 

        ma_loai_ve := 1; 

    ELSIF NEW.TenLoaiXe = 'O to' AND NEW.MaND IS NOT NULL THEN 

        ma_loai_ve := 5; 

        RETURN NEW; 

    END IF; 

  

    IF ma_loai_ve IS NOT NULL THEN 

        INSERT INTO HoaDonMuaVe (MaND, NgayHD, MaLoaiVe, SoLuongVe) 

        VALUES (NEW.MaND, CURRENT_TIMESTAMP, ma_loai_ve, 1); 

    END IF; 

  

    RETURN NEW; 

END; 

$$ LANGUAGE plpgsql; 

  

CREATE TRIGGER trg_update_hoadonmuave_kvl 

AFTER INSERT ON ChiTietRaVao 

FOR EACH ROW 

EXECUTE FUNCTION update_hoadonmuave_khachvanglai(); 

 

--4.Function và trigger thêm nguoidung(đăng ký tài khoản) 

  

CREATE OR REPLACE FUNCTION them_nguoi_dung() 

RETURNS TRIGGER AS $$ 

DECLARE 

    v_email_count INT; 

BEGIN 

    -- Check if the email already exists 

    SELECT COUNT(*) INTO v_email_count 

    FROM NguoiDung 

    WHERE Email = NEW.Email; 

  

    IF v_email_count > 0 THEN 

        RAISE EXCEPTION 'Email "%" is already registered', NEW.Email; 

    END IF; 

  

    -- Check the role of the user 

    IF NEW.VaiTro = 'Nhan vien' THEN 

        -- Insert into NhanVien with the newly created MaND 

        INSERT INTO NhanVien (MaND) VALUES (NEW.MaND); 

    END IF; 

     

    RETURN NEW; 

END; 

$$ LANGUAGE plpgsql; 

  

CREATE TRIGGER trg_them_nguoi_dung 

BEFORE INSERT ON NguoiDung 

FOR EACH ROW 

EXECUTE FUNCTION them_nguoi_dung(); 

 

 

--5:Trigger cập nhật trạng thái vé khi them hoặc cập nhật ở bang c_ve 

  

 CREATE OR REPLACE FUNCTION update_ticket_status() 

RETURNS TRIGGER AS $$	 

BEGIN 

   

    IF NEW.NgayHetHan <= CURRENT_TIMESTAMP THEN 

        NEW.TrangThai := 'Da het han'; 

    ELSE 

        NEW.TrangThai := 'Dang su dung'; 

    END IF; 

  

    RETURN NEW; 

END; 

$$ LANGUAGE plpgsql; 

  

 trong C_Ve 

CREATE TRIGGER before_insert_or_update_on_c_ve 

BEFORE INSERT OR UPDATE ON C_Ve 

FOR EACH ROW 

EXECUTE FUNCTION update_ticket_status(); 

 

 

CREATE OR REPLACE FUNCTION update_all_ticket_statuses() 

RETURNS TRIGGER AS $$ 

BEGIN 

    PERFORM pg_catalog.set_config('session_replication_role', 'replica', false); 

  

    UPDATE C_Ve 

    SET TrangThai = CASE 

        WHEN NgayHetHan <= CURRENT_TIMESTAMP THEN 'Da het han' 

        ELSE 'Dang su dung' 

    END; 

  

    -- Kích hoạt lại trigger 

    PERFORM pg_catalog.set_config('session_replication_role', 'origin', false); 

  

    RETURN NULL;   

END; 

$$ LANGUAGE plpgsql; 

  

CREATE TRIGGER after_insert_or_update_on_c_ve 

AFTER INSERT OR UPDATE ON C_Ve 

FOR EACH STATEMENT 

EXECUTE FUNCTION update_all_ticket_statuses(); 

 

 

--6:Trigger khi thanh toán(mua vé tuần/ tháng) 

CREATE OR REPLACE FUNCTION them_hoa_don_va_ve() 

RETURNS TRIGGER AS $$ 

DECLARE 

    ngay_kich_hoat DATE; 

    ngay_het_han DATE; 

    tong_tien INTEGER; 

    gia_ve INTEGER; 

    ve_hien_tai RECORD; 

BEGIN 

    ngay_kich_hoat := CURRENT_DATE; 

    tong_tien := 0; 

  

    SELECT GiaVe INTO gia_ve FROM LoaiVe WHERE MaLoaiVe = NEW.MaLoaiVe; 

  

    SELECT * INTO ve_hien_tai FROM C_Ve 

    WHERE MaND = NEW.MaND AND TrangThai = 'Dang su dung' 

    ORDER BY NgayHetHan DESC LIMIT 1; 

  

    IF FOUND THEN 

        CASE 

            WHEN NEW.MaLoaiVe = 3 THEN 

                UPDATE C_Ve SET NgayHetHan = ve_hien_tai.NgayHetHan + INTERVAL '1 week' * NEW.soluongve 

                WHERE MaVe = ve_hien_tai.MaVe; 

            WHEN NEW.MaLoaiVe = 4 THEN 

                UPDATE C_Ve SET NgayHetHan = ve_hien_tai.NgayHetHan + INTERVAL '1 month' * NEW.soluongve 

                WHERE MaVe = ve_hien_tai.MaVe; 

            ELSE 

                UPDATE C_Ve SET NgayHetHan = ve_hien_tai.NgayHetHan + INTERVAL '1 day' * NEW.soluongve 

                WHERE MaVe = ve_hien_tai.MaVe; 

        END CASE; 

    ELSE 

        CASE 

            WHEN NEW.MaLoaiVe = 3 THEN 

                ngay_het_han := ngay_kich_hoat + INTERVAL '1 week' * NEW.soluongve; 

            WHEN NEW.MaLoaiVe = 4 THEN 

                ngay_het_han := ngay_kich_hoat + INTERVAL '1 month' * NEW.soluongve; 

            ELSE 

                ngay_het_han := ngay_kich_hoat; 

        END CASE; 

  

        INSERT INTO C_Ve (MaLoaiVe, MaND, NgayKichHoat, NgayHetHan, TrangThai) 

        VALUES (NEW.MaLoaiVe, NEW.MaND, ngay_kich_hoat, ngay_het_han, 'Dang su dung'); 

    END IF; 

  

    tong_tien := gia_ve * NEW.soluongve; 

  

    RAISE NOTICE 'So tien phai tra cho % ve loai % la: %', NEW.soluongve, NEW.MaLoaiVe, tong_tien; 

  

    RETURN NEW; 

END; 

$$ LANGUAGE plpgsql; 

  

CREATE TRIGGER trig_hoa_don_mua_ve 

AFTER INSERT ON HoaDonMuaVe 

FOR EACH ROW 

EXECUTE FUNCTION them_hoa_don_va_ve(); 

  

  

CREATE OR REPLACE FUNCTION kiem_tra_ve_cung_luc() 

RETURNS TRIGGER AS $$ 

BEGIN 

    IF EXISTS ( 

        SELECT 1 FROM C_Ve 

        WHERE MaND = NEW.MaND AND MaLoaiVe <> NEW.MaLoaiVe AND TrangThai = 'Dang su dung' 

    ) THEN 

        RAISE EXCEPTION 'Khach hang % khong the su dung cung luc hai loai ve.', NEW.MaND; 

    END IF; 

  

    RETURN NEW; 

END; 

$$ LANGUAGE plpgsql; 

  

CREATE TRIGGER trg_kiem_tra_ve_cung_luc 

BEFORE INSERT ON C_Ve 

FOR EACH ROW 

EXECUTE FUNCTION kiem_tra_ve_cung_luc(); 

 

--7:Funtion tính doanh thu của hệ thống trong 1 khoảng thời gian với 2 biến đầu vào là ngày bắt đầu và ngày kết thúc 

CREATE OR REPLACE FUNCTION total_sold(p_NgayBatDau DATE, p_NgayKetThuc DATE) RETURNS DECIMAL(20, 2) AS $$ 

DECLARE 

    doanh_thu DECIMAL(20, 2); 

BEGIN 

    SELECT  

        SUM(hdmv.soluongve * lv.GiaVe) AS doanh_thu 

    INTO  

        doanh_thu 

    FROM  

        HoaDonMuaVe hdmv 

        JOIN LoaiVe lv ON hdmv.maloaive = lv.MaLoaiVe 

    WHERE  

        hdmv.ngayhd BETWEEN p_NgayBatDau AND p_NgayKetThuc; 

  

    IF doanh_thu IS NULL THEN 

        RETURN 0; 

    ELSE 

        RETURN doanh_thu; 

    END IF; 

END; 

$$ LANGUAGE plpgsql; 



--INDEX

