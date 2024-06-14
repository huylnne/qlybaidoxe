drop table nguoidung CASCADE;
drop table nhanvien cascade;
drop table c_ve cascade ;
drop table loaive cascade ;
drop table chitietravao cascade ;
drop table baidoxe cascade ;
drop table hoadonmuave cascade;
--
set datestyle to iso,mdy;
-- Tao bang NguoiDung
create table NguoiDung (
    MaND serial NOT NULL PRIMARY KEY,
    Email varchar(32) NOT NULL,
    MatKhau varchar(64) NOT NULL,
    HoTen varchar(50),
    GioiTinh varchar(3) CHECK (GioiTinh = 'Nam' or GioiTinh = 'Nu'),
    NgSinh Date,
    DiaChi varchar(256),
    QueQuan varchar(256),
    SDT varchar(10),
    VaiTro varchar(10) CHECK (VaiTro ='Khach hang' or VaiTro = 'Nhan vien')
);


-- Tao bang NhanVien
create table NhanVien  (
    MaNV serial NOT NULL PRIMARY KEY,
    MaND Integer NOT NULL,
    MaBaiDoXe Integer
);



-- Tao bang LoaiVe
create table LoaiVe(
    MaLoaiVe serial NOT NULL PRIMARY KEY,
    TenLoaiVe varchar(30),
    GiaVe Integer
);

-- Tao bang Ve
create table c_Ve(
    MaVe serial NOT NULL PRIMARY KEY,
    MaLoaiVe Integer,
    MaND Integer,
    NgayKichHoat timestamp,
    NgayHetHan timestamp,
    TrangThai Varchar(30) CHECK (TrangThai in ('Chua kich hoat', 'Dang su dung', 'Da het han'))
);


-- Tao bang ChiTietRaVao
create table ChiTietRaVao(
    MaCTRaVao serial NOT NULL PRIMARY KEY,
    ThoiGianVao timestamp,
    ThoiGianRa timestamp,
    MaND Integer,
    MaTheKVL Integer,
    MaBaiDoXe Integer,
    Biensoxe varchar(30),
    TenLoaixe varchar(20)
);


-- Tao bang HoaDonMuaVe
create table HoaDonMuaVe(
    MaHD serial NOT NULL PRIMARY KEY,
    MaND Integer,
    NgayHD timestamp,
    MaLoaiVe Integer NOT NULL,
    SoLuongVe Integer
);

-- Tao bang BaiDoXe
create table BaiDoXe(
    MaBaiDoXe serial NOT NULL PRIMARY KEY,
    DiaDiem varchar(30),
    SoLuongXeToiDa Integer,
    so_xe_con_lai Integer
);

-- Tao khoa ngoai

-- FK CUA NhanVien
ALTER TABLE NhanVien ADD CONSTRAINT FK_NhanVien_MaND FOREIGN KEY(MaND) REFERENCES NguoiDung(MaND);


-- FK CUA c_Ve 
ALTER TABLE c_Ve ADD CONSTRAINT FK_c_Ve_MaLoaiVe FOREIGN KEY(MaLoaiVe) REFERENCES LoaiVe(MaLoaiVe);
ALTER TABLE c_Ve ADD CONSTRAINT FK_c_Ve_MaND FOREIGN KEY(MaND) REFERENCES NguoiDung(MaND);


-- FK CUA ChiTietRaVao
ALTER TABLE ChiTietRaVao ADD CONSTRAINT FK_CTRaVao_MaND FOREIGN KEY(MaND) REFERENCES NguoiDung(MaND);
ALTER TABLE ChiTietRaVao ADD CONSTRAINT FK_CTRaVao_MaBaiDoXe FOREIGN KEY(MaBaiDoXe) REFERENCES BaiDoXe(MaBaiDoXe);



-- FK CUA HoaDonMuaVe
ALTER TABLE HoaDonMuaVe ADD CONSTRAINT FK_HoaDonMuaVe_MaND FOREIGN KEY(MaND) REFERENCES NguoiDung(MaND);
ALTER TABLE HoaDonMuaVe ADD CONSTRAINT FK_HoaDonMuaVe_Loaive FOREIGN KEY(MaLoaiVe) references loaive(MaLoaiVe);


-- Fk CUA BaiDoXe
ALTER TABLE BaiDoXe ADD CONSTRAINT FK_BaiDoXe_NV FOREIGN KEY(MaBaiDoXe) REFERENCES NhanVien(MaBaiDoXe);


