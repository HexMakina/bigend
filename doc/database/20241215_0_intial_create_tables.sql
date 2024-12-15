-- Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) CHARACTER SET utf8mb4 UNIQUE NOT NULL,
    password_hash VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- QR Codes Table
CREATE TABLE qr_codes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    code_identifier VARCHAR(255) CHARACTER SET utf8mb4 UNIQUE NOT NULL, -- Unique code for the QR proxy
    destination_url VARCHAR(2083) CHARACTER SET utf8mb4 NOT NULL, -- Default destination URL
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Redirection Rules Table
CREATE TABLE redirection_rules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    qr_code_id INT NOT NULL,
    condition_type ENUM('location', 'time', 'user_agent', 'language') CHARACTER SET utf8mb4 NOT NULL,
    condition_value VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL, -- e.g., country code, time range, language
    redirect_url VARCHAR(2083) CHARACTER SET utf8mb4 NOT NULL,
    FOREIGN KEY (qr_code_id) REFERENCES qr_codes(id) ON DELETE CASCADE
);

-- Scan Logs Table
CREATE TABLE scan_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    qr_code_id INT NOT NULL,
    scan_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45) CHARACTER SET utf8mb4, -- IPv4 or IPv6
    user_agent TEXT CHARACTER SET utf8mb4, -- Device/Browser information
    geolocation VARCHAR(255) CHARACTER SET utf8mb4, -- Country/City (if available)
    FOREIGN KEY (qr_code_id) REFERENCES qr_codes(id) ON DELETE CASCADE
);

-- Customizations Table
CREATE TABLE customizations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    qr_code_id INT NOT NULL,
    color VARCHAR(7) CHARACTER SET utf8mb4 DEFAULT '#000000', -- HEX color for QR code
    background_color VARCHAR(7) CHARACTER SET utf8mb4 DEFAULT '#FFFFFF',
    logo_url VARCHAR(2083) CHARACTER SET utf8mb4, -- URL of the logo image
    style ENUM('square', 'rounded', 'dots') CHARACTER SET utf8mb4 DEFAULT 'square',
    FOREIGN KEY (qr_code_id) REFERENCES qr_codes(id) ON DELETE CASCADE
);

-- Content Delivery Table
CREATE TABLE content_delivery (
    id INT AUTO_INCREMENT PRIMARY KEY,
    qr_code_id INT NOT NULL,
    content_type ENUM('file', 'media', 'webpage') CHARACTER SET utf8mb4 NOT NULL,
    content_url VARCHAR(2083) CHARACTER SET utf8mb4 NOT NULL, -- Proxy to restricted content
    FOREIGN KEY (qr_code_id) REFERENCES qr_codes(id) ON DELETE CASCADE
);
