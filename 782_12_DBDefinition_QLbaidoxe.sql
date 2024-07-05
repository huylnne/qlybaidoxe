--drop table nguoidung CASCADE;
--drop table nhanvien cascade;
--drop table c_ve cascade ;
--drop table loaive cascade ;
--drop table chitietravao cascade ;
--drop table baidoxe cascade ;
--drop table hoadonmuave cascade;
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
--ALTER TABLE c_Ve ADD CONSTRAINT FK_c_Ve_MaLoaiVe FOREIGN KEY(MaLoaiVe) REFERENCES LoaiVe(MaLoaiVe);
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


DO $$
DECLARE 
    i INTEGER;
BEGIN
    FOR i IN 1..10000 LOOP
        INSERT INTO NguoiDung (Email, MatKhau, HoTen, GioiTinh, NgSinh, DiaChi, QueQuan, SDT, VaiTro)
        VALUES (
            CONCAT('user', i, '@gmail.com'), 
            CONCAT('password', i), 
            CONCAT('User ', i), 
            CASE WHEN i % 2 = 0 THEN 'Nam' ELSE 'Nu' END, 
            DATE '1990-01-01' + (i % 365), 
            CONCAT('Address ', i), 
            CONCAT('City ', i), 
            LPAD(i::text, 10, '0'), 
            CASE WHEN i % 2 = 0 THEN 'Khach hang' ELSE 'Nhan vien' END
        );
    END LOOP;
END $$;


INSERT INTO BaiDoXe (DiaDiem, SoLuongXeToiDa, so_xe_con_lai)
VALUES 
('123 Parking Lot', 100000, 90000),
('456 Parking Lot', 50000, 45000),
('789 Parking Lot', 70000, 65000),
('101 Parking Lot', 80000, 75000),
('112 Parking Lot', 60000, 55000),
('131 Parking Lot', 90000, 85000),
('145 Parking Lot', 12000, 11500),
('167 Parking Lot', 11000, 10500),
('189 Parking Lot', 13000, 12500),
('200 Parking Lot', 14000, 13500);


COPY LoaiVe (MaLoaiVe,TenLoaiVe,GiaVe) FROM stdin WITH (FORMAT csv);
1,Ve luot xe may,3000
2,ve luot xe dap,2000
3,Ve tuan,25000
4,Ve thang,95000
5,Ve luot o to ,10000
\.

DO $$
DECLARE 
    i INTEGER;
BEGIN
    FOR i IN 1..10000 LOOP
        INSERT INTO c_Ve (MaND, NgayKichHoat, NgayHetHan, TrangThai)
        VALUES (
            i, 
            CURRENT_TIMESTAMP - (i % 365) * INTERVAL '1 day', 
            CURRENT_TIMESTAMP + (i % 365) * INTERVAL '1 day', 
            CASE 
                WHEN i % 3 = 1 THEN 'Dang su dung' 
                ELSE 'Da het han' 
            END
        );
    END LOOP;
END $$;


DO $$
DECLARE 
    i INTEGER;
    ThoiGianVao timestamp;
    ThoiGianRa timestamp;
    Biensoxe varchar(30);
    TenLoaixe varchar(20);
BEGIN
    FOR i IN 1..10000 LOOP
        ThoiGianVao := CURRENT_TIMESTAMP - (i % 365) * INTERVAL '1 day';
        ThoiGianRa := CURRENT_TIMESTAMP - (i % 364) * INTERVAL '1 day';
        Biensoxe := CONCAT('30A-', LPAD(i::text, 5, '0'));
        TenLoaixe := CASE WHEN i % 2 = 0 THEN 'Xe may' ELSE 'Xe oto' END;

        INSERT INTO ChiTietRaVao (ThoiGianVao, ThoiGianRa, MaND, MaTheKVL, MaBaiDoXe, Biensoxe, TenLoaixe)
        VALUES (ThoiGianVao, ThoiGianRa, i, i, (i % 10) + 1, Biensoxe, TenLoaixe);
    END LOOP;
END $$;



DO $$
DECLARE 
    i INTEGER;
BEGIN
    FOR i IN 1..10000 LOOP
        INSERT INTO HoaDonMuaVe (MaND, NgayHD, MaLoaiVe, SoLuongVe)
        VALUES (
            i, 
            CURRENT_TIMESTAMP - (i % 365) * INTERVAL '1 day', 
            (i % 5) + 1, 
            (i % 10) + 1
        );
    END LOOP;
END $$;

 

COPY NhanVien (MaNV,MaND,MaBaiDoXe) FROM stdin WITH (FORMAT csv);
1,1,1
2,2,2
3,3,3
4,4,4
5,5,5
6,6,6
7,7,7
8,8,8
9,9,9
10,10,10
\.