--insert data


COPY NguoiDung (MaND,Email,MatKhau,HoTen,GioiTinh,NgSinh,DiaChi,QueQuan,SDT,VaiTro) FROM stdin WITH (FORMAT csv);
1,admin1@gmail.com,xihhtcuf,Nguyen Nhat Minh,Nam,9/20/1986,Ha Noi,TP.HCM,363598475,Nhan vien
2,admin2@gmail.com,xibyvqji,Le Van Loi,Nam,06/03/1982,Ha Noi,Binh Duong,865962547,Nhan vien
3,admin3@gmail.com,lwhxhtxm,Ho Van Sang,Nam,12/29/1990,Ha Noi,Dong Nai,775696358,Nhan vien
4,admin4@gmail.com,auwodhsk,Vu Minh Hieu,Nam,10/10/2004,Ha Noi,Ha Noi,971096507,Nhan vien
5,admin5@gmail.com,nvdkslua,Nguyen Huy Hoang,Nam,02/02/2004,Ha Noi,Ha Noi,984844748,Nhan vien
6,admin6@gmail.com,apflsxms,Le Ngoc Huy,Nam,01/01/2004,Ha Noi,Ha Noi,394114844,Nhan vien
7,admin6@gmail.com,zlqiwpds,Le Minh Nghia,Nam,09/10/2004,Ha Noi,Ha Noi,495115854,Nhan vien
8,20521092@gm.uit.edu.vn,kfgoqxoh,Nguyen Thi Thao Hong,Nu,6/14/2002,Ha Noi,Quang Nam,334586738,Khach hang
9,20520267@gm.uit.edu.vn,cqocyppq,Tran Thi My Nhung,Nu,10/20/2002,Ha Noi,Da Lat,368909827,Khach hang
10,20520270@gm.uit.edu.vn,wgodpoqp,Nguyen Thanh Phat,Nam,9/26/2002,Ha Noi,Tien Giang,776695664,Khach hang
11,20520295@gm.uit.edu.vn,pqofcoce,Do Thao Quyen,Nu,3/27/2002,Ha Noi,Binh Duong,869055450,Khach hang
12,20520299@gm.uit.edu.vn,lpowpbro,Nguyen Duy Tai,Nam,12/18/2002,Ha Noi,TP. HCM,335586347,Khach hang
13,20520368@gm.uit.edu.vn,jlgqvxfn,Pham Le Diu Ai,Nu,12/14/2002,Ha Noi,TP. HCM,868247806,Khach hang
14,20520418@gm.uit.edu.vn,qwbfxqmt,Dang Nghiep Cuong,Nam,8/17/2002,Ha Noi,Binh Duong,332743065,Khach hang
15,20520434@gm.uit.edu.vn,idfwornr,Nguyen Dat,Nam,05/10/2002,Ha Noi,Lam Dong,335163136,Khach hang
16,20520811@gm.uit.edu.vn,adnnkwvb,Tran Trong Tin,Nam,01/01/2002,Ha Noi,TP. HCM,836646035,Khach hang
17,20520881@gm.uit.edu.vn,wsetesqk,Pham Hoang Ngoc Anh,Nu,06/04/2002,Ha Noi,Bao Loc,327486284,Khach hang
18,20521083@gm.uit.edu.vn,yosfjclb,Tran Thi Ngoc Anh,Nu,1/20/2002,Ha Noi,Quang Tri,363961281,Khach hang
19,20521569@gm.uit.edu.vn,iqqvphll,Nguyen Huu Long,Nam,12/14/2002,Ha Noi,Quang Tri,775504619,Khach hang
20,20522109@gm.uit.edu.vn,lpbrqgkk,Ha Danh Tuan,Nam,10/12/2002,Ha Noi,Dong Nai,327412125,Khach hang
21,20521538@gm.uit.edu.vn,wsgggyrl,Tran Ngoc Linh,Nu,01/01/2002,Ha Noi,Da Lat,397764027,Khach hang
22,20521933@gm.uit.edu.vn,abmayfxa,Nguyen Ngoc Thao,Nu,2/16/2002,Ha Noi,Binh Duong,352811100,Khach hang
23,20521110@gm.uit.edu.vn,dpjewumn,Tran Quoc Bao,Nam,7/31/2002,Ha Noi,Dak Lak,898364793,Khach hang
24,20521075@gm.uit.edu.vn,mwrucrtw,Nguyen Van Anh,Nu,4/30/2002,Ha Noi,Nghe An,392915987,Khach hang
25,23eui2@jkdsf.asss,abcde,Le Van Vu,Nam,03/04/2001,Ha Noi,Ha Tinh,128372888,Nhan vien
\.


COPY BaiDoXe (MaBaiDoXe,DiaDiem,SoLuongXeToiDa,so_xe_con_lai) FROM stdin WITH (FORMAT csv);
1, DaiHocBachKhoa, 300, 300
2, DaiHocKinhTeQuocDan, 150, 150
3, DaiHocXayDung, 100, 100
4, DaiHocCongNghe, 80, 80
5, DaiHocNgoaiNgu, 200, 200
6, DaiHocNgoaiThuong, 50, 50
\.

COPY LoaiVe (MaLoaiVe,TenLoaiVe,GiaVe) FROM stdin WITH (FORMAT csv);
1,Ve luot xe may,3000
2,ve luot xe dap,2000
3,Ve tuan,25000
4,Ve thang,95000
5,Ve luot o to ,10000
\.

COPY c_ve (MaVe,MaLoaiVe,MaND,NgayKichHoat,NgayHetHan,TrangThai) FROM stdin WITH (FORMAT csv);
1,4,1,5/30/2023 9:26,9/22/2023 9:26,Dang su dung
2,1,2,01/06/2023 10:00,06/09/2023 10:00,Da het han
3,1,6,10/26/2023 7:45,02/10/2024 7:45,Dang su dung
4,2,3,9/25/2023 8:25,1/31/2024 8:25,Da het han
5,3,5,1/21/2024 9:30,06/05/2023 9:30,Dang su dung
6,2,4,9/25/2023 6:00,3/13/2024 6:00,Dang su dung
7,3,7,07/02/2023 17:15,11/19/2023 17:15,Dang su dung
8,4,8,12/12/2023 11:45,03/06/2024 11:45,Da het han
9,2,9,11/28/2023 6:30,7/22/2023 6:30,Dang su dung
10,2,10,06/03/2023 16:00,11/16/2023 16:00,Da het han
11,3,11,06/03/2023 6:15,4/26/2024 6:15,Dang su dung
12,1,12,08/12/2023 9:30,11/11/2023 9:30,Dang su dung
\.

COPY ChiTietRaVao (MaCTRaVao,ThoiGianVao,ThoiGianRa,MaND,MaTheKVL,MaBaiDoXe,Biensoxe,TenLoaiXe) FROM stdin WITH (FORMAT csv);
1,6/1/2022 19:00,6/1/2022 21:30,1,,1,59A-789.90,Xe may
2,6/1/2022 7:01,6/1/2022 10:45,2,,2,,Xe dap
3,6/1/2022 7:05,6/1/2022 9:30,3,,2,49A-780.90,Xe may
4,6/1/2022 7:06,6/1/2022 11:10,4,,5,,
5,2022/6/1/ 7:15,6/1/2022 3:35,5,,5,72A-115.34,Xe may
6,6/1/2022 1:00,6/1/2022 5:02,7,,1,72A-765.42,Xe may
7,6/1/2022 1:01,6/1/2022 5:05,6,,4,,
8,6/1/2022 1:05,6/1/2022 4:59,8,,2,,
9,6/1/2022 2:15,6/1/2022 4:45,9,,5,59A-545.87,Xe may
10,6/1/2022 2:15,6/1/2022 5:14,10,,5,,Xe dap
11,6/2/2022 7:16,6/2/2022 10:45,11,,3,,Xe dap
12,6/2/2022 7:25,6/2/2022 10:48,12,,4,,
13,6/2/2022 7:45,6/2/2022 11:14,14,,1,58A-423.60,Xe may
14,6/2/2022 8:15,6/2/2022 3:15,13,,5,51A-455.88,Xe may
15,6/2/2022 9:15,6/2/2022 3:45,16,,1,70A-142.87,Xe may
16,6/2/2022 11:30,6/2/2022 4:16,15,,3,66A-429.06,Xe may
17,6/2/2022 12:02,6/2/2022 4:15,18,,1,70A-142.87,Xe may
18,6/2/2022 12:45,6/2/2022 5:15,17,,1,,Xe dap
19,6/2/2022 1:05,6/2/2022 5:19,19,,1,72A-765.42,Xe may
20,6/2/2022 2:30,6/2/2022 5:20,20,,5,,
\.

