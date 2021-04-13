-- Tao database ThucTap

DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;

-- tạo table 1 GiangVien

DROP TABLE IF EXISTS GiangVien;
CREATE TABLE GiangVien (
	 magv			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
     hoten			VARCHAR(50) NOT NULL,
     luong			INT UNSIGNED NOT NULL
    );
    
-- tạo table 2 SinhVien

DROP TABLE IF EXISTS SinhVien;
CREATE TABLE SinhVien (
	 masv			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
     hoten			VARCHAR(50) NOT NULL,
     namsinh		DATE NOT NULL,
     quequan		VARCHAR(100) NOT NULL
    );
    
-- tạo table 3 Detai

DROP TABLE IF EXISTS DeTai;
CREATE TABLE DeTai (
	 madt			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
     tendt			VARCHAR(100) NOT NULL UNIQUE KEY,
     kinhphi		INT UNSIGNED NOT NULL,
     NoiThucTap		VARCHAR(100) NOT NULL
    );
    
-- tạo table 4 HuongDan

 DROP TABLE IF EXISTS HuongDan;
CREATE TABLE HuongDan (
	 id 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
     masv			SMALLINT UNSIGNED,
     madt			TINYINT	UNSIGNED,
     magv			TINYINT UNSIGNED,
     ketqua			ENUM ('F','T') NOT NULL
    );
    
    
-- Insert data vào bảng GiangVien

INSERT INTO GiangVien			(	HoTen		, 		luong		)
VALUES							( 'GiangVien1'	, 		11000000 	),
								( 'GiangVien2'	, 		22000000 	),
                                ( 'GiangVien3'	, 		14000000 	),
                                ( 'GiangVien4'	, 		15000000 	),
                                ( 'GiangVien5'	, 		18000000 	),
                                ( 'GiangVien6'	, 		21000000 	),
                                ( 'GiangVien7'	, 		19000000 	),
                                ( 'GiangVien8'	, 		20000000 	),
                                ( 'GiangVien9'	, 		15000000 	),
                                ( 'GiangVien10'	, 		17000000 	);
                                
-- Insert data vào bảng SinhVien

INSERT INTO SinhVien			(	hoten		,		namsinh		, 	quequan		)
VALUES							( 'Sinhvien1'   ,	'2000-01-18'	, 'Address1'	),
								( 'Sinhvien2'   ,	'1999-02-21'	, 'Address2'	),
                                ( 'Sinhvien3'   ,	'2001-07-12'	, 'Address3'	),
                                ( 'Sinhvien4'   ,	'1995-01-18'	, 'Address4'	),
                                ( 'Sinhvien5'   ,	'1997-01-18'	, 'Address1'	),
                                ( 'Sinhvien6'   ,	'1994-01-18'	, 'Address2'	),
                                ( 'Sinhvien7'   ,	'1992-01-18'	, 'Address5'	),
                                ( 'Sinhvien8'   ,	'2001-01-18'	, 'Address6'	),
                                ( 'Sinhvien9'   ,	'1994-01-18'	, 'Address7'	),
                                ( 'Sinhvien10'  ,	'1998-01-18'	, 'Address6'	);
                                
-- Insert data vào bảng detai

INSERT INTO DeTai				(	tendt					,		kinhphi		,	NoiThucTap	  )
VALUES							( 'Cong_Nghe_Sinh_Học'      ,	    10000000 	,   'Noithuctap1' ),
								( 'tendt2'      			,	    12000000 	,   'Noithuctap2' ),
                                ( 'tendt3'     				,	    13000000 	,   'Noithuctap3' ),
                                ( 'tendt4'      			,	    15000000 	,   'Noithuctap4' ),
                                ( 'tendt5'      			,	    18000000 	,   'Noithuctap5' ),
                                ( 'tendt6'      			,	    21000000 	,   'Noithuctap6' ),
                                ( 'tendt7'      			,	    28000000 	,   'Noithuctap7' ),
                                ( 'tendt8'      			,	    11000000 	,   'Noithuctap8' );
                                
-- Insert data vào bảng Huongdan

INSERT INTO HuongDan 			(	masv		,		madt		,	magv		,	ketqua)
VALUES							(	1			,		  1			,	2			, 	'T'	  ),
								(	2			,		  2			,	1			, 	'F'	  ),
                                (	3			,		  1			,	2			, 	'T'	  ),
                                (	4			,		  3			,	3			, 	'T'	  ),
                                (	5			,		  5			,	5			, 	'F'	  ),
                                (	6			,		  7			,	6			, 	'F'	  ),
                                (	7			,		  8			,	7			, 	'T'	  ),
                                (	8			,		  6			,	9			, 	'F'	  ),
                                (	9			,		  2			,	10			, 	'T'	  ),
                                (	10			,		  1			,	4			, 	'T'	  );
                                
-- Lấy tất cả các sinh viên chưa có đề tài hướng dẫn

SELECT * FROM thuctap.sinhvien;
SELECT s.masv, s.hoten
FROM sinhvien s 
LEFT JOIN huongdan hd 
ON s.masv = hd.masv
WHERE hd.masv IS NULL;



-- Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC’

SELECT * FROM thuctap.huongdan;
SELECT dt.tendt, COUNT(1) AS SLHS FROM huongdan hd
INNER JOIN sinhvien s ON hd.masv = s.masv
INNER JOIN detai dt ON hd.madt = dt.madt
WHERE dt.tendt = 'Cong_Nghe_Sinh_Học';


-- Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm: mã số, họ tên và tên đề tài (Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")
SELECT * FROM thuctap.huongdan;
CREATE VIEW view_SinhVienInfo AS (
	SELECT s.masv, s.hoten, dt.tendt FROM huongdan hd
		INNER JOIN sinhvien s ON hd.masv = s.masv
		INNER JOIN detai dt ON hd.madt = dt.madt)
	UNION
	(SELECT s.masv, s.hoten, 'Chua Co' FROM sinhvien s
		LEFT JOIN huongdan hd ON s.masv = hd.masv
		WHERE hd.masv IS NULL);

SELECT * FROM view_SinhVienInfo;

-- Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900 thì hiện ra thông báo "năm sinh phải > 1900"


DROP TRIGGER IF EXISTS TrG_CheckYearBeforeInsert;
DELIMITER $$
CREATE TRIGGER TrG_CheckYearBeforeInsert
BEFORE INSERT ON sinhvien
FOR EACH ROW
BEGIN

	IF (year(NEW.namsinh) <=1900) THEN

	SIGNAL SQLSTATE '12345'

	SET MESSAGE_TEXT = "năm sinh phải > 1900";

	END IF;
END$$
DELIMITER ;

INSERT INTO sinhvien (	hoten			, 		namsinh			,	 quequan)
VALUES 				(	'Sinhvien11'	, '1899-01-01 00:00:00' , 	'Address2');

-- Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó thì sẽ tất cả thông tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi



