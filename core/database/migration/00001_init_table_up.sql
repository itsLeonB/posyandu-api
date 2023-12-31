-- Users
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nik BIGINT NOT NULL UNIQUE,
    tempat_lahir VARCHAR(255) NOT NULL,
    tanggal_lahir DATE NOT NULL,
    alamat VARCHAR(255) NOT NULL,
    provinsi VARCHAR(255) NOT NULL,
    kota VARCHAR(255) NOT NULL,
    kecamatan VARCHAR(255) NOT NULL,
    kelurahan VARCHAR(255) NOT NULL,
    kode_pos INT NOT NULL,
    rt INT NOT NULL,
    rw INT NOT NULL,
    telepon VARCHAR(255) NOT NULL,
    role ENUM('admin', 'bidan', 'kader', 'remaja') NOT NULL,
    reset_token VARCHAR(255),
    reset_expire TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB;

-- Bidan
CREATE TABLE bidan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    jabatan ENUM('terampil, mahir, penyelia') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Posyandu
CREATE TABLE posyandu (
    id INT PRIMARY KEY AUTO_INCREMENT,
    bidan_id INT NOT NULL,
    nama VARCHAR(255) NOT NULL,
    alamat VARCHAR(255) NOT NULL,
    provinsi VARCHAR(255) NOT NULL,
    kota VARCHAR(255) NOT NULL,
    kecamatan VARCHAR(255) NOT NULL,
    kelurahan VARCHAR(255) NOT NULL,
    kode_pos INT NOT NULL,
    rt INT NOT NULL,
    rw INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (bidan_id) REFERENCES bidan(id) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Remaja
CREATE TABLE remaja (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    posyandu_id INT NOT NULL,
    nama_ayah VARCHAR(255) NOT NULL,
    nama_ibu VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (posyandu_id) REFERENCES posyandu(id) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Kader
CREATE TABLE kader (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Jadwal Posyandu
CREATE TABLE jadwal_posyandu (
    id INT PRIMARY KEY AUTO_INCREMENT,
    posyandu_id INT NOT NULL,
    waktu_mulai DATE NOT NULL,
    waktu_selesai DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (posyandu_id) REFERENCES posyandu(id) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Jadwal Penyuluhan
CREATE TABLE jadwal_penyuluhan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    posyandu_id INT NOT NULL,
    waktu_mulai DATE NOT NULL,
    waktu_selesai DATE NOT NULL,
    materi TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (posyandu_id) REFERENCES posyandu(id) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Pemeriksaan
CREATE TABLE pemeriksaan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    bidan_id INT NOT NULL,
    remaja_id INT NOT NULL,
    berat_badan FLOAT,
    tinggi_badan FLOAT,
    tekanan_darah FLOAT,
    lingkar_lengan FLOAT,
    tingkat_glukosa FLOAT,
    kadar_hemoglobin FLOAT,
    pemberian_fe BOOL NOT NULL,
    waktu_pengukuran DATE NOT NULL,
    kondisi_umum ENUM('baik', 'cukup', 'lemah') NOT NULL,
    keterangan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (bidan_id) REFERENCES bidan(id) ON DELETE CASCADE,
    FOREIGN KEY (remaja_id) REFERENCES remaja(id) ON DELETE CASCADE
) ENGINE = InnoDB;