COPY HoaDonMuaVe (MaHD,MaND,NgayHD,MaLoaiVe,SoLuongVe) FROM stdin WITH (FORMAT csv);
1,1,01/02/2022 19:10,1,2
2,2,5/20/2022 8:00,2,1
3,3,05/10/2022 9:35,3,2
4,4,5/17/2022 23:15,1,1
5,5,5/20/2022 14:56,1,2
6,6,06/07/2022 20:15,2,1
7,7,06/01/2022 0:01,4,1
8,8,06/04/2022 20:15,2,2
9,9,5/15/2022 16:52,1,1
10,10,06/03/2022 14:15,3,2
11,11,06/01/2022 1:25,2,1
12,12,06/07/2022 20:15,1,2
13,13,5/14/2022 19:56,4,1
14,14,06/03/2022 8:56,3,2
15,15,5/19/2022 14:52,1,1
16,16,06/03/2022 23:25,2,2
17,17,06/07/2022 0:02,3,1
18,18,06/04/2022 15:17,1,2
19,19,06/09/2022 0:02,1,1
20,20,5/26/2022 20:26,3,1
21,21,06/07/2022 19:36,2,1
22,22,06/07/2022 20:58,1,1
23,23,5/23/2022 23:14,2,1
24,24,06/03/2022 14:56,4,1
25,25,4/25/2022 20:15,4,1
\.

 

COPY NhanVien (MaNV,MaND,MaBaiDoXe) FROM stdin WITH (FORMAT csv);
1,1,1
2,2,2
3,3,3
4,4,4
5,5,5
6,6,6
7,7,7
\.




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

    v_mand INT; 

BEGIN 

    -- Kiem tra vai tro cua nguoi dung 

    IF NEW.VaiTro = 'Nhan vien' THEN 

        -- Lay MaND vua duoc chen vao 

        v_mand := NEW.MaND; 

        -- Chen vao bang NhanVien voi MaND vua duoc tao 

        INSERT INTO NhanVien (MaND) VALUES (v_mand); 

    END IF; 

    RETURN NEW; 

END; 

$$ LANGUAGE plpgsql; 

CREATE TRIGGER trg_them_nguoi_dung 

AFTER INSERT ON NguoiDung 

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

 insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
 insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
 insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
 insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
 insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);
insert into hoadonmuave(mand,ngayhd,maloaive,soluongve) values(1,now(),3,2);



insert into c_ve(maloaive,mand,ngaykichhoat) values(2,7,now());
insert into c_ve(maloaive,mand,ngaykichhoat) values(2,7,now());
insert into c_ve(maloaive,mand,ngaykichhoat) values(2,7,now());
insert into c_ve(maloaive,mand,ngaykichhoat) values(2,7,now());
insert into c_ve(maloaive,mand,ngaykichhoat) values(2,7,now());
insert into c_ve(maloaive,mand,ngaykichhoat) values(2,7,now());

insert into c_ve(maloaive,mand,ngaykichhoat) values(2,7,now());
insert into c_ve(maloaive,mand,ngaykichhoat) values(2,7,now());
insert into c_ve(maloaive,mand,ngaykichhoat) values(2,7,now());

insert into c_ve(maloaive,mand,ngaykichhoat) values(2,7,now());
insert into c_ve(maloaive,mand,ngaykichhoat) values(2,7,now());
insert into c_ve(maloaive,mand,ngaykichhoat) values(2,7,now());



insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');
insert into nguoidung(email,matkhau,hoten,gioitinh,ngsinh,diachi,quequan,sdt,vaitro) values('abc@gmail.xyz','12333','Hoang ngu lam','Nu','2004-01-01','Hung Yen','Hung Yen','09998887','Khach hang');


insert into nhanvien(mand) values(27);
insert into nhanvien(mand) values(27);
insert into nhanvien(mand) values(27);
insert into nhanvien(mand) values(27);
insert into nhanvien(mand) values(27);
insert into nhanvien(mand) values(27);
insert into nhanvien(mand) values(27);


insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');
insert into chitietravao(thoigianvao,mabaidoxe,tenloaixe) values(now(),1,'Xe dap');





