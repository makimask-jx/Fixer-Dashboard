-- =====================================================
-- TABLE CREATION (Required for FK integrity)
-- =====================================================
-- Table: FABRICANTE (Cyberware Manufacturers)
CREATE TABLE IF NOT EXISTS `FABRICANTE` (
    `id` BIGINT PRIMARY KEY,
    `nombre` VARCHAR(255),
    `pais_origen` VARCHAR(100),
    `especialidad` VARCHAR(255)
);
-- Table: SECTOR (Corporate Sectors - standalone)
CREATE TABLE IF NOT EXISTS `SECTOR` (
    `id` BIGINT PRIMARY KEY,
    `nombre` VARCHAR(100),
    `descripcion` VARCHAR(255)
);
-- Table: HISTORIAL (Mercenary History Records)
CREATE TABLE IF NOT EXISTS `HISTORIAL` (
    `id` BIGINT PRIMARY KEY,
    `mercenario_id` BIGINT,
    `evento` VARCHAR(255),
    `fecha` DATE,
    `tipo` VARCHAR(50)
);
-- Table: IMPLANTE (Detailed Implant Records)
CREATE TABLE IF NOT EXISTS `IMPLANTE` (
    `id` BIGINT PRIMARY KEY,
    `mercenario_id` BIGINT,
    `nombre_implante` VARCHAR(255),
    `fabricante_id` BIGINT,
    `nivel_rango` INT
);
CREATE TABLE IF NOT EXISTS `DISTRITO` (
    `id` BIGINT PRIMARY KEY,
    `nombre` VARCHAR(255),
    `poblacion` BIGINT,
    `seguridad_corpo` TINYINT(1),
    `pobreza` DECIMAL(10, 2)
);
-- Section: District Data
CREATE TABLE IF NOT EXISTS `DISTRITO_POBREZA` (
    `id` BIGINT PRIMARY KEY,
    `id_distrito` BIGINT,
    `fecha` DATE,
    `pobreza_porcentaje` INT
);
CREATE TABLE IF NOT EXISTS `DISTRITO_POBLACION` (
    `id` BIGINT PRIMARY KEY,
    `id_distrito` BIGINT,
    `fecha` DATE,
    `poblacion` INT
);
CREATE TABLE IF NOT EXISTS `CEO` (
    `id` BIGINT PRIMARY KEY,
    `nombre` VARCHAR(40),
    `descripcion` VARCHAR(255),
    `fecha_nacimiento` DATE,
    `inicio_cargo` DATE,
    `vivo` TINYINT(1)
);
CREATE TABLE IF NOT EXISTS `CORPO` (
    `cif` BIGINT PRIMARY KEY,
    `nombre` VARCHAR(255),
    `id_sector` BIGINT,
    -- Changed to BIGINT to match CORPO_SECTOR PK
    `sede_central` BIGINT,
    `valor_mercado` DECIMAL(20, 2),
    `ejercito` TINYINT(1),
    `id_ceo` BIGINT
);
CREATE TABLE IF NOT EXISTS `CORPO_SECTOR` (
    `cif` BIGINT,
    `nombre` VARCHAR(40),
    PRIMARY KEY (`cif`, `nombre`)
);
CREATE TABLE IF NOT EXISTS `CORPO_VALOR_MERCADO` (
    `id` BIGINT PRIMARY KEY,
    `corpo_cif` BIGINT,
    `valor` DECIMAL(20, 2),
    `fecha` TIMESTAMP,
    `fuente` VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS `MERCENARIO` (
    `id` BIGINT PRIMARY KEY,
    `alias` VARCHAR(40),
    `descripcion` VARCHAR(255),
    `id_categoria` BIGINT,
    -- Changed to BIGINT to match CATEGORIA PK
    `id_distrito` BIGINT,
    -- Changed to BIGINT to match DISTRITO PK
    `street_cred` INT,
    `imagen` TEXT,
    `historial` BIGINT,
    `implante` BIGINT,
    `telefono` INT,
    `estado` VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS `MERCENARIO_CYBERWARE` (
    `id_mercenario` BIGINT,
    `id_cyberware` BIGINT,
    PRIMARY KEY (`id_mercenario`, `id_cyberware`)
);
CREATE TABLE IF NOT EXISTS `MERCENARIO_CATEGORIA` (
    `id_categoria` BIGINT,
    `categoria` VARCHAR(40),
    PRIMARY KEY (`id_categoria`, `categoria`)
);
CREATE TABLE IF NOT EXISTS `MERCENARIO_STREETCRED` (
    `id_mercenario` BIGINT,
    `streetcred` BIGINT,
    PRIMARY KEY (`id_mercenario`, `streetcred`)
);
CREATE TABLE IF NOT EXISTS `MERCENARIO_TELEFONO` (
    `id_mercenario` BIGINT,
    `telefono` INT,
    PRIMARY KEY (`id_mercenario`, `telefono`)
);
CREATE TABLE IF NOT EXISTS `FIXER` (
    `id` BIGINT PRIMARY KEY,
    `alias` VARCHAR(40),
    `descripcion` VARCHAR(255),
    `distrito` BIGINT,
    -- Changed to BIGINT to match DISTRITO PK
    `foto_perfil` TEXT,
    `contrasena_hash` VARCHAR(255),
    `estado` VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS `ENCARGO` (
    `id` BIGINT PRIMARY KEY,
    `id_fixer` BIGINT,
    `id_mercenario` BIGINT,
    `titulo` VARCHAR(100),
    `descripcion` VARCHAR(255),
    `resultado` VARCHAR(40)
);
CREATE TABLE IF NOT EXISTS `CYBERWARE` (
    `id` BIGINT PRIMARY KEY,
    `nombre` VARCHAR(255),
    `modelo` VARCHAR(100),
    `id_fabricante` BIGINT,
    `precio` DECIMAL(20, 2),
    `grado` INT,
    FOREIGN KEY (`id_fabricante`) REFERENCES `FABRICANTE`(`id`)
);
-- =====================================================
-- INSERTS FOR MISSING TABLES
-- =====================================================
-- Insertions for FABRICANTE (20 records)
INSERT INTO `FABRICANTE` (id, nombre, pais_origen, especialidad)
VALUES (
        1,
        'Arasaka',
        'Japan',
        'Military-grade cybernetics and neural interfaces'
    ),
    (
        2,
        'Militech',
        'USA',
        'Combat implants and weapon systems'
    ),
    (
        3,
        'Kiroshi',
        'Japan',
        'Optical scanners and visual enhancements'
    ),
    (
        4,
        'Trauma Team',
        'Global',
        'Medical cyberware and emergency systems'
    ),
    (
        5,
        'Zetatech',
        'Japan',
        'Neural processors and memory augmentation'
    ),
    (
        6,
        'Biotechnica',
        'USA',
        'Genetic modifications and biological enhancements'
    ),
    (
        7,
        'Tyger Claws',
        'Japan',
        'Street-level augmentations'
    ),
    (
        8,
        'Maelstrom',
        'Night City',
        'Experimental and aggressive cyberware'
    ),
    (
        9,
        'Ripperdoc Collective',
        'Night City',
        'Custom modification services'
    ),
    (
        10,
        'Petrochem',
        'Russia',
        'Industrial and environmental protection'
    ),
    (
        11,
        'Kang Tao',
        'China',
        'AI-assisted cybernetics'
    ),
    (
        12,
        'Katsuo',
        'Japan',
        'Stealth and reconnaissance implants'
    ),
    (
        13,
        'Synapse',
        'Germany',
        'Neural network integration'
    ),
    (
        14,
        'Vexor',
        'Night City',
        'Black market modifications'
    ),
    (
        15,
        'Cyberdyne Systems',
        'USA',
        'Advanced robotics integration'
    ),
    (
        16,
        'NCPD Tech',
        'Night City',
        'Law enforcement grade implants'
    ),
    (
        17,
        'MaxTac Division',
        'Night City',
        'Psychopath containment tech'
    ),
    (
        18,
        'Alt Cunningham Corp',
        'Net',
        'Netrunning and AI interface'
    ),
    (
        19,
        'Hanako Enterprises',
        'Japan',
        'Corporate espionage tools'
    ),
    (
        20,
        'Valentinos Tech',
        'Mexico',
        'Cultural enhancement implants'
    );
-- Insertions for SECTOR (20 records)
INSERT INTO `SECTOR` (id, nombre, descripcion)
VALUES (
        1,
        'Technology',
        'Software, hardware, and digital infrastructure'
    ),
    (
        2,
        'Private Defence',
        'Security forces and military contractors'
    ),
    (
        3,
        'Biotechnology',
        'Pharmaceuticals and genetic engineering'
    ),
    (4, 'Energy', 'Power generation and distribution'),
    (
        5,
        'Transportation',
        'Vehicle manufacturing and logistics'
    ),
    (
        6,
        'Media Entertainment',
        'Broadcasting and content production'
    ),
    (
        7,
        'Construction',
        'Urban development and infrastructure'
    ),
    (8, 'Finance', 'Banking and investment services'),
    (
        9,
        'Food Production',
        'Synthetic food and agriculture'
    ),
    (
        10,
        'Chemicals',
        'Industrial chemicals and materials'
    ),
    (
        11,
        'Telecommunications',
        'Network infrastructure and communications'
    ),
    (
        12,
        'Automotive',
        'Personal and commercial vehicles'
    ),
    (13, 'Aerospace', 'Space travel and aviation'),
    (14, 'Robotics', 'Automation and AI systems'),
    (
        15,
        'Security Services',
        'Private security and surveillance'
    ),
    (
        16,
        'Healthcare',
        'Medical services and insurance'
    ),
    (17, 'Education', 'Training and certification'),
    (18, 'Retail', 'Consumer goods and services'),
    (
        19,
        'Gaming',
        'Virtual reality and entertainment'
    ),
    (
        20,
        'Black Market',
        'Unregulated trade and smuggling'
    );
-- Insertions for HISTORIAL (20 records)
INSERT INTO `HISTORIAL` (id, mercenario_id, evento, fecha, tipo)
VALUES (
        1,
        1,
        'First major heist in Pacifica',
        '2024-03-15',
        'Operación'
    ),
    (
        2,
        1,
        'Netrun Arasaka tower prototype',
        '2025-01-20',
        'Hacking'
    ),
    (
        3,
        2,
        'Lost arm in Santo Domingo firefight',
        '2024-06-10',
        'Herida'
    ),
    (
        4,
        2,
        'Completed Militech escort contract',
        '2025-02-28',
        'Operación'
    ),
    (
        5,
        3,
        'Drone swarm malfunction incident',
        '2024-09-05',
        'Accidente'
    ),
    (
        6,
        3,
        'Successful corporate surveillance',
        '2025-03-12',
        'Operación'
    ),
    (
        7,
        4,
        'Joined Afterlife as legend',
        '2023-11-01',
        'Reconocimiento'
    ),
    (
        8,
        4,
        'Defeated Adam Smasher',
        '2024-12-20',
        'Combate'
    ),
    (
        9,
        5,
        'Lost crew in Arasaka Tower raid',
        '2023-09-15',
        'Tragedia'
    ),
    (
        10,
        5,
        'Became solo mercenary',
        '2024-01-10',
        'Carrera'
    ),
    (
        11,
        6,
        'First solo contract completed',
        '2025-01-05',
        'Operación'
    ),
    (
        12,
        6,
        'Developed reputation in Heywood',
        '2025-02-14',
        'Reconocimiento'
    ),
    (
        13,
        7,
        'Infected with cyberpsychosis',
        '2024-08-22',
        'Salud'
    ),
    (
        14,
        7,
        'Contained by MaxTac',
        '2024-08-25',
        'Detención'
    ),
    (
        15,
        8,
        'Created iconic Johnny Silverhand suit',
        '2020-05-10',
        'Legado'
    ),
    (
        16,
        8,
        'Assassinated Arasaka board member',
        '2020-05-12',
        'Operación'
    ),
    (
        17,
        9,
        'Survived braindance addiction',
        '2024-04-18',
        'Recuperación'
    ),
    (
        18,
        9,
        'Became Fixer in Watson',
        '2025-03-01',
        'Carrera'
    ),
    (
        19,
        10,
        'Lost family in corporate bombing',
        '2023-07-30',
        'Tragedia'
    ),
    (
        20,
        10,
        'Started mercenary career',
        '2024-02-14',
        'Carrera'
    );
-- Insertions for IMPLANTE (20 records)
INSERT INTO `IMPLANTE` (
        id,
        mercenario_id,
        nombre_implante,
        fabricante_id,
        nivel_rango
    )
VALUES (1, 1, 'Sandevistan Mark 5', 1, 5),
    (2, 1, 'Kiroshi Optics III', 3, 3),
    (3, 2, 'Mantis Blades Titanium', 2, 4),
    (4, 2, 'Subdermal Armor Plating', 2, 4),
    (5, 3, 'Gorilla Arms Standard', 2, 3),
    (6, 3, 'Neural Link Basic', 5, 2),
    (7, 4, 'Relic Prototype Chip', 1, 5),
    (8, 4, 'Optical Camouflage System', 12, 5),
    (9, 5, 'Cyberdeck Mark IV', 18, 4),
    (10, 5, 'Quickhack Accelerator', 5, 4),
    (11, 6, 'Reinforced Tendons', 1, 3),
    (12, 6, 'Blood Pump System', 4, 3),
    (13, 7, 'Berserk Operating System', 8, 5),
    (14, 7, 'Synaptic Accelerator', 13, 4),
    (15, 8, 'Chrome Arm Replacement', 1, 5),
    (16, 8, 'Engram Storage Device', 18, 5),
    (17, 9, 'Memory Buffer Upgrade', 5, 3),
    (18, 9, 'Emotional Dampener', 13, 2),
    (19, 10, 'Projectile Launch System', 2, 4),
    (20, 10, 'Thermal Katana Integration', 1, 4);
-- =====================================================
-- UPDATED INSERTS FOR EXISTING TABLES (20 records each)
-- =====================================================
-- Insertions for DISTRITO (20 records)
INSERT INTO `DISTRITO` (id, nombre, poblacion, seguridad_corpo, pobreza)
VALUES (1, 'Wattson', 1250000, TRUE, 12.5),
    (2, 'Santo Domingo', 3400000, FALSE, 68.2),
    (3, 'Brooklyn', 500000, TRUE, 2.1),
    (4, 'Pacifica', 890000, FALSE, 75.8),
    (5, 'Heywood', 1100000, TRUE, 35.2),
    (6, 'City Center', 450000, TRUE, 5.1),
    (7, 'Watson', 1800000, FALSE, 52.3),
    (8, 'Northside', 920000, FALSE, 61.4),
    (9, 'Japantown', 680000, TRUE, 28.7),
    (10, 'Little China', 750000, FALSE, 45.9),
    (11, 'Charter Hill', 320000, TRUE, 8.3),
    (
        12,
        'Santo Domingo Industrial',
        1500000,
        FALSE,
        72.1
    ),
    (13, 'Badlands', 45000, FALSE, 85.6),
    (14, 'Westbrook', 580000, TRUE, 15.4),
    (15, 'North Oak', 280000, TRUE, 3.2),
    (16, 'Kabuki', 1100000, FALSE, 58.9),
    (17, 'Megabuilding H10', 850000, FALSE, 64.2),
    (18, 'Arroyo', 420000, FALSE, 71.3),
    (19, 'El Coronas', 650000, FALSE, 66.8),
    (20, 'Downtown', 380000, TRUE, 18.5);
-- Insertions for DISTRITO_POBREZA (20 records)
INSERT INTO `DISTRITO_POBREZA` (id, id_distrito, fecha, pobreza_porcentaje)
VALUES (1, 1, '2026-04-01', 12),
    (2, 2, '2026-04-01', 68),
    (3, 3, '2026-04-01', 2),
    (4, 4, '2026-04-01', 76),
    (5, 5, '2026-04-01', 35),
    (6, 6, '2026-04-01', 5),
    (7, 7, '2026-04-01', 52),
    (8, 8, '2026-04-01', 61),
    (9, 9, '2026-04-01', 29),
    (10, 10, '2026-04-01', 46),
    (11, 11, '2026-04-01', 8),
    (12, 12, '2026-04-01', 72),
    (13, 13, '2026-04-01', 86),
    (14, 14, '2026-04-01', 15),
    (15, 15, '2026-04-01', 3),
    (16, 16, '2026-04-01', 59),
    (17, 17, '2026-04-01', 64),
    (18, 18, '2026-04-01', 71),
    (19, 19, '2026-04-01', 67),
    (20, 20, '2026-04-01', 19);
-- Insertions for DISTRITO_POBLACION (20 records)
INSERT INTO `DISTRITO_POBLACION` (id, id_distrito, fecha, poblacion)
VALUES (1, 1, '2026-04-01', 1250000),
    (2, 2, '2026-04-01', 3400000),
    (3, 3, '2026-04-01', 500000),
    (4, 4, '2026-04-01', 890000),
    (5, 5, '2026-04-01', 1100000),
    (6, 6, '2026-04-01', 450000),
    (7, 7, '2026-04-01', 1800000),
    (8, 8, '2026-04-01', 920000),
    (9, 9, '2026-04-01', 680000),
    (10, 10, '2026-04-01', 750000),
    (11, 11, '2026-04-01', 320000),
    (12, 12, '2026-04-01', 1500000),
    (13, 13, '2026-04-01', 45000),
    (14, 14, '2026-04-01', 580000),
    (15, 15, '2026-04-01', 280000),
    (16, 16, '2026-04-01', 1100000),
    (17, 17, '2026-04-01', 850000),
    (18, 18, '2026-04-01', 420000),
    (19, 19, '2026-04-01', 650000),
    (20, 20, '2026-04-01', 380000);
-- Insertions for CEO (20 records)
INSERT INTO `CEO` (
        id,
        nombre,
        descripcion,
        fecha_nacimiento,
        inicio_cargo,
        vivo
    )
VALUES (
        1,
        'Alistair Sterling',
        'Ruthless corporate leader specialising in artificial intelligence.',
        '1985-04-12',
        '2015-01-01',
        TRUE
    ),
    (
        2,
        'Evelyn Cross',
        'Former mercenary turned corporate executive.',
        '1979-11-23',
        '2020-05-15',
        TRUE
    ),
    (
        3,
        'Saburo Arasaka',
        'Founder of Arasaka Corporation, traditionalist leader.',
        '1923-08-15',
        '1970-01-01',
        FALSE
    ),
    (
        4,
        'Kirk Sawyer',
        'Militech CEO focused on military expansion.',
        '1975-03-22',
        '2018-06-10',
        TRUE
    ),
    (
        5,
        'Hanako Arasaka',
        'Arasaka heir and strategic planner.',
        '1988-12-05',
        '2022-03-15',
        TRUE
    ),
    (
        6,
        'Yorinobu Arasaka',
        'Rebel son who took control of Arasaka.',
        '1985-07-18',
        '2023-01-01',
        TRUE
    ),
    (
        7,
        'Gavin Reed',
        'Biotechnica CEO specializing in genetic research.',
        '1980-09-30',
        '2019-08-20',
        TRUE
    ),
    (
        8,
        'T-Bug',
        'Netrunner and digital security expert.',
        '1990-02-14',
        '2021-11-05',
        FALSE
    ),
    (
        9,
        'Rogue Amendiares',
        'Afterlife bar owner and former mercenary legend.',
        '1965-05-20',
        '2020-01-01',
        TRUE
    ),
    (
        10,
        'Adam Smasher',
        'Cyberpsycho enforcer and Arasaka security chief.',
        '1960-11-11',
        '2015-06-01',
        TRUE
    ),
    (
        11,
        'Goro Takemura',
        'Arasaka investigator and loyalist.',
        '1978-04-08',
        '2023-02-28',
        TRUE
    ),
    (
        12,
        'Misty Olszewski',
        'Spiritual advisor and shop owner in Night City.',
        '1982-07-12',
        '2024-01-15',
        TRUE
    ),
    (
        13,
        'Jackie Welles',
        'Mercenary with dreams of becoming legend.',
        '1995-06-25',
        '2023-09-01',
        FALSE
    ),
    (
        14,
        'V (Male)',
        'Mercenary veteran seeking immortality.',
        '1998-03-10',
        '2023-09-15',
        TRUE
    ),
    (
        15,
        'V (Female)',
        'Mercenary veteran navigating corporate intrigue.',
        '1998-03-10',
        '2023-09-15',
        TRUE
    ),
    (
        16,
        'Lucy Kushinada',
        'Netrunner escaping Arasaka control.',
        '1997-08-22',
        '2024-02-01',
        TRUE
    ),
    (
        17,
        'David Martinez',
        'Edgerunner with Sandevistan implant.',
        '1999-01-15',
        '2023-05-01',
        FALSE
    ),
    (
        18,
        'Maine',
        'Cyberpsycho mercenary crew leader.',
        '1988-12-03',
        '2022-08-10',
        FALSE
    ),
    (
        19,
        'Rebecca',
        'Small but fierce medic and gunner.',
        '2000-04-18',
        '2023-06-15',
        FALSE
    ),
    (
        20,
        'Falco',
        'Mechanic and David Martinez crew member.',
        '1996-09-28',
        '2024-03-01',
        TRUE
    );
-- Insertions for CORPO (20 records)
INSERT INTO `CORPO` (
        cif,
        nombre,
        id_sector,
        sede_central,
        valor_mercado,
        ejercito,
        id_ceo
    )
VALUES (
        1001,
        'OmniStat Dynamics',
        1,
        3,
        5000000000.00,
        TRUE,
        1
    ),
    (
        1002,
        'Aegis Defence Solutions',
        2,
        1,
        2500000000.00,
        TRUE,
        2
    ),
    (
        1003,
        'Arasaka Corporation',
        1,
        6,
        150000000000.00,
        TRUE,
        6
    ),
    (1004, 'Militech', 2, 11, 85000000000.00, TRUE, 4),
    (
        1005,
        'Biotechnica',
        3,
        14,
        42000000000.00,
        FALSE,
        7
    ),
    (
        1006,
        'Trauma Team International',
        16,
        6,
        28000000000.00,
        TRUE,
        8
    ),
    (1007, 'Zetatech', 1, 9, 18000000000.00, FALSE, 5),
    (
        1008,
        'Kang Tao',
        11,
        10,
        12000000000.00,
        FALSE,
        11
    ),
    (
        1009,
        'Petrochem',
        4,
        12,
        35000000000.00,
        TRUE,
        12
    ),
    (1010, 'NetWatch', 11, 6, 8000000000.00, TRUE, 9),
    (
        1011,
        'Tyger Claws',
        20,
        7,
        3500000000.00,
        TRUE,
        13
    ),
    (
        1012,
        'Maelstrom',
        20,
        8,
        2800000000.00,
        TRUE,
        14
    ),
    (
        1013,
        'Valentinos',
        20,
        19,
        1900000000.00,
        TRUE,
        15
    ),
    (
        1014,
        '6th Street',
        20,
        7,
        2200000000.00,
        TRUE,
        16
    ),
    (1015, 'Animals', 20, 8, 1500000000.00, TRUE, 17),
    (
        1016,
        'Voodoo Boys',
        20,
        4,
        4200000000.00,
        FALSE,
        18
    ),
    (
        1017,
        'Aldecaldos',
        20,
        13,
        800000000.00,
        TRUE,
        19
    ),
    (
        1018,
        'Afterlife Management',
        6,
        16,
        5500000000.00,
        FALSE,
        20
    ),
    (
        1019,
        'MaxTac Division',
        15,
        6,
        12000000000.00,
        TRUE,
        10
    ),
    (1020, 'NCPD', 15, 6, 45000000000.00, TRUE, 11);
-- Insertions for CORPO_SECTOR (20 records)
INSERT INTO `CORPO_SECTOR` (cif, nombre)
VALUES (1001, 'Technology'),
    (1002, 'Private Defence'),
    (1003, 'Technology'),
    (1004, 'Private Defence'),
    (1005, 'Biotechnology'),
    (1006, 'Healthcare'),
    (1007, 'Technology'),
    (1008, 'Telecommunications'),
    (1009, 'Energy'),
    (1010, 'Telecommunications'),
    (1011, 'Black Market'),
    (1012, 'Black Market'),
    (1013, 'Black Market'),
    (1014, 'Black Market'),
    (1015, 'Black Market'),
    (1016, 'Black Market'),
    (1017, 'Black Market'),
    (1018, 'Media Entertainment'),
    (1019, 'Security Services'),
    (1020, 'Security Services');
-- Insertions for CORPO_VALOR_MERCADO (20 records)
INSERT INTO `CORPO_VALOR_MERCADO` (id, corpo_cif, valor, fecha, fuente)
VALUES (
        1,
        1001,
        5000000000.00,
        '2026-04-01 08:00:00',
        'Financial Times Cyber-Index'
    ),
    (
        2,
        1002,
        2500000000.00,
        '2026-04-01 08:00:00',
        'Financial Times Cyber-Index'
    ),
    (
        3,
        1003,
        150000000000.00,
        '2026-04-01 08:00:00',
        'Arasaka Annual Report'
    ),
    (
        4,
        1004,
        85000000000.00,
        '2026-04-01 08:00:00',
        'Militech Investor Relations'
    ),
    (
        5,
        1005,
        42000000000.00,
        '2026-04-01 08:00:00',
        'BioTech Quarterly'
    ),
    (
        6,
        1006,
        28000000000.00,
        '2026-04-01 08:00:00',
        'Trauma Team Financials'
    ),
    (
        7,
        1007,
        18000000000.00,
        '2026-04-01 08:00:00',
        'Zetatech Market Analysis'
    ),
    (
        8,
        1008,
        12000000000.00,
        '2026-04-01 08:00:00',
        'Kang Tao Reports'
    ),
    (
        9,
        1009,
        35000000000.00,
        '2026-04-01 08:00:00',
        'Petrochem Energy Index'
    ),
    (
        10,
        1010,
        8000000000.00,
        '2026-04-01 08:00:00',
        'NetWatch Internal'
    ),
    (
        11,
        1011,
        3500000000.00,
        '2026-04-01 08:00:00',
        'Underground Market Data'
    ),
    (
        12,
        1012,
        2800000000.00,
        '2026-04-01 08:00:00',
        'Underground Market Data'
    ),
    (
        13,
        1013,
        1900000000.00,
        '2026-04-01 08:00:00',
        'Valentinos Ledger'
    ),
    (
        14,
        1014,
        2200000000.00,
        '2026-04-01 08:00:00',
        '6th Street Records'
    ),
    (
        15,
        1015,
        1500000000.00,
        '2026-04-01 08:00:00',
        'Animals Gang Finance'
    ),
    (
        16,
        1016,
        4200000000.00,
        '2026-04-01 08:00:00',
        'Voodoo Boys Net'
    ),
    (
        17,
        1017,
        800000000.00,
        '2026-04-01 08:00:00',
        'Aldecaldo Camp Records'
    ),
    (
        18,
        1018,
        5500000000.00,
        '2026-04-01 08:00:00',
        'Afterlife Bookings'
    ),
    (
        19,
        1019,
        12000000000.00,
        '2026-04-01 08:00:00',
        'NCPD Budget Report'
    ),
    (
        20,
        1020,
        45000000000.00,
        '2026-04-01 08:00:00',
        'NCPD Annual Audit'
    );
-- Insertions for FIXER (20 records)
INSERT INTO `FIXER` (
        id,
        alias,
        descripcion,
        distrito,
        foto_perfil,
        contrasena_hash,
        estado
    )
VALUES (
        1,
        'The Weaver',
        'Connects the highest bidders with the quietest operatives in the city.',
        3,
        'http://secure-net.local/images/weaver.png',
        'a1b2c3d4e5f6',
        'Vivo'
    ),
    (
        2,
        'Rook',
        'Specialises in black-market hardware and heavy enforcement.',
        2,
        'http://secure-net.local/images/rook.png',
        'f6e5d4c3b2a1',
        'Vivo'
    ),
    (
        3,
        'Regina Jones',
        'Watson-based fixer with extensive mercenary network.',
        7,
        'http://secure-net.local/images/regina.png',
        'reg1na2026',
        'Vivo'
    ),
    (
        4,
        'Wakako Okada',
        'Japantown fixer specializing in corporate contracts.',
        9,
        'http://secure-net.local/images/wakako.png',
        'wakako99',
        'Vivo'
    ),
    (
        5,
        'Dakota Smith',
        'Heywood fixer with military connections.',
        5,
        'http://secure-net.local/images/dakota.png',
        'dakota77',
        'Vivo'
    ),
    (
        6,
        'Alt Cunningham',
        'Legendary netrunner operating from the Net.',
        6,
        'http://secure-net.local/images/alt.png',
        'alt_cunningham_2077',
        'Muerto'
    ),
    (
        7,
        'Claire Russell',
        'Racing enthusiast and fixer in Heywood.',
        5,
        'http://secure-net.local/images/claire.png',
        'claire_racer',
        'Vivo'
    ),
    (
        8,
        'Kerry Eurodyne',
        'Rockerboy legend and fixer for music gigs.',
        14,
        'http://secure-net.local/images/kerry.png',
        'kerry_rockstar',
        'Vivo'
    ),
    (
        9,
        'Father',
        'Fixer in Pacifica dealing with local gangs.',
        4,
        'http://secure-net.local/images/father.png',
        'father_pacifica',
        'Muerto'
    ),
    (
        10,
        'Lizzie Boddington',
        'Owner of Lizziess Bar
        and fixer in Kabuki.',
        16,
        'http: // secure - net.local / images / lizzie.png ',
        'lizzie_bar',
        'Vivo'
    ),
    (
        11,
        'Mama Welles',
        'Fixer in Heywood with family connections.',
        5,
        'http: // secure - net.local / images / mama.png',
        'mama_welles',
        'Vivo'
    ),
    (
        12,
        'T-Bug',
        'Digital fixer
        and netrunner contact.',
        6,
        'http: // secure - net.local / images / tbug.png',
        'tbug_net',
        'Muerto'
    ),
    (
        13,
        'Sister',
        'Fixer in Northside with gang ties.',
        8,
        'http: // secure - net.local / images / sister.png',
        'sister_ns',
        'Vivo'
    ),
    (
        14,
        'Rogue Amendiares',
        'Owner of Afterlife,
        legendary fixer.',
        16,
        'http: // secure - net.local / images / rogue.png',
        'rogue_afterlife',
        'Vivo'
    ),
    (
        15,
        'Viktor Vector',
        'Ripperdoc who also acts as a fixer for medical jobs.',
        7,
        'http: // secure - net.local / images / viktor.png',
        'viktor_doc',
        'Vivo'
    ),
    (
        16,
        'Goro Takemura',
        'Arasaka fixer operating in the shadows.',
        6,
        'http: // secure - net.local / images / goro.png',
        'goro_arasaka',
        'Vivo'
    ),
    (
        17,
        'Panam Palmer',
        'Aldecaldo fixer for desert operations.',
        13,
        'http: // secure - net.local / images / panam.png',
        'panam_alde',
        'Vivo'
    ),
    (
        18,
        'Johnny Silverhand',
        ' Ghost fixer for anti-corp missions.',
        6,
        'http: // secure - net.local / images / johnny.png',
        'johnny_ghost',
        'Muerto'
    ),
    (
        19,
        'Delamain',
        'AI fixer for autonomous transport jobs.',
        6,
        'http: // secure - net.local / images / delamain.png',
        'delamain_ai',
        'Vivo'
    ),
    (
        20,
        'Evelyn Parker',
        ' Former fixer turned info broker.',
        10,
        'http: // secure - net.local / images / evelyn.png',
        'evelyn_info',
        'Muerto'
    );
-- Insertions for MERCENARIO_CATEGORIA (20 records)
-- Note: Original schema had 3, expanded to 20 for consistency
INSERT INTO `MERCENARIO_CATEGORIA` (id_categoria, categoria)
VALUES (1, 'Netrunner'),
    (2, 'Solo'),
    (3, 'Techie'),
    (4, 'Nomad'),
    (5, 'Rockerboy'),
    (6, 'Medic'),
    (7, 'Fixer'),
    (8, 'Corpo'),
    (9, 'Spy'),
    (10, 'Assassin'),
    (11, 'Sniper'),
    (12, 'Demolitionist'),
    (13, 'Driver'),
    (14, 'Scout'),
    (15, 'Heavy Gunner'),
    (16, 'Stealth Specialist'),
    (17, 'Cyberpsycho Hunter'),
    (18, 'Data Broker'),
    (19, 'Street Kid'),
    (20, 'Legend');
-- Insertions for MERCENARIO (20 records)
INSERT INTO `MERCENARIO` (
        id,
        alias,
        descripcion,
        id_categoria,
        id_distrito,
        street_cred,
        imagen,
        historial,
        implante,
        telefono,
        estado
    )
VALUES (
        1,
        'Ghost',
        'Specialises in silent extraction
        and digital infiltration.',
        1,
        1,
        95,
        'http: // secure - net.local / images / ghost.png',
        1,
        1,
        5550199,
        'Vivo'
    ),
    (
        2,
        'Ironclad',
        'Heavy ordnance
        and frontline combat specialist.',
        2,
        2,
        82,
        'http: // secure - net.local / images / ironclad.png',
        3,
        3,
        5550200,
        'Ocupado'
    ),
    (
        3,
        'Wire',
        'Hardware manipulation
        and drone operator.',
        3,
        2,
        60,
        'http: // secure - net.local / images / wire.png',
        5,
        5,
        5550201,
        'Indispuesto'
    ),
    (
        4,
        'V',
        'Mercenary veteran navigating the streets of Night City.',
        2,
        7,
        100,
        'http: // secure - net.local / images / v.png',
        8,
        7,
        5550202,
        'Vivo'
    ),
    (
        5,
        'David Martinez',
        'Edgerunner with Sandevistan implant.',
        2,
        7,
        98,
        'http: // secure - net.local / images / david.png',
        9,
        15,
        5550203,
        'Muerto'
    ),
    (
        6,
        'Lucy',
        'Netrunner escaping Arasaka control.',
        1,
        4,
        92,
        'http: // secure - net.local / images / lucy.png',
        17,
        9,
        5550204,
        'Vivo'
    ),
    (
        7,
        'Maine',
        'Cyberpsycho mercenary crew leader.',
        2,
        8,
        88,
        'http: // secure - net.local / images / maine.png ',
        13,
        13,
        5550205,
        'Muerto'
    ),
    (
        8,
        'Rebecca',
        'Small but fierce medic
        and gunner.',
        6,
        8,
        85,
        'http: // secure - net.local / images / rebecca.png',
        19,
        17,
        5550206,
        'Muerto'
    ),
    (
        9,
        'Falco',
        'Mechanic
        and David Martinez crew member.',
        3,
        7,
        80,
        'http: // secure - net.local / images / falco.png',
        20,
        19,
        5550207,
        'Vivo'
    ),
    (
        10,
        'Kiwi',
        'Netrunner
        and Maine crew member.',
        1,
        8,
        75,
        'http: // secure - net.local / images / kiwi.png',
        11,
        11,
        5550208,
        'Muerto'
    ),
    (
        11,
        'Jackie Welles',
        'Mercenary with dreams of becoming legend.',
        2,
        10,
        70,
        'http: // secure - net.local / images / jackie.png',
        13,
        13,
        5550209,
        'Muerto'
    ),
    (
        12,
        'Panam Palmer',
        'Nomad driver
        and mercenary.',
        4,
        13,
        90,
        'http: // secure - net.local / images / panam.png',
        17,
        17,
        5550210,
        'Vivo'
    ),
    (
        13,
        'Rogue',
        'Legendary mercenary
        and Afterlife owner.',
        20,
        16,
        100,
        'http: // secure - net.local / images / rogue.png',
        15,
        15,
        5550211,
        'Vivo'
    ),
    (
        14,
        'Johnny Silverhand ',
        'Rockerboy legend
        and terrorist.',
        5,
        6,
        100,
        'http: // secure - net.local / images / johnny.png ',
        16,
        16,
        5550212,
        'Muerto'
    ),
    (
        15,
        'Takemura',
        'Arasaka investigator turned mercenary.',
        8,
        6,
        85,
        'http: // secure - net.local / images / takemura.png',
        11,
        11,
        5550213,
        'Vivo'
    ),
    (
        16,
        'River Ward ',
        'NCPD detective
        and mercenary.',
        17,
        1,
        78,
        'http: // secure - net.local / images / river.png',
        14,
        14,
        5550214,
        'Vivo'
    ),
    (
        17,
        'Kerry Eurodyne',
        'Rockerboy legend
        and fixer.',
        5,
        14,
        95,
        'http: // secure - net.local / images / kerry.png',
        8,
        8,
        5550215,
        'Vivo'
    ),
    (
        18,
        'Judy Alvarez',
        'Braindance technician.',
        1,
        10,
        88,
        'http: // secure - net.local / images / judy.png',
        12,
        12,
        5550216,
        'Vivo'
    ),
    (
        19,
        'Misty Olszewski',
        'Spiritual advisor
        and occasional mercenary.',
        19,
        7,
        65,
        'http: // secure - net.local / images / misty.png',
        12,
        12,
        5550217,
        'Vivo'
    ),
    (
        20,
        'Adam Smasher',
        'Cyberpsycho enforcer
        and Arasaka security chief.',
        2,
        6,
        99,
        'http: // secure - net.local / images / smasher.png',
        10,
        10,
        5550218,
        'Vivo'
    );
-- Insertions for MERCENARIO_STREETCRED (20 records)
INSERT INTO `MERCENARIO_STREETCRED` (id_mercenario, streetcred)
VALUES (1, 95),
    (2, 82),
    (3, 60),
    (4, 100),
    (5, 98),
    (6, 92),
    (7, 88),
    (8, 85),
    (9, 80),
    (10, 75),
    (11, 70),
    (12, 90),
    (13, 100),
    (14, 100),
    (15, 85),
    (16, 78),
    (17, 95),
    (18, 88),
    (19, 65),
    (20, 99);
-- Insertions for MERCENARIO_TELEFONO (20 records)
INSERT INTO `MERCENARIO_TELEFONO` (id_mercenario, telefono)
VALUES (1, 5550199),
    (2, 5550200),
    (3, 5550201),
    (4, 5550202),
    (5, 5550203),
    (6, 5550204),
    (7, 5550205),
    (8, 5550206),
    (9, 5550207),
    (10, 5550208),
    (11, 5550209),
    (12, 5550210),
    (13, 5550211),
    (14, 5550212),
    (15, 5550213),
    (16, 5550214),
    (17, 5550215),
    (18, 5550216),
    (19, 5550217),
    (20, 5550218);
-- Insertions for CYBERWARE (20 records)
-- Note: id_fabricante now references FABRICANTE table (IDs 1-20)
INSERT INTO `CYBERWARE` (id, nombre, modelo, id_fabricante, precio, grado)
VALUES (
        1,
        'Neural Cortex Processor',
        ' Mk IV ',
        1,
        15000.00,
        4
    ),
    (
        2,
        ' Sub - dermal Armour Plating ',
        ' Aegis Shield - V ',
        2,
        22000.00,
        5
    ),
    (
        3,
        ' Optical Scanner ',
        ' Kiroshi Basic ',
        3,
        3500.00,
        2
    ),
    (
        4,
        ' Sandevistan Mark 5 ',
        ' Zetatech ',
        5,
        45000.00,
        5
    ),
    (
        5,
        ' Mantis Blades ',
        ' Militech Combat ',
        2,
        18000.00,
        4
    ),
    (
        6,
        ' Gorilla Arms ',
        ' Standard ',
        2,
        12000.00,
        3
    ),
    (
        7,
        ' Cyberdeck Mark IV ',
        ' Alt Cunningham ',
        18,
        55000.00,
        5
    ),
    (
        8,
        ' Quickhack Accelerator ',
        ' Zetatech ',
        5,
        28000.00,
        4
    ),
    (
        9,
        ' Reinforced Tendons ',
        ' Arasaka ',
        1,
        8000.00,
        3
    ),
    (
        10,
        ' Blood Pump System ',
        ' Trauma Team ',
        4,
        15000.00,
        3
    ),
    (
        11,
        ' Berserk Operating System ',
        ' Maelstrom ',
        8,
        60000.00,
        5
    ),
    (
        12,
        ' Synaptic Accelerator ',
        ' Synapse ',
        13,
        32000.00,
        4
    ),
    (
        13,
        ' Chrome Arm Replacement ',
        ' Arasaka ',
        1,
        25000.00,
        5
    ),
    (
        14,
        ' Engram Storage Device ',
        ' Alt Cunningham ',
        18,
        75000.00,
        5
    ),
    (
        15,
        ' Memory Buffer Upgrade ',
        ' Zetatech ',
        5,
        18000.00,
        3
    ),
    (
        16,
        ' Emotional Dampener ',
        ' Synapse ',
        13,
        12000.00,
        2
    ),
    (
        17,
        ' Projectile Launch System ',
        ' Militech ',
        2,
        35000.00,
        4
    ),
    (
        18,
        ' Thermal Katana Integration ',
        ' Arasaka ',
        1,
        42000.00,
        4
    ),
    (
        19,
        ' Optical Camouflage System ',
        ' Katsuo ',
        12,
        50000.00,
        5
    ),
    (
        20,
        ' Neural Link Basic ',
        ' Zetatech ',
        5,
        9000.00,
        2
    );
-- Insertions for MERCENARIO_CYBERWARE (20 records)
-- Links Mercenarios (1-20) to Cyberware (1-20)
INSERT INTO `MERCENARIO_CYBERWARE` (id_mercenario, id_cyberware)
VALUES (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10),
    (11, 11),
    (12, 12),
    (13, 13),
    (14, 14),
    (15, 15),
    (16, 16),
    (17, 17),
    (18, 18),
    (19, 19),
    (20, 20);
-- Insertions for ENCARGO (20 records)
INSERT INTO `ENCARGO` (
        id,
        id_fixer,
        id_mercenario,
        titulo,
        descripcion,
        resultado
    )
VALUES (
        1,
        1,
        1,
        'Data Extraction',
        'Retrieve secure corporate files
        from a rival server farm without raising the alarm.',
        'Exitoso'
    ),
    (
        2,
        2,
        2,
        'Convoy Escort',
        'Provide heavy security for an armoured transport moving through the Warrens.',
        'Pendiente'
    ),
    (
        3,
        1,
        3,
        'Surveillance System Hack',
        'Disable the optical feeds in the corporate sector prior to an unlisted operation.',
        'Fracaso'
    ),
    (
        4,
        3,
        4,
        'Arasaka Tower Infiltration',
        'Infiltrate the Arasaka tower to extract a high - value target.',
        'Exitoso'
    ),
    (
        5,
        4,
        5,
        'Night City Heist',
        'Steal a prototype chip
        from a Tyger Claws warehouse.',
        'Exitoso'
    ),
    (
        6,
        5,
        6,
        'Netrunner Rescue',
        'Rescue a captured netrunner
        from a Militech facility.',
        'Pendiente'
    ),
    (
        7,
        6,
        7,
        'Corporate Sabotage ',
        'Sabotage a Biotechnica research lab.',
        'Fracaso'
    ),
    (
        8,
        7,
        8,
        'Racing Bet',
        'Win a high-stakes race against a rival gang.',
        'Exitoso'
    ),
    (
        9,
        8,
        9,
        'Music Gig Security',
        'Provide security for Kerry Eurodyne concert.',
        'Exitoso'
    ),
    (
        10,
        9,
        10,
        'Pacifica Cleanup',
        'Clear out a gang stronghold in Pacifica.',
        'Pendiente '
    ),
    (
        11,
        10,
        11,
        'Braindance Edit',
        'Edit a braindance for a client.',
        'Exitoso'
    ),
    (
        12,
        11,
        12,
        'Family Protection',
        'Protect a family
        from corporate threats.',
        'Exitoso'
    ),
    (
        13,
        12,
        13,
        'Net Run',
        'Run a net operation for a client.',
        'Fracaso'
    ),
    (
        14,
        13,
        14,
        'Gang War',
        'Participate in a gang war.',
        'Exitoso'
    ),
    (
        15,
        14,
        15,
        'Afterlife Job',
        'Complete a job at the Afterlife bar.',
        'Exitoso'
    ),
    (
        16,
        15,
        16,
        'Medical Mission',
        'Perform a medical mission for a client.',
        'Pendiente'
    ),
    (
        17,
        16,
        17,
        'Desert Run',
        'Run a supply line through the Badlands.',
        'Exitoso'
    ),
    (
        18,
        17,
        18,
        'Anti-Corp Raid ',
        'Raid a corporate facility.',
        'Fracaso'
    ),
    (
        19,
        18,
        19,
        'AI Transport',
        'Transport an AI unit safely.',
        'Exitoso'
    ),
    (
        20,
        19,
        20,
        'Info Broker Deal',
        'Broker a deal for sensitive information.',
        'Exitoso'
    );
-- Section: Constraints (Foreign Keys)
ALTER TABLE `CORPO_VALOR_MERCADO`
ADD CONSTRAINT `fk_corpo_valor` FOREIGN KEY (`corpo_cif`) REFERENCES `CORPO` (`cif`);
ALTER TABLE `ENCARGO`
ADD CONSTRAINT `fk_encargo_fixer` FOREIGN KEY (`id_fixer`) REFERENCES `FIXER` (`id`);
ALTER TABLE `ENCARGO`
ADD CONSTRAINT `fk_encargo_merc` FOREIGN KEY (`id_mercenario`) REFERENCES `MERCENARIO` (`id`);
ALTER TABLE `FIXER`
ADD CONSTRAINT `fk_fixer_distrito` FOREIGN KEY (`distrito`) REFERENCES `DISTRITO` (`id`);
ALTER TABLE `CORPO`
ADD CONSTRAINT `fk_corpo_ceo` FOREIGN KEY (`id_ceo`) REFERENCES `CEO` (`id`);
ALTER TABLE `DISTRITO_POBREZA`
ADD CONSTRAINT `fk_distrito_pob_id` FOREIGN KEY (`id_distrito`) REFERENCES `DISTRITO` (`id`);
ALTER TABLE `DISTRITO_POBLACION`
ADD CONSTRAINT `fk_distrito_pop_id` FOREIGN KEY (`id_distrito`) REFERENCES `DISTRITO` (`id`);