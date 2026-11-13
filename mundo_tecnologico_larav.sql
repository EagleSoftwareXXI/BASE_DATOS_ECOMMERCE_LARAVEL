-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:33065
-- Tiempo de generación: 13-11-2026 a las 18:14:17
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `citasmedicas`
--
CREATE DATABASE IF NOT EXISTS `citasmedicas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `citasmedicas`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `id_cita` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_doctor` int(11) NOT NULL,
  `fecha_cita` date NOT NULL,
  `hora_cita` time NOT NULL,
  `motivo_consulta` text NOT NULL,
  `estado` enum('Pendiente','Confirmada','Cancelada','Completada') DEFAULT 'Pendiente',
  `diagnostico` text DEFAULT NULL,
  `receta_medica` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id_cita`, `id_paciente`, `id_doctor`, `fecha_cita`, `hora_cita`, `motivo_consulta`, `estado`, `diagnostico`, `receta_medica`, `fecha_creacion`) VALUES
(1, 1, 1, '2026-10-15', '09:00:00', 'Dolor recurrente en el pecho y fatiga al caminar.', 'Confirmada', NULL, NULL, '2026-10-13 01:37:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctores`
--

CREATE TABLE `doctores` (
  `id_doctor` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_especialidad` int(11) NOT NULL,
  `tarjeta_profesional` varchar(50) NOT NULL,
  `consultorio` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `doctores`
--

INSERT INTO `doctores` (`id_doctor`, `id_usuario`, `id_especialidad`, `tarjeta_profesional`, `consultorio`) VALUES
(1, 2, 2, 'TP-987654', 'Consultorio 302');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `id_especialidad` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`id_especialidad`, `nombre`, `descripcion`) VALUES
(1, 'Medicina General', 'Atención primaria y prevención de enfermedades comunes.'),
(2, 'Cardiología', 'Estudio, diagnóstico y tratamiento de las enfermedades del corazón.'),
(3, 'Pediatría', 'Atención médica integral para niños y adolescentes.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id_paciente` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `tipo_sangre` varchar(5) DEFAULT NULL,
  `direccion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id_paciente`, `id_usuario`, `fecha_nacimiento`, `tipo_sangre`, `direccion`) VALUES
(1, 3, '1995-06-15', 'O+', 'Calle 100 # 45-20, Cali');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Doctor'),
(3, 'Paciente'),
(4, 'Recepcionista');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `id_rol` int(11) NOT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `apellido`, `email`, `password`, `telefono`, `id_rol`, `estado`, `fecha_creacion`) VALUES
(1, 'Carlos', 'Admin', 'admin@citas.com', '123456', '3001234567', 1, 'activo', '2026-10-13 01:37:20'),
(2, 'Dra. Elena', 'Gómez', 'doctor@citas.com', '123456', '3109876543', 2, 'activo', '2026-10-13 01:37:20'),
(3, 'Juan', 'Pérez', 'paciente@citas.com', '123456', '3205554433', 3, 'activo', '2026-10-13 01:37:20'),
(4, 'Maria', 'Secretaria', 'recepcion@citas.com', '123456', '3112223344', 4, 'activo', '2026-10-13 01:37:20');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `id_paciente` (`id_paciente`),
  ADD KEY `id_doctor` (`id_doctor`);

--
-- Indices de la tabla `doctores`
--
ALTER TABLE `doctores`
  ADD PRIMARY KEY (`id_doctor`),
  ADD UNIQUE KEY `tarjeta_profesional` (`tarjeta_profesional`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_especialidad` (`id_especialidad`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`id_especialidad`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id_paciente`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `doctores`
--
ALTER TABLE `doctores`
  MODIFY `id_doctor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `id_especialidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id_paciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`) ON DELETE CASCADE,
  ADD CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`id_doctor`) REFERENCES `doctores` (`id_doctor`) ON DELETE CASCADE;

--
-- Filtros para la tabla `doctores`
--
ALTER TABLE `doctores`
  ADD CONSTRAINT `doctores_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `doctores_ibfk_2` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidades` (`id_especialidad`);

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `pacientes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
--
-- Base de datos: `citas_medicas_db`
--
CREATE DATABASE IF NOT EXISTS `citas_medicas_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `citas_medicas_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `id_cita` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_especialista` int(11) DEFAULT NULL,
  `fecha_cita` datetime DEFAULT NULL,
  `estado` enum('Pendiente Confirmación','Confirmada y Asignada','Cancelada') DEFAULT 'Pendiente Confirmación',
  `turno` varchar(20) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id_cita`, `id_usuario`, `id_especialista`, `fecha_cita`, `estado`, `turno`, `fecha_creacion`) VALUES
(1, 3, 1, '2026-11-15 08:30:00', 'Confirmada y Asignada', 'TRN-1001', '2026-10-19 20:29:27'),
(2, 3, 2, '2026-11-18 10:00:00', 'Confirmada y Asignada', 'TRN-1002', '2026-10-19 20:29:27'),
(3, 3, NULL, NULL, 'Pendiente Confirmación', 'TRN-1003', '2026-10-19 20:29:27'),
(4, 4, NULL, NULL, 'Pendiente Confirmación', 'TRN-3477', '2026-10-19 20:40:28'),
(5, 5, 1, '2026-11-11 19:27:00', 'Confirmada y Asignada', 'TRN-9404', '2026-11-02 19:22:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialistas`
--

CREATE TABLE `especialistas` (
  `id_especialista` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `especialidad` varchar(100) NOT NULL,
  `consultorio` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `especialistas`
--

INSERT INTO `especialistas` (`id_especialista`, `nombre`, `especialidad`, `consultorio`) VALUES
(1, 'Dra. Sofia Martinez', 'Medicina General', 'Consultorio 101 - Torre A'),
(2, 'Dr. Roberto Gomez', 'Cardiología', 'Consultorio 204 - Torre B'),
(3, 'Dra. Elena Rios', 'Pediatría', 'Consultorio 108 - Torre A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Gestor de Citas'),
(3, 'Usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`, `fecha_registro`) VALUES
(1, 'Carlos Administrador', 'admin@citasmedicas.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '2026-10-19 20:29:27'),
(2, 'Ana Gestora', 'gestor@citasmedicas.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 2, '2026-10-19 20:29:27'),
(3, 'Luis Paciente', 'usuario@citasmedicas.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 3, '2026-10-19 20:29:27'),
(4, 'Karen Velazquez', 'karenv@gmail.com', '$2y$10$6qKgo4Cw/tx0z4AQ3dwfiu8uoug2Co15on.pmyq7VGXxPUNSkd3cC', 3, '2026-10-19 20:39:58'),
(5, 'Juan Pérez', 'juanperez@gmail.com', '$2y$10$8be070S3o1hPyoufGwySiufKSApbKZYrr2eMK/NviXWMEf7TYdDau', 3, '2026-11-02 19:22:18');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `fk_cita_usuario` (`id_usuario`),
  ADD KEY `fk_cita_especialista` (`id_especialista`);

--
-- Indices de la tabla `especialistas`
--
ALTER TABLE `especialistas`
  ADD PRIMARY KEY (`id_especialista`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_usuario_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `especialistas`
--
ALTER TABLE `especialistas`
  MODIFY `id_especialista` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `fk_cita_especialista` FOREIGN KEY (`id_especialista`) REFERENCES `especialistas` (`id_especialista`),
  ADD CONSTRAINT `fk_cita_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
--
-- Base de datos: `copia_mundo_tecnologico_v6`
--
CREATE DATABASE IF NOT EXISTS `copia_mundo_tecnologico_v6` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `copia_mundo_tecnologico_v6`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT 'default_cat.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`, `descripcion`, `imagen`) VALUES
(1, 'Laptops y Portátiles', 'Equipos portátiles de alto rendimiento para trabajo, estudio y gaming.', 'cat_1791730335.jpg'),
(2, 'Componentes de PC', 'Tarjetas gráficas, procesadores, memorias RAM y placas base.', 'componentes.jpg'),
(3, 'Smartphones y Tablets', 'Dispositivos móviles de última generación, celulares gama alta y tablets.', 'cat_1791730634.jpg'),
(4, 'Monitores y Pantallas', 'Monitores gamer, pantallas 4K y monitores profesionales ultra-wide.', 'cat_1791730376.jpg'),
(5, 'Periféricos', 'Teclados mecánicos, ratones ergonómicos, diademas y micrófonos.', 'perifericos.jpg'),
(6, 'Almacenamiento', 'Unidades de estado sólido SSD NVMe y discos duros externos.', 'cat_1791740753.jpg'),
(7, 'Redes y Conectividad', 'Routers Wi-Fi 6, switches gigabit, repetidores y adaptadores de red.', 'redes.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT current_timestamp(),
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `iva` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `metodo_pago` varchar(50) DEFAULT 'Tarjeta Visa (Pasarela V6)',
  `referencia_pago` varchar(100) DEFAULT NULL,
  `estado` enum('Pendiente','Procesando','Enviado','Completado','Cancelado') DEFAULT 'Completado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `id_usuario`, `fecha_compra`, `subtotal`, `iva`, `total`, `metodo_pago`, `referencia_pago`, `estado`) VALUES
(2, 4, '2026-10-11 03:19:07', 2600000.00, 494000.00, 3094000.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACB002B1910C', 'Completado'),
(3, 4, '2026-10-11 03:19:32', 650000.00, 123500.00, 773500.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACB0044C6662', 'Completado'),
(4, 4, '2026-10-11 18:10:19', 6680000.00, 1269200.00, 7949200.00, 'Tarjeta de Crédito Visa', 'PAY-MUNDO-6ACBD10B39F6F', 'Completado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `valor` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `clave`, `valor`) VALUES
(1, 'nombre_tienda', 'Mundo Tecnológico S.A.S'),
(2, 'logo_url', 'assets/img/logo_1791688901.png'),
(3, 'acerca_titulo', 'Sobre Mundo Tecnológico V6 S.A.S'),
(4, 'acerca_historia', 'Fundada en 2019 en la ciudad de Bogotá, Mundo Tecnológico V6 nació con la firme visión de acercar la innovación, el hardware de última generación y los componentes de alta gama a todo el mercado colombiano. A lo largo de los años nos hemos consolidado como líderes en distribución tecnológica, garantizando siempre respaldo, garantía, confianza absoluta y un servicio excepcional para cada uno de nuestros clientes y empresas aliadas.'),
(5, 'acerca_direccion', 'Calle 100 # 15-20, Oficina 402, Bogotá D.C., Colombia'),
(6, 'acerca_telefono', '+57 (1) 790 5500 / +57 310 400 5000'),
(7, 'acerca_email', 'mundotecnologico@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compras`
--

CREATE TABLE `detalle_compras` (
  `id_detalle` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `valor_iva` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_compras`
--

INSERT INTO `detalle_compras` (`id_detalle`, `id_compra`, `id_producto`, `cantidad`, `precio_unitario`, `valor_iva`, `subtotal`) VALUES
(1, 2, 4, 1, 2600000.00, 494000.00, 3094000.00),
(2, 3, 9, 1, 650000.00, 123500.00, 773500.00),
(3, 4, 5, 1, 6400000.00, 1216000.00, 7616000.00),
(4, 4, 33, 1, 280000.00, 53200.00, 333200.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 10,
  `imagen` varchar(255) DEFAULT 'default_prod.jpg',
  `id_categoria` int(11) DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`, `id_categoria`, `estado`) VALUES
(1, 'Laptop Gamer ASUS ROG Strix G16', 'Intel Core i7 13700HX, 16GB RAM DDR5, 512GB SSD NVMe, NVIDIA RTX 4060 8GB', 5200000.00, 4, 'laptop_asus_rog.jpg', 1, 'activo'),
(2, 'MacBook Air M2 13.6 Pulgadas', 'Chip Apple M2 de 8 núcleos, 8GB memoria unificada, SSD 256GB, Pantalla Liquid Retina', 4800000.00, 8, 'macbook_air_m2.jpg', 1, 'activo'),
(3, 'Laptop Lenovo Legion 5 Pro', 'AMD Ryzen 7 7745HX, 16GB RAM, SSD 1TB, NVIDIA RTX 4070 8GB, Pantalla 165Hz', 5900000.00, 3, 'lenovo_legion5.jpg', 1, 'activo'),
(4, 'Laptop HP Pavilion X360 Convertible', 'Intel Core i5 1235U, 8GB RAM, SSD 512GB, Pantalla Táctil 14 FHD', 2600000.00, 11, 'hp_pavilion_x360.jpg', 1, 'activo'),
(5, 'Laptop Dell XPS 13 Plus', 'Intel Core i7 1360P, 16GB RAM, SSD 1TB NVMe, Pantalla OLED 3.5K Táctil', 6400000.00, 1, 'prod_1791730576.jpg', 1, 'activo'),
(6, 'Tarjeta Gráfica NVIDIA RTX 4070 Ti Super', '16GB GDDR6X, DLSS 3.5, Ray Tracing de 3ra Generación, Arquitectura Ada Lovelace', 3900000.00, 3, 'rtx4070_ti.jpg', 2, 'activo'),
(7, 'Procesador AMD Ryzen 7 7800X3D', '8 núcleos, 16 hilos, 4.2GHz base, 104MB Cache con tecnología 3D V-Cache', 1850000.00, 10, 'ryzen_7800x3d.jpg', 2, 'activo'),
(8, 'Procesador Intel Core i9 14900K', '24 núcleos (8P + 16E), 32 hilos, hasta 6.0 GHz, Socket LGA1700', 2550000.00, 5, 'intel_i9_14900k.jpg', 2, 'activo'),
(9, 'Memoria RAM Corsair Vengeance DDR5 32GB', 'Kit 2x16GB 6000MHz CL30, optimizado para perfiles AMD EXPO e Intel XMP 3.0', 650000.00, 14, 'ram_corsair_32gb.jpg', 2, 'activo'),
(10, 'Placa Base ASUS ROG Strix Z790-F WiFi', 'Socket LGA1700, DDR5, PCIe 5.0, Wi-Fi 6E, Factor de forma ATX', 1450000.00, 6, 'prod_1791744330_7859.jpg', 2, 'activo'),
(11, 'Samsung Galaxy S24 Ultra', 'Pantalla Dynamic AMOLED 2X 6.8, 12GB RAM, 512GB, Cámara 200MP, S-Pen', 5100000.00, 7, 'samsung_s24_ultra.jpg', 3, 'activo'),
(12, 'iPhone 15 Pro Max 256GB', 'Titanio Natural, Chip A17 Pro, Pantalla Super Retina XDR 6.7, Cámara 48MP', 5600000.00, 5, 'iphone_15_promax.jpg', 3, 'activo'),
(13, 'Xiaomi 14 Ultra 5G', 'Procesador Snapdragon 8 Gen 3, 16GB RAM, 512GB, Óptica Leica Quad Camera', 4300000.00, 6, 'xiaomi_14_ultra.jpg', 3, 'activo'),
(14, 'Tablet Apple iPad Air M2 11 Pulgadas', 'Chip M2, 128GB Wi-Fi, Pantalla Liquid Retina, compatible con Apple Pencil Pro', 2900000.00, 9, 'ipad_air_m2.jpg', 3, 'activo'),
(15, 'Tablet Samsung Galaxy Tab S9 FE', 'Pantalla 10.9 90Hz, 6GB RAM, 128GB, incluye S-Pen, Resistencia IP68', 1750000.00, 11, 'prod_1791744259_7413.jpg', 3, 'activo'),
(16, 'Monitor Gamer Samsung Odyssey G7 27', 'Curvo 1000R, QHD (2560x1440), 240Hz, 1ms, HDR600, G-Sync Compatible', 2100000.00, 3, 'samsung_odyssey_g7.jpg', 4, 'activo'),
(17, 'Monitor LG UltraGear 24 144Hz', 'Pantalla IPS Full HD, 1ms MBR, AMD FreeSync Premium, Ajuste de Inclinación', 680000.00, 14, 'lg_ultragear_24.jpg', 4, 'activo'),
(18, 'Monitor Profesional ASUS ProArt 27 4K', 'Resolución 3840x2160 IPS, 100% sRGB, Calibración de fábrica Calman Verified', 1950000.00, 4, 'asus_proart_27.jpg', 4, 'activo'),
(19, 'Monitor Gamer Alienware 34 Curved OLED', 'UWQHD (3440x1440), 175Hz, 0.1ms, Quantum Dot OLED, VESA DisplayHDR True Black', 4600000.00, 2, 'alienware_34_oled.jpg', 4, 'activo'),
(20, 'Monitor Xiaomi Gaming Monitor G27i', '27 Pulgadas IPS, Full HD, 165Hz, 1ms, FreeSync, Bisel Delgado', 590000.00, 18, 'prod_1791744180_1297.jpg', 4, 'activo'),
(21, 'Teclado Mecánico Logitech G PRO X TKL', 'Switches Tactile, Conectividad LIGHTSPEED inalámbrica, Iluminación RGB LIGHTSYNC', 720000.00, 10, 'logitech_gpro_tkl.jpg', 5, 'activo'),
(22, 'Mouse Gamer Razer DeathAdder V3 Pro', 'Inalámbrico, Sensor Óptico Focus Pro 30K DPI, 63 gramos de peso ultra ligero', 580000.00, 12, 'razer_deathadder_v3.jpg', 5, 'activo'),
(23, 'Diadema HyperX Cloud III Inalámbrica', 'Audio Espacial DTS Headphone:X 3D, Autonomía de hasta 120 horas, Micrófono 10mm', 490000.00, 15, 'hyperx_cloud_3.jpg', 5, 'activo'),
(24, 'Micrófono Condensador Shure MV7 USB/XLR', 'Diseñado para Podcast y Streaming, Panel Táctil de Control, Salida de Auriculares', 1150000.00, 5, 'shure_mv7.jpg', 5, 'activo'),
(25, 'Mouse Ergonomico Logitech MX Master 3S', 'Sensor 8000 DPI, Desplazamiento MagSpeed silencioso, Conexión Multidispositivo', 420000.00, 20, 'prod_1791744107_8068.jpg', 5, 'activo'),
(26, 'SSD NVMe M.2 Samsung 990 PRO 2TB', 'PCIe Gen 4.0x4, Lectura hasta 7450 MB/s, Escritura 6900 MB/s con Disipador', 820000.00, 10, 'samsung_990pro_2tb.jpg', 6, 'activo'),
(27, 'SSD NVMe M.2 Kingston FURY Renegade 1TB', 'PCIe Gen 4.0x4, Velocidad de lectura 7300 MB/s, ideal para PC y PS5', 410000.00, 16, 'kingston_renegade_1tb.jpg', 6, 'activo'),
(28, 'Disco Duro Externo WD My Passport 4TB', 'USB 3.2 Gen 1, Cifrado por Hardware AES de 256 bits, Factor de Forma 2.5', 480000.00, 14, 'wd_mypassport_4tb.jpg', 6, 'activo'),
(29, 'SSD Portátil SanDisk Extreme 1TB', 'Inalámbrico/USB-C, Lectura 1050 MB/s, Protección contra caídas e IP65', 520000.00, 8, 'sandisk_extreme_1tb.jpg', 6, 'activo'),
(30, 'SSD SATA III Crucial BX500 480GB', 'Factor de Forma 2.5 Pulgadas, Lectura 540 MB/s, Mejora de Arranque de Sistema', 160000.00, 25, 'prod_1791744030_8705.jpg', 6, 'activo'),
(31, 'Router Gaming TP-Link Archer AXE75', 'Wi-Fi 6E Tribanda AX5400, Procesador Quad-Core 1.7GHz, Puerto USB 3.0', 780000.00, 6, 'tplink_archer_ax75.jpg', 7, 'activo'),
(32, 'Sistema Wi-Fi Mesh Mercusys Halo H80X (Pack x3)', 'Wi-Fi 6 Doble Banda AX3000, Cobertura hasta 650m², Conexión hasta 150 dispositivos', 650000.00, 8, 'mercusys_halo_h80x.jpg', 7, 'activo'),
(33, 'Switch Gigabit D-Link de 16 Puertos', 'Carcasa Metálica de Escritorio o Montaje en Rack, Plug and Play, Ahorro de Energía', 280000.00, 11, 'dlink_switch_16p.jpg', 7, 'activo'),
(34, 'Adaptador Wi-Fi USB TP-Link Archer TX20U Plus', 'Wi-Fi 6 Inalámbrico Dual Band AX1800, Antenas de Alta Ganancia USB 3.0', 140000.00, 18, 'tplink_tx20u_plus.jpg', 7, 'activo'),
(35, 'Router ASUS RT-AX82U AX5400', 'Wi-Fi 6 Dual-Band, Modo de Juego Móvil, AURA RGB, Soporte AiMesh', 890000.00, 4, 'prod_1791743891_8223.jpg', 7, 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Cliente'),
(3, 'Gestor de Productos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL DEFAULT 2,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`, `telefono`, `direccion`, `fecha_registro`) VALUES
(1, 'Administrador Principal', 'admin@mundotecnologico.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '+57 300 111 2233', 'Calle 100 # 15-20, Bogotá D.C.', '2026-10-11 03:16:48'),
(2, 'Carlos Gestor de Inventario', 'gestor@mundotecnologico.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 3, '+57 310 222 3344', 'Av. Carrera 45 # 108-10, Bogotá D.C.', '2026-10-11 03:16:48'),
(4, 'Juan Pérez', 'juan.perez@mundotecnologico.com', '$2y$10$IbuwL/NcOzCUxPluJ0OzAuD7ph/XT6Hpmiaaz9OvU2j1HZWrE8IPm', 2, '34343435444', '', '2026-10-11 03:18:35'),
(5, 'Ana Torres M', 'anat23@gmail.com', '$2y$10$8T/7uePp4F5.0bcO7AJxMO.s6/HY6HE3YBF3phAw0Ph7j1OuTVILG', 2, '34343435444', 'Calle 2 # 12A - 76', '2026-10-11 18:18:18');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD CONSTRAINT `detalle_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE SET NULL;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE SET NULL;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE CASCADE;
--
-- Base de datos: `farmacia`
--
CREATE DATABASE IF NOT EXISTS `farmacia` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `farmacia`;
--
-- Base de datos: `mundo_minv2`
--
CREATE DATABASE IF NOT EXISTS `mundo_minv2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `mundo_minv2`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`) VALUES
(1, 'Laptops'),
(2, 'Smartphones'),
(3, 'Audio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `estado` varchar(20) DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `precio`, `stock`, `id_categoria`, `estado`) VALUES
(1, 'Laptop Gamer Pro 16\"', 4500.00, 10, 1, 'activo'),
(2, 'Ultrabook Ejecutiva 14\"', 3200.00, 8, 1, 'activo'),
(3, 'Smartphone X 128GB', 2100.00, 15, 2, 'activo'),
(4, 'Smartphone Lite 64GB', 1200.00, 20, 2, 'activo'),
(5, 'Audífonos Inalámbricos ANC', 450.00, 25, 3, 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`) VALUES
(1, 'Administrador Master', 'admin@tienda.com', '123456', 1),
(2, 'Carlos Cliente', 'cliente@tienda.com', '123456', 2),
(3, 'Ana torres', 'anat23@gmail.com', 'anat23!', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
--
-- Base de datos: `mundo_tecnologico_db`
--
CREATE DATABASE IF NOT EXISTS `mundo_tecnologico_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mundo_tecnologico_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`, `descripcion`) VALUES
(1, 'Laptops y Portátiles', 'Equipos portátiles para trabajo, gaming y estudio'),
(2, 'Smartphones y Tablets', 'Dispositivos móviles de última generación'),
(3, 'Componentes de PC', 'Tarjetas de video, procesadores, memorias RAM y SSD'),
(4, 'Monitores y Pantallas', 'Monitores 4K, Gaming y de alta tasa de refresco'),
(5, 'Accesorios y Periféricos', 'Teclados, mouses, audífonos y combos gaming'),
(6, 'Almacenamiento Externo', 'Discos duros externos, SSD portátiles y memorias USB'),
(7, 'Redes y Conectividad', 'Routers WiFi 6, switches y adaptadores de red'),
(8, 'Audio y Sonido Pro', 'Parlantes bluetooth, micrófonos y barras de sonido'),
(9, 'Sillas y Escritorios Ergónomicos', 'Mobiliario para setups gaming y trabajo pesado'),
(10, 'Consolas y Videojuegos', 'Consolas de sobremesa, portátiles y accesorios gaming');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `numero_factura` varchar(50) NOT NULL,
  `fecha_compra` datetime DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `id_proveedor`, `numero_factura`, `fecha_compra`, `total`) VALUES
(1, 1, 'FACT-2026-001', '2026-01-10 09:30:00', 14500.00),
(2, 2, 'FACT-2026-002', '2026-01-15 11:00:00', 10497.00),
(3, 3, 'FACT-2026-003', '2026-02-01 14:20:00', 8750.00),
(4, 4, 'FACT-2026-004', '2026-02-10 10:15:00', 11990.00),
(5, 5, 'FACT-2026-005', '2026-02-20 16:45:00', 12990.00),
(6, 6, 'FACT-2026-006', '2026-03-01 08:00:00', 7996.00),
(7, 7, 'FACT-2026-007', '2026-03-05 13:10:00', 4975.00),
(8, 8, 'FACT-2026-008', '2026-03-12 15:30:00', 3750.00),
(9, 9, 'FACT-2026-009', '2026-03-18 10:00:00', 5250.00),
(10, 10, 'FACT-2026-010', '2026-03-25 17:00:00', 3580.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compras`
--

CREATE TABLE `detalle_compras` (
  `id_detalle_compra` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_costo` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_compras`
--

INSERT INTO `detalle_compras` (`id_detalle_compra`, `id_compra`, `id_producto`, `cantidad`, `precio_costo`) VALUES
(1, 1, 1, 10, 1150.00),
(2, 2, 2, 3, 2900.00),
(3, 3, 3, 5, 1400.00),
(4, 4, 11, 10, 950.00),
(5, 5, 12, 10, 1050.00),
(6, 6, 21, 4, 1600.00),
(7, 7, 41, 25, 150.00),
(8, 8, 25, 30, 120.00),
(9, 9, 24, 40, 90.00),
(10, 10, 43, 20, 130.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedidos`
--

CREATE TABLE `detalle_pedidos` (
  `id_detalle` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_pedidos`
--

INSERT INTO `detalle_pedidos` (`id_detalle`, `id_pedido`, `id_producto`, `cantidad`, `precio_unitario`) VALUES
(1, 1, 1, 1, 1450.00),
(2, 2, 11, 1, 1199.00),
(3, 3, 23, 1, 389.00),
(4, 4, 32, 1, 349.00),
(5, 5, 41, 1, 199.00),
(6, 6, 12, 1, 1299.00),
(7, 7, 25, 1, 175.00),
(8, 8, 49, 1, 159.00),
(9, 9, 5, 1, 650.00),
(10, 10, 3, 1, 1750.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_pedido` datetime DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `estado` enum('Pendiente','Completado','Cancelado') DEFAULT 'Completado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id_pedido`, `id_usuario`, `fecha_pedido`, `total`, `estado`) VALUES
(1, 2, '2026-03-01 10:00:00', 1450.00, 'Completado'),
(2, 3, '2026-03-02 11:30:00', 1199.00, 'Completado'),
(3, 4, '2026-03-03 14:15:00', 389.00, 'Completado'),
(4, 5, '2026-03-04 16:20:00', 349.00, 'Completado'),
(5, 6, '2026-03-05 09:45:00', 199.00, 'Completado'),
(6, 7, '2026-03-06 12:10:00', 1299.00, 'Completado'),
(7, 8, '2026-03-07 15:50:00', 175.00, 'Completado'),
(8, 9, '2026-03-08 18:00:00', 159.00, 'Completado'),
(9, 10, '2026-03-09 10:30:00', 650.00, 'Completado'),
(10, 2, '2026-03-10 13:40:00', 1750.00, 'Completado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `imagen` varchar(255) DEFAULT 'default.jpg',
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `id_categoria`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`, `fecha_creacion`) VALUES
(1, 1, 'Laptop Asus ROG Strix G16', 'Intel i7-13650HX, 16GB RAM, 512GB SSD, RTX 4060 8GB', 1450.00, 15, 'laptop_asus_rog.jpg', '2026-10-03 18:33:52'),
(2, 1, 'MacBook Pro 16 M3 Max', 'Apple M3 Max 36GB RAM, 1TB SSD, Pantalla Liquid Retina XDR', 3499.00, 8, 'macbook_pro_16.jpg', '2026-10-03 18:33:52'),
(3, 1, 'Lenovo Legion Pro 5', 'AMD Ryzen 7 7745HX, 32GB RAM, 1TB SSD, RTX 4070', 1750.00, 10, 'lenovo_legion.jpg', '2026-10-03 18:33:52'),
(4, 1, 'Dell XPS 13 Plus', 'Intel i7-1360P, 16GB RAM, 512GB SSD, OLED 3.5K Touch', 1399.00, 12, 'dell_xps_13.jpg', '2026-10-03 18:33:52'),
(5, 1, 'HP Victus 15', 'Intel i5-12450H, 8GB RAM, 512GB SSD, GTX 1650', 650.00, 25, 'hp_victus.jpg', '2026-10-03 18:33:52'),
(6, 1, 'Acer Predator Helios 18', 'Intel i9-13900HX, 32GB RAM, 2TB SSD, RTX 4080', 2899.00, 5, 'acer_predator.jpg', '2026-10-03 18:33:52'),
(7, 1, 'MSI Katana 15', 'Intel i7-12650H, 16GB RAM, 1TB SSD, RTX 4050', 999.00, 18, 'msi_katana.jpg', '2026-10-03 18:33:52'),
(8, 1, 'Asus Zenbook Duo 2024', 'Doble pantalla OLED 14\", Intel Core Ultra 7, 1TB SSD', 1699.00, 7, 'asus_zenbook_duo.jpg', '2026-10-03 18:33:52'),
(9, 1, 'Microsoft Surface Laptop 5', 'Intel i5 12th, 8GB RAM, 256GB SSD, Pantalla 13.5 Touch', 899.00, 14, 'surface_laptop.jpg', '2026-10-03 18:33:52'),
(10, 1, 'Gigabyte Aorus 17X', 'Intel i9-13980HX, 32GB RAM, 2TB SSD, RTX 4090 16GB', 3799.00, 3, 'gigabyte_aorus.jpg', '2026-10-03 18:33:52'),
(11, 2, 'iPhone 15 Pro Max 256GB', 'Titanio Natural, Chip A17 Pro, Cámara 48MP', 1199.00, 20, 'iphone_15_pro_max.jpg', '2026-10-03 18:33:52'),
(12, 2, 'Samsung Galaxy S24 Ultra', '512GB, Snapdragon 8 Gen 3, S-Pen, Titanio', 1299.00, 18, 'samsung_s24_ultra.jpg', '2026-10-03 18:33:52'),
(13, 2, 'Xiaomi 14 Ultra', '512GB, Lente Leica 1 pulgada, 16GB RAM', 1099.00, 10, 'xiaomi_14_ultra.jpg', '2026-10-03 18:33:52'),
(14, 2, 'Google Pixel 8 Pro', '128GB, Chip Google Tensor G3, Cámara Pro AI', 899.00, 15, 'pixel_8_pro.jpg', '2026-10-03 18:33:52'),
(15, 2, 'iPad Pro 12.9 M2', '256GB WiFi, Pantalla Liquid Retina XDR Mini-LED', 1099.00, 12, 'ipad_pro_129.jpg', '2026-10-03 18:33:52'),
(16, 2, 'Samsung Galaxy Tab S9 Ultra', '512GB, AMOLED 14.6\", Incluye S-Pen', 1149.00, 9, 'galaxy_tab_s9.jpg', '2026-10-03 18:33:52'),
(17, 2, 'OnePlus 12 512GB', '16GB RAM, Carga Rápida 100W, Snapdragon 8 Gen 3', 799.00, 14, 'oneplus_12.jpg', '2026-10-03 18:33:52'),
(18, 2, 'Motorola Edge 50 Ultra', '512GB, Pantalla pOLED 144Hz, Madera Real', 899.00, 11, 'motorola_edge_50.jpg', '2026-10-03 18:33:52'),
(19, 2, 'ASUS ROG Phone 8 Pro', '24GB RAM, 1TB SSD, Pantalla AMOLED 165Hz Gaming', 1299.00, 6, 'rog_phone_8.jpg', '2026-10-03 18:33:52'),
(20, 2, 'Xiaomi Redmi Note 13 Pro+ 5G', '256GB, Cámara 200MP, Carga 120W', 380.00, 30, 'redmi_note_13.jpg', '2026-10-03 18:33:52'),
(21, 3, 'Tarjeta de Video Nvidia RTX 4090 24GB', 'ASUS ROG Strix OC Edition Gaming', 1999.00, 4, 'rtx_4090.jpg', '2026-10-03 18:33:52'),
(22, 3, 'Procesador Intel Core i9-14900K', '24 Núcleos 32 Hilos, Hasta 6.0 GHz LGA1700', 589.00, 15, 'i9_14900k.jpg', '2026-10-03 18:33:52'),
(23, 3, 'Procesador AMD Ryzen 7 7800X3D', 'El mejor procesador para Gaming, 8 Core 3D V-Cache', 389.00, 22, 'ryzen_7800x3d.jpg', '2026-10-03 18:33:52'),
(24, 3, 'Memoria RAM Corsair Vengeance DDR5 32GB', '2x16GB 6000MHz CL30 RGB Black', 125.00, 45, 'ram_corsair_ddr5.jpg', '2026-10-03 18:33:52'),
(25, 3, 'SSD NVMe M.2 Samsung 990 Pro 2TB', 'Lectura hasta 7450 MB/s con Disipador', 175.00, 35, 'ssd_samsung_990.jpg', '2026-10-03 18:33:52'),
(26, 3, 'Tarjeta Madre ASUS ROG Maximus Z790 Hero', 'LGA1700, DDR5, PCIe 5.0, Wi-Fi 6E', 629.00, 8, 'motherboard_z790.jpg', '2026-10-03 18:33:52'),
(27, 3, 'Fuente de Poder Corsair RM1000x 1000W', 'Certificación 80 Plus Gold, Totalmente Modular', 189.00, 20, 'fuente_corsair_1000w.jpg', '2026-10-03 18:33:52'),
(28, 3, 'Enfriamiento Líquido NZXT Kraken Elite 360', 'Pantalla LCD Personalizable, 360mm RGB', 279.00, 12, 'nzxt_kraken_360.jpg', '2026-10-03 18:33:52'),
(29, 3, 'Tarjeta de Video AMD Radeon RX 7900 XTX', '24GB GDDR6, Sapphire Nitro+ Vapor-X', 999.00, 7, 'rx_7900_xtx.jpg', '2026-10-03 18:33:52'),
(30, 3, 'Gabinete PC Lian Li O11 Dynamic EVO', 'Cristal Templado Modular ATX White', 169.00, 15, 'lian_li_o11.jpg', '2026-10-03 18:33:52'),
(31, 4, 'Monitor Samsung Odyssey OLED G9 49\"', 'Curvo DQHD 240Hz 0.03ms Smart Gaming', 1499.00, 5, 'samsung_g9_oled.jpg', '2026-10-03 18:33:52'),
(32, 4, 'Monitor LG UltraGear 27GP850-B', '27\" Nano IPS QHD 165Hz 1ms G-Sync', 349.00, 25, 'lg_ultragear_27.jpg', '2026-10-03 18:33:52'),
(33, 4, 'Monitor Dell UltraSharp U2723QE', '27\" 4K UHD IPS Black, 100% sRGB, Hub USB-C', 549.00, 14, 'dell_ultrasharp_27.jpg', '2026-10-03 18:33:52'),
(34, 4, 'Monitor ASUS ROG Swift 32\" 4K 240Hz', 'OLED Gaming Dual Mode (4K 240Hz / FHD 480Hz)', 1299.00, 6, 'asus_rog_swift_32.jpg', '2026-10-03 18:33:52'),
(35, 4, 'Monitor BenQ ZOWIE XL2566K', '24.5\" 360Hz DyAc+ eSports Gaming', 599.00, 10, 'benq_zowie_360.jpg', '2026-10-03 18:33:52'),
(36, 4, 'Monitor MSI Optix MAG342CQR 34\"', 'UltraWide Curvo UWQHD 144Hz 1ms', 429.00, 12, 'msi_optix_34.jpg', '2026-10-03 18:33:52'),
(37, 4, 'Monitor Gigabyte M27Q', '27\" QHD 170Hz IPS con KVM Switch Incorporado', 279.00, 30, 'gigabyte_m27q.jpg', '2026-10-03 18:33:52'),
(38, 4, 'Monitor ViewSonic Elite XG270QG', '27\" IPS QHD 165Hz NVIDIA G-Sync Native', 499.00, 8, 'viewsonic_elite.jpg', '2026-10-03 18:33:52'),
(39, 4, 'Monitor AOC Gaming 24G2SP', '24\" Full HD IPS 165Hz Ergonomía Total', 159.00, 40, 'aoc_24g2.jpg', '2026-10-03 18:33:52'),
(40, 4, 'Monitor Xiaomi Curved Gaming Monitor 30\"', 'WFHD 200Hz 1800R AMD FreeSync Premium', 239.00, 18, 'xiaomi_monitor_30.jpg', '2026-10-03 18:33:52'),
(41, 5, 'Teclado Mecánico Logitech G Pro X TKL', 'Inalámbrico Lightspeed, Switches GX Brown', 199.00, 25, 'logitech_g_pro_keyboard.jpg', '2026-10-03 18:33:52'),
(42, 5, 'Mouse Inalámbrico Logitech G Pro X Superlight 2', 'Sensor HERO 2, 60g Peso, 32000 DPI', 159.00, 35, 'logitech_superlight_2.jpg', '2026-10-03 18:33:52'),
(43, 5, 'Audífonos Razer BlackShark V2 Pro 2023', 'Inalámbricos Esports, Micrófono HyperClear', 179.00, 28, 'razer_blackshark_v2.jpg', '2026-10-03 18:33:52'),
(44, 5, 'Teclado Corsair K100 RGB Mechanical', 'OPX Optical Switches, Rueda iCUE Control', 229.00, 10, 'corsair_k100.jpg', '2026-10-03 18:33:52'),
(45, 5, 'Mouse Razer DeathAdder V3 Pro', 'Inalámbrico Ultra Ligero 63g Ergonomía Pro', 149.00, 30, 'razer_deathadder_v3.jpg', '2026-10-03 18:33:52'),
(46, 5, 'Audífonos SteelSeries Arctis Nova Pro Wireless', 'Cancelación Activa de Ruido, Doble Batería', 349.00, 12, 'steelseries_arctis_nova.jpg', '2026-10-03 18:33:52'),
(47, 5, 'Silla Gaming Secretlab TITAN Evo 2024', 'Tejido SoftWeave Plus, Soporte Lumbar L-ADAPT', 549.00, 8, 'secretlab_titan.jpg', '2026-10-03 18:33:52'),
(48, 5, 'Micrófono Shure MV7 USB/XLR', 'Micrófono Dinámico para Podcast y Streaming', 249.00, 16, 'shure_mv7.jpg', '2026-10-03 18:33:52'),
(49, 5, 'Cámara Web Logitech Brio 4K', 'Ultra HD 4K HDR con Micrófonos Estéreo', 169.00, 22, 'logitech_brio_4k.jpg', '2026-10-03 18:33:52'),
(50, 5, 'Stream Deck Elgato MK.2', '15 Teclas LCD Personalizables para Control', 149.00, 20, 'elgato_stream_deck.jpg', '2026-10-03 18:33:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nit` varchar(20) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `direccion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nit`, `nombre`, `contacto`, `telefono`, `email`, `direccion`) VALUES
(1, '900123456-1', 'TechImport Colombia S.A.S.', 'Fernando López', '6015551234', 'ventas@techimport.co', 'Zona Franca Fontibón, Bogotá'),
(2, '900987654-2', 'Distribuidora Global Asus', 'Beatriz Ruiz', '6044445678', 'contacto@asusdistribuidores.com', 'Centro Empresarial El Poblado, Medellín'),
(3, '900555666-3', 'Mayorista Lenovo Latam', 'Guillermo Peña', '6023339988', 'gpena@lenovomayoristas.com', 'Zona Industrial Acopi, Yumbo'),
(4, '900111222-4', 'Apple Direct Colombia', 'Lucía Blanco', '6012223344', 'pedidos@appledirect.co', 'Calle 93 #11-19, Bogotá'),
(5, '900333444-5', 'Samsung Logistics S.A.', 'Hernán Gómez', '6056667788', 'hgomez@samsunglogistics.com', 'Via 40 #70-15, Barranquilla'),
(6, '900777888-6', 'Nvidia Colombia Partners', 'Patricia Marín', '6018889900', 'patricia@nvidiapartners.co', 'Carrera 7 #71-21, Bogotá'),
(7, '900222333-7', 'Logitech Wholesale Corp', 'Jorge Morales', '6042221100', 'jorge@logitechwholesale.com', 'Transversal Inferior, Medellín'),
(8, '900444555-8', 'Corsair & Elgato Supply', 'Diana Méndez', '6024443322', 'diana@corsairsupply.com', 'Avenida 6N #26N-10, Cali'),
(9, '900888999-9', 'Kingston Memory Latino', 'Roberto Soler', '6017778899', 'rsoler@kingstonlatino.com', 'Calle 26 #68C-61, Bogotá'),
(10, '900666111-0', 'Razer Gaming Wholesale', 'Esteban Parra', '6053334455', 'eparra@razerwholesale.co', 'Calle 79 #53-12, Barranquilla');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL DEFAULT 2,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `id_rol`, `nombre`, `email`, `password`, `telefono`, `direccion`, `fecha_registro`) VALUES
(1, 1, 'Carlos Mendoza (Admin)', 'admin@mundotecnologico.com', '$2y$10$e8W/8FvhH3B/zM3iE4W30.rQyI6R.0nJgG5yR7N3YxG1v1u5mZ4KS', '3001234567', 'Calle 100 #15-20, Bogotá', '2026-10-03 18:33:52'),
(2, 2, 'Juan Pérez', 'juan.perez@email.com', '$2y$10$e8W/8FvhH3B/zM3iE4W30.rQyI6R.0nJgG5yR7N3YxG1v1u5mZ4KS', '3109876543', 'Av. Siempre Viva 123, Medellín', '2026-10-03 18:33:52'),
(3, 2, 'María Rodríguez', 'maria.rodriguez@email.com', '$2y$10$e8W/8FvhH3B/zM3iE4W30.rQyI6R.0nJgG5yR7N3YxG1v1u5mZ4KS', '3204567890', 'Carrera 50 #80-10, Cali', '2026-10-03 18:33:52'),
(4, 2, 'Andrés Gómez', 'andres.gomez@email.com', '$2y$10$e8W/8FvhH3B/zM3iE4W30.rQyI6R.0nJgG5yR7N3YxG1v1u5mZ4KS', '3151112233', 'Calle 5 #10-15, Barranquilla', '2026-10-03 18:33:52'),
(5, 2, 'Laura Torres', 'laura.torres@email.com', '$2y$10$e8W/8FvhH3B/zM3iE4W30.rQyI6R.0nJgG5yR7N3YxG1v1u5mZ4KS', '3019988776', 'Transversal 25 #45-30, Bucaramanga', '2026-10-03 18:33:52'),
(6, 2, 'Diego Morales', 'diego.morales@email.com', '$2y$10$e8W/8FvhH3B/zM3iE4W30.rQyI6R.0nJgG5yR7N3YxG1v1u5mZ4KS', '3123344556', 'Diagonal 15 #30-40, Pereira', '2026-10-03 18:33:52'),
(7, 2, 'Sofia Castro', 'sofia.castro@email.com', '$2y$10$e8W/8FvhH3B/zM3iE4W30.rQyI6R.0nJgG5yR7N3YxG1v1u5mZ4KS', '3187766554', 'Calle 70 #12-05, Manizales', '2026-10-03 18:33:52'),
(8, 2, 'Camilo Vargas', 'camilo.vargas@email.com', '$2y$10$e8W/8FvhH3B/zM3iE4W30.rQyI6R.0nJgG5yR7N3YxG1v1u5mZ4KS', '3054433221', 'Carrera 15 #100-50, Cartagena', '2026-10-03 18:33:52'),
(9, 2, 'Valentina Ortiz', 'valentina.ortiz@email.com', '$2y$10$e8W/8FvhH3B/zM3iE4W30.rQyI6R.0nJgG5yR7N3YxG1v1u5mZ4KS', '3146655443', 'Calle 30 #20-10, Santa Marta', '2026-10-03 18:33:52'),
(10, 2, 'Gabriel Silva', 'gabriel.silva@email.com', '$2y$10$e8W/8FvhH3B/zM3iE4W30.rQyI6R.0nJgG5yR7N3YxG1v1u5mZ4KS', '3198877665', 'Avenida 6 #14-25, Cúcuta', '2026-10-03 18:33:52'),
(11, 2, 'Carlos Martinez', 'carlosmartinez@gmail.com', '$2y$10$wrdnf9W9YUG6yAwR56UjKuDsg0Ses0GS/pdk584E0qA02Ug/FISdS', '33454532322', 'calle 45 No 56 78 Pereira', '2026-10-03 19:42:22'),
(12, 2, 'hfrtr', 'aa@gmail.com', '$2y$10$wS6R50KUQRypJP7Thl7A1ONVmk8b7adqh9UdX2mJGfol4goJhy.6y', '3434343', 'fdfdfgf', '2026-10-06 17:46:49');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD PRIMARY KEY (`id_detalle_compra`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`),
  ADD UNIQUE KEY `nit` (`nit`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  MODIFY `id_detalle_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD CONSTRAINT `detalle_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD CONSTRAINT `detalle_pedidos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_pedidos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON UPDATE CASCADE;
--
-- Base de datos: `mundo_tecnologico_db2`
--
CREATE DATABASE IF NOT EXISTS `mundo_tecnologico_db2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mundo_tecnologico_db2`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`, `descripcion`) VALUES
(1, 'Laptops', 'Equipos portátiles de alto rendimiento'),
(2, 'Smartphones', 'Teléfonos inteligentes y accesorios'),
(3, 'Accesorios', 'Periféricos, mouses, teclados'),
(4, 'Monitores', 'Pantallas de alta resolución'),
(5, 'Componentes', 'Memorias RAM, discos SSD');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `estado` enum('Pendiente','Procesando','Enviado','Completado','Cancelado') DEFAULT 'Procesando'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compras`
--

CREATE TABLE `detalle_compras` (
  `id_detalle` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_inventario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `stock_actual` int(11) NOT NULL DEFAULT 0,
  `stock_minimo` int(11) NOT NULL DEFAULT 2,
  `id_proveedor` int(11) DEFAULT NULL,
  `ultima_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_inventario`, `id_producto`, `stock_actual`, `stock_minimo`, `id_proveedor`, `ultima_actualizacion`) VALUES
(1, 1, 10, 2, 1, '2026-10-04 20:36:59'),
(2, 2, 15, 3, 2, '2026-10-04 20:36:59'),
(3, 3, 30, 5, 1, '2026-10-04 20:36:59'),
(4, 4, 8, 2, 2, '2026-10-04 20:36:59'),
(5, 5, 25, 5, 1, '2026-10-04 20:36:59'),
(6, 6, 10, 2, 1, '2026-10-04 20:45:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id_pago` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `metodo_pago` enum('Tarjeta','Transferencia','Efectivo','PayPal') NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha_pago` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(255) DEFAULT 'default.jpg',
  `id_categoria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `imagen`, `id_categoria`) VALUES
(1, 'Laptop Gaming ASUS TUF', 'Intel Core i7, 16GB RAM, 512GB SSD, RTX 3060', 1200.00, 'default.jpg', 1),
(2, 'Smartphone Samsung Galaxy S23', '128GB, 8GB RAM, Cámara 50MP', 850.00, 'default.jpg', 2),
(3, 'Mouse Inalámbrico Logitech MX Master 3S', 'Sensor 8K DPI, Clic silencioso', 99.00, 'default.jpg', 3),
(4, 'Monitor Gamer LG UltraGear 27\"', '144Hz, 1ms, IPS, Full HD', 250.00, 'default.jpg', 4),
(5, 'Memoria RAM Corsair Vengeance 16GB', 'DDR4 3200MHz RGB', 65.00, 'default.jpg', 5),
(6, 'Laptop Gaming ASUS TUF', 'Laptop Gaming ASUS TUF', 1350000.00, 'default.jpg', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre`, `contacto`, `telefono`, `email`) VALUES
(1, 'TechSupply S.A.', 'Carlos Gómez', '555-1234', 'contacto@techsupply.com'),
(2, 'Global Electronics', 'María Rodríguez', '555-5678', 'ventas@globalelectronics.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`, `fecha_registro`) VALUES
(1, 'Administrador Principal', 'admin@mundotecnologico.com', '$2y$10$3zu2kP1EjrwnbVPWD7Xime7ETqucTtJ3ZENV3i7Gi0GDaeM8WuTMO', 1, '2026-10-04 20:36:59'),
(2, 'Juan Pérez', 'juan.perez@email.com', '$2y$10$XQnMEb1J.LyQCxU06QazoOzC7o0037jNksuYirZiBCJHt1noWgG.O', 2, '2026-10-04 20:36:59');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_inventario`),
  ADD UNIQUE KEY `id_producto` (`id_producto`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `id_compra` (`id_compra`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_inventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD CONSTRAINT `detalle_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE,
  ADD CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
--
-- Base de datos: `mundo_tecnologico_db3`
--
CREATE DATABASE IF NOT EXISTS `mundo_tecnologico_db3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mundo_tecnologico_db3`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT 'default_cat.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`, `descripcion`, `imagen`) VALUES
(1, 'Laptops y Portátiles', 'Equipos portátiles para trabajo, estudio y gaming', 'cat_1791159758_6ac2edce54ba3.jpg'),
(2, 'Smartphones', 'Teléfonos inteligentes de última generación', 'cat_1791159843_6ac2ee23b06e6.jpg'),
(3, 'Accesorios', 'Periféricos, cables, mouses y teclados', 'cat_1791159931_6ac2ee7b9ac9d.jpg'),
(4, 'Componentes de PC', 'Hardware interno para ensamblar o actualizar tu PC', 'cat_componentes.jpg'),
(5, 'Monitores y Pantallas', 'Monitores de alta definición y gamers', 'cat_monitores.jpg'),
(6, 'Audio y Sonido', 'Audífonos, parlantes y micrófonos', 'cat_1791159551_6ac2ecffa70bf.jpg'),
(7, 'Consolas y Videojuegos', 'Sistemas de entretenimiento y controles', 'cat_1791159675_6ac2ed7bac702.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `estado` enum('Pendiente','Procesando','Enviado','Completado','Cancelado') DEFAULT 'Completado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `id_usuario`, `fecha_compra`, `total`, `estado`) VALUES
(1, 2, '2026-10-10 14:33:38', 870000.00, 'Completado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `valor` text NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `clave`, `valor`, `descripcion`) VALUES
(1, 'nombre_tienda', 'Mundo Tecnológico V3', 'Nombre mostrado en el header'),
(2, 'nombre_sitio', 'Mundo Tecnológico V3', 'Nombre general de la aplicación'),
(3, 'logo_url', 'assets/img/logo_1791158605.png', 'Ruta relativa de la imagen del logotipo'),
(4, 'logo', 'assets/img/logo_1791158605.png', 'Alias del logotipo'),
(5, 'moneda', '$', 'Símbolo monetario usado'),
(6, 'email_contacto', 'contacto@mundotecnologico.com', 'Correo de contacto'),
(7, 'telefono', '+57 300 123 4567', 'Teléfono de contacto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compras`
--

CREATE TABLE `detalle_compras` (
  `id_detalle` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_compras`
--

INSERT INTO `detalle_compras` (`id_detalle`, `id_compra`, `id_producto`, `cantidad`, `precio_unitario`, `subtotal`) VALUES
(1, 1, 35, 1, 280000.00, 280000.00),
(2, 1, 29, 1, 590000.00, 590000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 10,
  `imagen` varchar(255) DEFAULT 'default_prod.jpg',
  `id_categoria` int(11) DEFAULT NULL,
  `id_proveedor` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`, `id_categoria`, `id_proveedor`) VALUES
(1, 'Laptop Asus ROG Strix G16', 'Intel Core i7, 16GB RAM, 512GB SSD, RTX 4060', 4500000.00, 10, 'prod_laptop1.jpg', 1, 1),
(2, 'MacBook Air M2', 'Apple M2, 8GB RAM, 256GB SSD, Liquid Retina 13.6\"', 5200000.00, 8, 'prod_laptop2.jpg', 1, 1),
(3, 'Lenovo IdeaPad Slim 3', 'AMD Ryzen 5, 8GB RAM, 512GB SSD', 2100000.00, 15, 'prod_laptop3.jpg', 1, 1),
(4, 'HP Pavilion 15', 'Intel Core i5, 16GB RAM, 512GB SSD, Táctil', 2800000.00, 12, 'prod_laptop4.jpg', 1, 1),
(5, 'Dell XPS 13 Plus', 'Intel Core i7, 16GB RAM, 1TB SSD', 6300000.00, 5, 'prod_1791160249_6ac2efb96f7ee.jpg', 1, 1),
(6, 'iPhone 15 Pro Max', '256GB, Chip A17 Pro, Titanio', 4800000.00, 10, 'prod_phone1.jpg', 2, 1),
(7, 'Samsung Galaxy S24 Ultra', '256GB, Snapdragon 8 Gen 3, Cámara 200MP', 5100000.00, 7, 'prod_phone2.jpg', 2, 1),
(8, 'Xiaomi 13T Pro', '512GB, 12GB RAM, Cámara Leica', 2400000.00, 18, 'prod_phone3.jpg', 2, 1),
(9, 'Motorola Edge 40 Neo', '256GB, Pantalla pOLED 144Hz', 1600000.00, 20, 'prod_phone4.jpg', 2, 1),
(10, 'Google Pixel 8 Pro', '128GB, Procesador Google Tensor G3', 3200000.00, 9, 'prod_1791160150_6ac2ef56ecaae.jpg', 2, 1),
(11, 'Mouse Inalámbrico Logitech MX Master 3S', 'Sensor 8000 DPI, Clics silenciosos', 420000.00, 30, 'prod_acc1.jpg', 3, 1),
(12, 'Teclado Mecánico Redragon Kumara', 'Switches Red RGB, Formato TKL', 180000.00, 40, 'prod_acc2.jpg', 3, 1),
(13, 'Soporte de Aluminio Regulable', 'Ergonómico para laptops de 10\" a 17\"', 85000.00, 50, 'prod_acc3.jpg', 3, 1),
(14, 'Hub USB-C 7 en 1 Anker', 'HDMI 4K, Lectora SD, Carga PD 100W', 160000.00, 22, 'prod_acc4.jpg', 3, 1),
(15, 'Webcam Logitech C920 HD Pro', 'Full HD 1080p con micrófono estéreo', 310000.00, 14, 'prod_1791160320_6ac2f000e0f61.jpg', 3, 1),
(16, 'Tarjeta de Video RTX 4070 Ventus', '12GB GDDR6X, DLSS 3, Ray Tracing', 3100000.00, 6, 'prod_1791160010_6ac2eecada189.jpg', 4, 1),
(17, 'Procesador AMD Ryzen 7 7800X3D', '8 Núcleos, 16 Hilos, 5.0GHz, AM5', 1950000.00, 11, 'prod_comp2.jpg', 4, 1),
(18, 'Memoria RAM Corsair Vengeance 32GB', 'DDR5 6000MHz RGB (2x16GB)', 620000.00, 25, 'prod_comp3.jpg', 4, 1),
(19, 'SSD M.2 NVMe Samsung 990 Pro 1TB', 'Lectura 7450 MB/s PCIe 4.0', 540000.00, 35, 'prod_comp4.jpg', 4, 1),
(20, 'Fuente de Poder ASUS ROG 850W', '80 Plus Gold, Totalmente Modular', 720000.00, 10, 'prod_comp5.jpg', 4, 1),
(21, 'Monitor Gamer LG UltraGear 27\"', '27\" IPS, 144Hz, 1ms, Full HD', 950000.00, 12, 'prod_mon1.jpg', 5, 1),
(22, 'Monitor Curvo Samsung Odyssey G5 32\"', '32\" QHD (2560x1440), 165Hz', 1650000.00, 8, 'prod_mon2.jpg', 5, 1),
(23, 'Monitor ASUS TUF Gaming 24\"', '23.8\" IPS Full HD, 165Hz', 780000.00, 16, 'prod_mon3.jpg', 5, 1),
(24, 'Monitor Dell UltraSharp 27\"', '27\" 4K UHD, Panel IPS, Hub USB-C', 2200000.00, 4, 'prod_mon4.jpg', 5, 1),
(25, 'Monitor MSI Optix 27\" Curvo', '27\" WQHD, 170Hz, 1ms', 1100000.00, 9, 'prod_mon5.jpg', 5, 1),
(26, 'Audífonos Sony WH-1000XM5', 'Cancelación de Ruido, Bluetooth 5.2', 1450000.00, 10, 'prod_aud1.jpg', 6, 1),
(27, 'Audífonos Gamer HyperX Cloud II', 'Sonido Envolvente 7.1 Virtual', 320000.00, 18, 'prod_aud2.jpg', 6, 1),
(28, 'Parlante Bluetooth JBL Charge 5', 'Potencia 40W, Impermeable IP67', 680000.00, 15, 'prod_aud3.jpg', 6, 1),
(29, 'Micrófono USB HyperX QuadCast S', 'Iluminación RGB, Filtro Pop', 590000.00, 11, 'prod_1791159038_6ac2eafe33989.jpg', 6, 1),
(30, 'Barra de Sonido Bose Solo II', 'Modo Diálogo, Conexión Óptica', 980000.00, 7, 'prod_aud5.jpg', 6, 1),
(31, 'Consola PlayStation 5 Standard', 'Con Lector de Discos, SSD 825GB', 2700000.00, 6, 'prod_con1.jpg', 7, 1),
(32, 'Consola Xbox Series X', '1TB SSD NVMe, 4K Real 120fps', 2600000.00, 8, 'prod_con2.jpg', 7, 1),
(33, 'Nintendo Switch OLED Model', 'Pantalla OLED 7\", 64GB', 1550000.00, 14, 'prod_con3.jpg', 7, 1),
(34, 'Control Inalámbrico DualSense PS5', 'Retroalimentación Háptica', 310000.00, 22, 'prod_con4.jpg', 7, 1),
(35, 'Control Inalámbrico Xbox Series', 'Color Carbon Black, Bluetooth', 280000.00, 19, 'prod_1791159613_6ac2ed3d26f4a.jpg', 7, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre`, `contacto`, `telefono`, `email`) VALUES
(1, 'TechSupplier S.A.', 'Carlos Pérez', '+57 310 987 6543', 'ventas@techsupplier.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL DEFAULT 2,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`, `fecha_registro`) VALUES
(1, 'Administrador Principal', 'admin@mundotecnologico.com', '$2y$10$e8K2Jj9Z218l98x3aY8q8.5gZ/B3Y4h1Z2Y3X4W5V6U7T8S9R', 1, '2026-10-04 18:34:40'),
(2, 'Juan Pérez', 'juan.perez@email.com', '$2y$10$9.7kL8g0q2k8q8q8q8q8q.5gZ/B3Y4h1Z2Y3X4W5V6U7T8S9R', 2, '2026-10-04 18:34:40'),
(3, 'Ana Guarin', 'anag@gmail.com', '$2y$10$.BjxS3kfkeAOYYkqnhBqs.aZ1gXrdWkTbWMI8vAMAsAKud.zI06X2', 2, '2026-10-04 18:43:03');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD CONSTRAINT `detalle_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE SET NULL;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE SET NULL,
  ADD CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE SET NULL;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
--
-- Base de datos: `mundo_tecnologico_db4`
--
CREATE DATABASE IF NOT EXISTS `mundo_tecnologico_db4` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mundo_tecnologico_db4`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT 'default_cat.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`, `descripcion`, `imagen`) VALUES
(1, 'Laptops y Portátiles', 'Equipos portátiles para trabajo, estudio y gaming', 'cat_1791159758_6ac2edce54ba3.jpg'),
(2, 'Smartphones', 'Teléfonos inteligentes de última generación', 'cat_1791159843_6ac2ee23b06e6.jpg'),
(3, 'Accesorios', 'Periféricos, cables, mouses y teclados', 'cat_1791159931_6ac2ee7b9ac9d.jpg'),
(4, 'Componentes de PC', 'Hardware interno para ensamblar o actualizar tu PC', 'cat_1791646159.jpg'),
(5, 'Monitores y Pantallas', 'Monitores de alta definición y gamers', 'cat_1791647648.jpg'),
(6, 'Audio y Sonido', 'Audífonos, parlantes y micrófonos', 'cat_1791159551_6ac2ecffa70bf.jpg'),
(7, 'Consolas y Videojuegos', 'Sistemas de entretenimiento y controles', 'cat_1791159675_6ac2ed7bac702.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `estado` enum('Pendiente','Procesando','Enviado','Completado','Cancelado') DEFAULT 'Completado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `id_usuario`, `fecha_compra`, `total`, `estado`) VALUES
(1, 2, '2026-10-10 15:57:04', 5299999.99, 'Completado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `valor` text NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `clave`, `valor`, `descripcion`) VALUES
(1, 'nombre_tienda', 'Mundo Tecnológico V4', 'Nombre mostrado en el header'),
(2, 'nombre_sitio', 'Mundo Tecnológico V3', 'Nombre general de la aplicación'),
(3, 'logo_url', 'assets/img/logo_1791158605.png', 'Ruta relativa de la imagen del logotipo'),
(4, 'logo', 'assets/img/logo_1791158605.png', 'Alias del logotipo'),
(5, 'moneda', '$', 'Símbolo monetario usado'),
(6, 'email_contacto', 'contacto@mundotecnologico.com', 'Correo de contacto'),
(7, 'telefono', '+57 300 123 4567', 'Teléfono de contacto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compras`
--

CREATE TABLE `detalle_compras` (
  `id_detalle` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_compras`
--

INSERT INTO `detalle_compras` (`id_detalle`, `id_compra`, `id_producto`, `cantidad`, `precio_unitario`, `subtotal`) VALUES
(1, 1, 33, 1, 1550000.00, 1550000.00),
(2, 1, 31, 1, 2849999.99, 2849999.99),
(3, 1, 34, 1, 310000.00, 310000.00),
(4, 1, 29, 1, 590000.00, 590000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 10,
  `imagen` varchar(255) DEFAULT 'default_prod.jpg',
  `id_categoria` int(11) DEFAULT NULL,
  `id_proveedor` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`, `id_categoria`, `id_proveedor`) VALUES
(1, 'Laptop Asus ROG Strix G16', 'Intel Core i7, 16GB RAM, 512GB SSD, RTX 4060', 4500000.00, 10, 'prod_laptop1.jpg', 1, 1),
(2, 'MacBook Air M2', 'Apple M2, 8GB RAM, 256GB SSD, Liquid Retina 13.6\"', 5200000.00, 8, 'prod_laptop2.jpg', 1, 1),
(3, 'Lenovo IdeaPad Slim 3', 'AMD Ryzen 5, 8GB RAM, 512GB SSD', 2100000.00, 15, 'prod_laptop3.jpg', 1, 1),
(4, 'HP Pavilion 15', 'Intel Core i5, 16GB RAM, 512GB SSD, Táctil', 2800000.00, 12, 'prod_laptop4.jpg', 1, 1),
(5, 'Dell XPS 13 Plus', 'Intel Core i7, 16GB RAM, 1TB SSD', 6300000.00, 5, 'prod_1791160249_6ac2efb96f7ee.jpg', 1, 1),
(6, 'iPhone 15 Pro Max', '256GB, Chip A17 Pro, Titanio', 4800000.00, 10, 'prod_phone1.jpg', 2, 1),
(7, 'Samsung Galaxy S24 Ultra', '256GB, Snapdragon 8 Gen 3, Cámara 200MP', 5100000.00, 7, 'prod_phone2.jpg', 2, 1),
(8, 'Xiaomi 13T Pro', '512GB, 12GB RAM, Cámara Leica', 2400000.00, 18, 'prod_phone3.jpg', 2, 1),
(9, 'Motorola Edge 40 Neo', '256GB, Pantalla pOLED 144Hz', 1600000.00, 20, 'prod_phone4.jpg', 2, 1),
(10, 'Google Pixel 8 Pro', '128GB, Procesador Google Tensor G3', 3200000.00, 9, 'prod_1791160150_6ac2ef56ecaae.jpg', 2, 1),
(11, 'Mouse Inalámbrico Logitech MX Master 3S', 'Sensor 8000 DPI, Clics silenciosos', 420000.00, 30, 'prod_acc1.jpg', 3, 1),
(12, 'Teclado Mecánico Redragon Kumara', 'Switches Red RGB, Formato TKL', 180000.00, 40, 'prod_acc2.jpg', 3, 1),
(13, 'Soporte de Aluminio Regulable', 'Ergonómico para laptops de 10\" a 17\"', 85000.00, 50, 'prod_acc3.jpg', 3, 1),
(14, 'Hub USB-C 7 en 1 Anker', 'HDMI 4K, Lectora SD, Carga PD 100W', 160000.00, 22, 'prod_acc4.jpg', 3, 1),
(15, 'Webcam Logitech C920 HD Pro', 'Full HD 1080p con micrófono estéreo', 310000.00, 14, 'prod_1791160320_6ac2f000e0f61.jpg', 3, 1),
(16, 'Tarjeta de Video RTX 4070 Ventus', '12GB GDDR6X, DLSS 3, Ray Tracing', 3100000.00, 6, 'prod_1791160010_6ac2eecada189.jpg', 4, 1),
(17, 'Procesador AMD Ryzen 7 7800X3D', '8 Núcleos, 16 Hilos, 5.0GHz, AM5', 1950000.00, 11, 'prod_comp2.jpg', 4, 1),
(18, 'Memoria RAM Corsair Vengeance 32GB', 'DDR5 6000MHz RGB (2x16GB)', 620000.00, 25, 'prod_comp3.jpg', 4, 1),
(19, 'SSD M.2 NVMe Samsung 990 Pro 1TB', 'Lectura 7450 MB/s PCIe 4.0', 540000.00, 35, 'prod_comp4.jpg', 4, 1),
(20, 'Fuente de Poder ASUS ROG 850W', '80 Plus Gold, Totalmente Modular', 720000.00, 10, 'prod_comp5.jpg', 4, 1),
(21, 'Monitor Gamer LG UltraGear 27\"', '27\" IPS, 144Hz, 1ms, Full HD', 950000.00, 12, 'prod_mon1.jpg', 5, 1),
(22, 'Monitor Curvo Samsung Odyssey G5 32\"', '32\" QHD (2560x1440), 165Hz', 1650000.00, 8, 'prod_mon2.jpg', 5, 1),
(23, 'Monitor ASUS TUF Gaming 24\"', '23.8\" IPS Full HD, 165Hz', 780000.00, 16, 'prod_mon3.jpg', 5, 1),
(24, 'Monitor Dell UltraSharp 27\"', '27\" 4K UHD, Panel IPS, Hub USB-C', 2200000.00, 4, 'prod_mon4.jpg', 5, 1),
(25, 'Monitor MSI Optix 27\" Curvo', '27\" WQHD, 170Hz, 1ms', 1100000.00, 9, 'prod_mon5.jpg', 5, 1),
(26, 'Audífonos Sony WH-1000XM5', 'Cancelación de Ruido, Bluetooth 5.2', 1450000.00, 10, 'prod_aud1.jpg', 6, 1),
(27, 'Audífonos Gamer HyperX Cloud II', 'Sonido Envolvente 7.1 Virtual', 320000.00, 18, 'prod_aud2.jpg', 6, 1),
(28, 'Parlante Bluetooth JBL Charge 5', 'Potencia 40W, Impermeable IP67', 680000.00, 15, 'prod_aud3.jpg', 6, 1),
(29, 'Micrófono USB HyperX QuadCast S', 'Iluminación RGB, Filtro Pop', 590000.00, 11, 'prod_1791159038_6ac2eafe33989.jpg', 6, 1),
(30, 'Barra de Sonido Bose Solo II', 'Modo Diálogo, Conexión Óptica', 980000.00, 7, 'prod_aud5.jpg', 6, 1),
(31, 'Consola PlayStation 5 Standard', 'Con Lector de Discos, SSD 825GB', 2849999.99, 9, 'prod_1791646223.jpg', 7, 1),
(32, 'Consola Xbox Series X', '1TB SSD NVMe, 4K Real 120fps', 2600000.00, 5, 'prod_con2.jpg', 7, 1),
(33, 'Nintendo Switch OLED Model', 'Pantalla OLED 7\", 64GB', 1550000.00, 13, 'prod_con3.jpg', 7, 1),
(34, 'Control Inalámbrico DualSense PS5', 'Retroalimentación Háptica', 310000.00, 21, 'prod_con4.jpg', 7, 1),
(35, 'Control Inalámbrico Xbox Series', 'Color Carbon Black, Bluetooth', 240000.00, 10, 'prod_1791159613_6ac2ed3d26f4a.jpg', 7, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre`, `contacto`, `telefono`, `email`) VALUES
(1, 'TechSupplier S.A.', 'Carlos Pérez', '+57 310 987 6543', 'ventas@techsupplier.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Cliente'),
(3, 'Gestor de Productos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL DEFAULT 2,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`, `fecha_registro`, `telefono`, `direccion`) VALUES
(1, 'Administrador Principal', 'admin@mundotecnologico.com', '$2y$10$e8K2Jj9Z218l98x3aY8q8.5gZ/B3Y4h1Z2Y3X4W5V6U7T8S9R', 1, '2026-10-04 18:34:40', NULL, NULL),
(2, 'Juan Pérez', 'juanp@email.com', '$2y$10$FmRhd5qJlAZ16zYOdWwbYOYJGjwC6BzMk66TTF5oIRsIqyeEmCZFK', 2, '2026-10-04 18:34:40', '34343435444', 'KM 8 callejón San Juan vía Candelaria'),
(3, 'Ana Guarin', 'anag@gmail.com', '$2y$10$.BjxS3kfkeAOYYkqnhBqs.aZ1gXrdWkTbWMI8vAMAsAKud.zI06X2', 2, '2026-10-04 18:43:03', NULL, NULL),
(6, 'Carlos Gestor', 'gestor@mundotecnologico.com', '$2y$10$qI4zYI5B/wS78I6T23Ea6.YI1Lw8uXjR4H7Z8x9Y0T1U2V3W4X5Y6', 3, '2026-10-10 09:15:28', '+57 300 000 0000', 'Sede Central'),
(7, 'Juan Ramírez Torres', 'juan.torres@email.com', '$2y$10$K22JMcJ4INp746IybCe6ieqFmKq2XrzU/i/s8UrP/0djcntt/mwpu', 3, '2026-10-10 10:32:38', '3023942324', 'Cra 6 #17-33 Pereira, Risaralda'),
(10, 'Luis Antonio Agudelo', 'luis.agudelo45@gmail.com', '$2y$10$OF2exqzxvErxo6qEXYbeU.pSgsLelK5hcOJ95I9d48yO5XzKqBy4K', 2, '2026-10-10 15:34:38', NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD CONSTRAINT `detalle_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE SET NULL;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE SET NULL,
  ADD CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE SET NULL;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
--
-- Base de datos: `mundo_tecnologico_db5`
--
CREATE DATABASE IF NOT EXISTS `mundo_tecnologico_db5` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mundo_tecnologico_db5`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT 'default_cat.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`, `descripcion`, `imagen`) VALUES
(1, 'Laptops y Portátiles', 'Equipos portátiles para trabajo, estudio y gaming', 'cat_1791670450.jpg'),
(2, 'Smartphones', 'Teléfonos inteligentes de última generación', 'cat_smartphones.jpg'),
(3, 'Accesorios', 'Periféricos, cables, mouses y fundas', 'cat_accesorios.jpg'),
(4, 'Componentes de PC', 'Hardware interno, procesadores y memorias', 'cat_componentes.jpg'),
(5, 'Monitores y Pantallas', 'Monitores gamer y profesionales', 'cat_monitores.jpg'),
(6, 'Audio y Sonido', 'Audífonos, parlantes y micrófonos', 'cat_audio.jpg'),
(7, 'Consolas y Videojuegos', 'Sistemas de entretenimiento y mandos', 'cat_1791667976.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `metodo_pago` varchar(50) DEFAULT 'Tarjeta Visa (Simulada)',
  `referencia_pago` varchar(100) DEFAULT NULL,
  `estado` enum('Pendiente','Procesando','Enviado','Completado','Cancelado') DEFAULT 'Completado',
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `iva` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `id_usuario`, `fecha_compra`, `total`, `metodo_pago`, `referencia_pago`, `estado`, `subtotal`, `iva`) VALUES
(9, 9, '2026-10-10 23:32:10', 13328000.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACACAFA5BAC2', 'Completado', 11200000.00, 2128000.00),
(10, 9, '2026-10-10 23:33:50', 2844100.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACACB5E72CE2', 'Completado', 2390000.00, 454100.00),
(11, 10, '2026-10-10 23:40:06', 3379600.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACACCD62D519', 'Completado', 2840000.00, 539600.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `valor` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `clave`, `valor`) VALUES
(1, 'nombre_tienda', 'Mundo Tecnológico S.A.S'),
(2, 'logo_url', 'assets/img/logo_1791668734.png'),
(3, 'acerca_titulo', 'Sobre Mundo Tecnológico S.A.S'),
(4, 'acerca_historia', 'Fundada en 2019, Mundo Tecnológico S.A.S nació con la visión de acercar la innovación y el hardware de última generación a cada hogar y empresa. Nos hemos consolidado como líderes en distribución de equipos portátiles, componentes de PC y dispositivos móviles, garantizando siempre calidad, respaldo y confianza.'),
(5, 'acerca_direccion', 'Calle 100 # 15-20, Oficina 402, Bogotá D.C., Colombia'),
(6, 'acerca_telefono', '+57 (1) 790 5500 / +57 310 400 5000'),
(7, 'acerca_email', 'mundotecnologico@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compras`
--

CREATE TABLE `detalle_compras` (
  `id_detalle` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `valor_iva` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_compras`
--

INSERT INTO `detalle_compras` (`id_detalle`, `id_compra`, `id_producto`, `cantidad`, `precio_unitario`, `subtotal`, `valor_iva`) VALUES
(10, 9, 5, 2, 5600000.00, 13328000.00, 2128000.00),
(11, 10, 32, 1, 2390000.00, 2844100.00, 454100.00),
(12, 11, 33, 2, 1420000.00, 3379600.00, 539600.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 10,
  `imagen` varchar(255) DEFAULT 'default_prod.jpg',
  `id_categoria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`, `id_categoria`) VALUES
(1, 'Laptop Asus ROG Strix 16', 'Intel i9 13a Gen, RTX 4070, 32GB RAM, 1TB SSD', 6850000.00, 8, 'laptop_asus_rog.jpg', 1),
(2, 'MacBook Pro 14 M3', 'Chip Apple M3 Pro, 18GB RAM, 512GB SSD', 7999000.00, 6, 'macbook_pro.jpg', 1),
(3, 'Laptop Lenovo Legion 5', 'AMD Ryzen 7, RTX 4060, 16GB RAM, 512GB SSD', 4350000.00, 12, 'lenovo_legion.jpg', 1),
(4, 'HP Pavilion 15', 'Intel i5 12a Gen, 16GB RAM, 512GB SSD', 2450000.00, 15, 'hp_pavilion.jpg', 1),
(5, 'Dell XPS 13 Plus', 'Intel i7 13a Gen, 16GB RAM, 1TB SSD, OLED', 5600000.00, 3, 'prod_1791670587.jpg', 1),
(6, 'Samsung Galaxy S24 Ultra', 'Pantalla AMOLED 6.8\", 12GB RAM, 256GB, S-Pen', 4899000.00, 10, 'galaxy_s24.jpg', 2),
(7, 'iPhone 15 Pro Max', 'Chip A17 Pro, Pantalla 6.7\", Titanium, 256GB', 5450000.00, 7, 'iphone15_promax.jpg', 2),
(8, 'Xiaomi 13T Pro', 'Cámara Leica, Dimensity 9200+, 12GB RAM, 512GB', 2399000.00, 14, 'xiaomi_13t.jpg', 2),
(9, 'Google Pixel 8 Pro', 'Procesador Tensor G3, Cámara Pro, 128GB', 3200000.00, 9, 'pixel_8pro.jpg', 2),
(10, 'Motorola Edge 40 Neo', 'Pantalla pOLED 144Hz, 256GB, Resistencia IP68', 1350000.00, 20, 'moto_edge40.jpg', 2),
(11, 'Mouse Logitech MX Master 3S', 'Ergonómico, sensor 8K DPI, silencioso', 390000.00, 25, 'mouse_mxmaster.jpg', 3),
(12, 'Teclado Mecánico Corsair K70', 'Switches Cherry MX Red, Iluminación RGB', 520000.00, 18, 'teclado_corsair.jpg', 3),
(13, 'Cargador Anker 65W GaN', 'Carga rápida USB-C triple puerto', 180000.00, 30, 'cargador_anker.jpg', 3),
(14, 'Hub USB-C 8 en 1 Baseus', 'Salida HDMI 4K, USB 3.0, Lector de tarjetas SD', 145000.00, 22, 'hub_baseus.jpg', 3),
(15, 'Mochila Impermeable Targus', 'Para portátiles de hasta 15.6 pulgadas', 120000.00, 40, 'mochila_targus.jpg', 3),
(16, 'Procesador Intel i7 14700K', '20 Núcleos, hasta 5.6 GHz, Socket LGA1700', 1850000.00, 11, 'intel_i7.jpg', 4),
(17, 'Tarjeta de Video RTX 4070 Ti', '12GB GDDR6X, DLSS 3.0, Ray Tracing', 3750000.00, 6, 'rtx_4070ti.jpg', 4),
(18, 'Memoria RAM Corsair Vengeance 32GB', 'DDR5 6000MHz (2x16GB) RGB', 680000.00, 16, 'ram_corsair.jpg', 4),
(19, 'SSD NVMe Samsung 990 Pro 2TB', 'Lectura hasta 7450 MB/s, PCIe 4.0', 790000.00, 14, 'ssd_samsung.jpg', 4),
(20, 'Fuente de Poder EVGA 850W', '80 Plus Gold, Certificación Modular', 490000.00, 4, 'fuente_evga.jpg', 4),
(21, 'Monitor Gamer Samsung Odyssey G7', '27\" QHD 240Hz, Curvo 1000R, 1ms', 2350000.00, 7, 'samsung_odyssey.jpg', 5),
(22, 'Monitor LG UltraGear 24 IPS', '24\" Full HD 144Hz, FreeSync, 1ms', 690000.00, 15, 'lg_ultragear.jpg', 5),
(23, 'Monitor ASUS TUF Gaming 32', '32\" Curved QHD 165Hz, HDR10', 1450000.00, 9, 'asus_tuf32.jpg', 5),
(24, 'Monitor Dell UltraSharp 27', '27\" 4K UHD, IPS 99% sRGB, USB-C Hub', 1890000.00, 8, 'dell_ultrasharp.jpg', 5),
(25, 'Monitor MSI Optix 27', '27\" FHD 180Hz, IPS, Esports Gaming', 850000.00, 12, 'msi_optix.jpg', 5),
(26, 'Audífonos Sony WH-1000XM5', 'Cancelación activa de ruido, 30h autonomía', 1550000.00, 18, 'sony_xm5.jpg', 6),
(27, 'AirPods Pro 2a Generación', 'Cancelación de ruido, estuche de carga USB-C', 1050000.00, 20, 'airpods_pro.jpg', 6),
(28, 'Parlante JBL Charge 5', 'Bluetooth, prueba de agua IP67, Powerbank', 620000.00, 24, 'jbl_charge5.jpg', 6),
(29, 'Micrófono HyperX QuadCast S', 'Condensador USB, iluminación RGB, Antivibración', 540000.00, 13, 'hyperx_quadcast.jpg', 6),
(30, 'Soundbar Samsung B550', '2.1 Canales con Subwoofer Inalámbrico 410W', 780000.00, 10, 'soundbar_samsung.jpg', 6),
(31, 'PlayStation 5 Slim 1TB', 'Consola Edición Estándar con Lector de Discos', 2490000.00, 13, 'prod_1791667943.jpg', 7),
(32, 'Xbox Series X 1TB', 'Consola 4K Gaming, 12 TFLOPS, SSD NVMe', 2390000.00, 6, 'xbox_seriesx.jpg', 7),
(33, 'Nintendo Switch OLED', 'Pantalla OLED 7\", 64GB, Edición Mario Red', 1420000.00, 9, 'switch_oled.jpg', 7),
(34, 'Control Inalámbrico DualSense PS5', 'Retroalimentación háptica y gatillos adaptativos', 310000.00, 30, 'control_ps5.jpg', 7),
(35, 'Control Xbox Wireless Robot White', 'Conexión Bluetooth para Xbox, PC y Celular', 280000.00, 25, 'control_xbox.jpg', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Cliente'),
(3, 'Gestor de Productos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL DEFAULT 2,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`, `telefono`, `direccion`, `fecha_registro`) VALUES
(1, 'Administrador', 'admin@mundotecnologico.com', '$2y$10$PrKQqCGknYiXN0qaDDlUMu138D8sNigcpKzxUIyCl6iE7Xnl/sg6u', 1, '', '', '2026-10-10 21:22:29'),
(4, 'Luis Antonio Agudelo', 'luis.agudelo45@gmail.com', '$2y$10$NnarbwpEDr1nEDeYcts6N.bTrpuN0TIHIwkkxwqfYfPWbglsMSgTC', 3, '', '', '2026-10-10 21:27:46'),
(7, 'Luis Armando Amaya', 'luis.amaya@gmail.com', '$2y$10$uGS2vBy2QUhduRYM3oNSBOZ16mv0TyzxKQ3naxZnPa/La0UPJbN4q', 1, '', '', '2026-10-10 23:04:55'),
(8, 'Juan Tovar M', 'gestor@mundotecnologico.com', '$2y$10$zPaautW1uMeVijglljmMnOVcijW7iMyqwnhUVW3GyYsmLTIVrxT8y', 3, '', '', '2026-10-10 23:19:55'),
(9, 'Juan Pérez', 'juan.perez@email.com', '$2y$10$07uDX2aZqMpZ5RwUeqpKVeb/QbNvsnqIHi2L4CgGF7o8Y.l8qrICi', 2, '', '', '2026-10-10 23:29:47'),
(10, 'Ana Torres M', 'anat23@gmail.com', '$2y$10$mAANJD.yfk5okAXDJ90wVerLaWhueXrnQnTdb0a5cYP1onKJy4que', 2, '3083942327', 'KM 8 callejón San Juan vía Candelaria', '2026-10-10 23:39:17');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD CONSTRAINT `detalle_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE SET NULL;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE SET NULL;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE CASCADE;
--
-- Base de datos: `mundo_tecnologico_db7`
--
CREATE DATABASE IF NOT EXISTS `mundo_tecnologico_db7` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mundo_tecnologico_db7`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT 'default_cat.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`, `descripcion`, `imagen`) VALUES
(1, 'Laptops y Portátiles', 'Equipos portátiles de alto rendimiento para trabajo, estudio y gaming.', 'cat_1791730335.jpg'),
(2, 'Componentes de PC', 'Tarjetas gráficas, procesadores, memorias RAM y placas base.', 'componentes.jpg'),
(3, 'Smartphones y Tablets', 'Dispositivos móviles de última generación, celulares gama alta y tablets.', 'cat_1791730634.jpg'),
(4, 'Monitores y Pantallas', 'Monitores gamer, pantallas 4K y monitores profesionales ultra-wide.', 'cat_1791730376.jpg'),
(5, 'Periféricos', 'Teclados mecánicos, ratones ergonómicos, diademas y micrófonos.', 'perifericos.jpg'),
(6, 'Almacenamiento', 'Unidades de estado sólido SSD NVMe y discos duros externos.', 'cat_1791740753.jpg'),
(7, 'Redes y Conectividad', 'Routers Wi-Fi 6, switches gigabit, repetidores y adaptadores de red.', 'redes.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT current_timestamp(),
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `iva` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `metodo_pago` varchar(50) DEFAULT 'Tarjeta Visa (Pasarela V6)',
  `referencia_pago` varchar(100) DEFAULT NULL,
  `estado` enum('Pendiente','Procesando','Enviado','Completado','Cancelado') DEFAULT 'Completado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `id_usuario`, `fecha_compra`, `subtotal`, `iva`, `total`, `metodo_pago`, `referencia_pago`, `estado`) VALUES
(2, 4, '2026-10-11 03:19:07', 2600000.00, 494000.00, 3094000.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACB002B1910C', 'Completado'),
(3, 4, '2026-10-11 03:19:32', 650000.00, 123500.00, 773500.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACB0044C6662', 'Completado'),
(4, 4, '2026-10-11 18:10:19', 6680000.00, 1269200.00, 7949200.00, 'Tarjeta de Crédito Visa', 'PAY-MUNDO-6ACBD10B39F6F', 'Completado'),
(5, 5, '2026-10-11 19:19:45', 490000.00, 93100.00, 583100.00, 'Tarjeta de Crédito Visa', 'PAY-MUNDO-6ACBE15116C2D', 'Completado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `valor` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `clave`, `valor`) VALUES
(1, 'nombre_tienda', 'Mundo Tecnológico S.A.S'),
(2, 'logo_url', 'assets/img/logo_1791688901.png'),
(3, 'acerca_titulo', 'Sobre Mundo Tecnológico S.A.S'),
(4, 'acerca_historia', 'Fundada en 2019 en la ciudad de Bogotá, Mundo Tecnológico V7 nació con la firme visión de acercar la innovación, el hardware de última generación y los componentes de alta gama a todo el mercado colombiano. A lo largo de los años nos hemos consolidado como líderes en distribución tecnológica, garantizando siempre respaldo, garantía, confianza absoluta y un servicio excepcional para cada uno de nuestros clientes y empresas aliadas.'),
(5, 'acerca_direccion', 'Calle 100 # 15-20, Oficina 402, Bogotá D.C., Colombia'),
(6, 'acerca_telefono', '+57 (1) 790 5500 / +57 310 400 5000'),
(7, 'acerca_email', 'mundotecnologico@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compras`
--

CREATE TABLE `detalle_compras` (
  `id_detalle` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `valor_iva` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_compras`
--

INSERT INTO `detalle_compras` (`id_detalle`, `id_compra`, `id_producto`, `cantidad`, `precio_unitario`, `valor_iva`, `subtotal`) VALUES
(1, 2, 4, 1, 2600000.00, 494000.00, 3094000.00),
(2, 3, 9, 1, 650000.00, 123500.00, 773500.00),
(3, 4, 5, 1, 6400000.00, 1216000.00, 7616000.00),
(4, 4, 33, 1, 280000.00, 53200.00, 333200.00),
(5, 5, 23, 1, 490000.00, 93100.00, 583100.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 10,
  `imagen` varchar(255) DEFAULT 'default_prod.jpg',
  `id_categoria` int(11) DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`, `id_categoria`, `estado`) VALUES
(1, 'Laptop Gamer ASUS ROG Strix G16', 'Intel Core i7 13700HX, 16GB RAM DDR5, 512GB SSD NVMe, NVIDIA RTX 4060 8GB', 5200000.00, 4, 'laptop_asus_rog.jpg', 1, 'activo'),
(2, 'MacBook Air M2 13.6 Pulgadas', 'Chip Apple M2 de 8 núcleos, 8GB memoria unificada, SSD 256GB, Pantalla Liquid Retina', 4800000.00, 8, 'macbook_air_m2.jpg', 1, 'activo'),
(3, 'Laptop Lenovo Legion 5 Pro', 'AMD Ryzen 7 7745HX, 16GB RAM, SSD 1TB, NVIDIA RTX 4070 8GB, Pantalla 165Hz', 5900000.00, 3, 'lenovo_legion5.jpg', 1, 'activo'),
(4, 'Laptop HP Pavilion X360 Convertible', 'Intel Core i5 1235U, 8GB RAM, SSD 512GB, Pantalla Táctil 14 FHD', 2600000.00, 11, 'hp_pavilion_x360.jpg', 1, 'activo'),
(5, 'Laptop Dell XPS 13 Plus', 'Intel Core i7 1360P, 16GB RAM, SSD 1TB NVMe, Pantalla OLED 3.5K Táctil', 6400000.00, 1, 'prod_1791730576.jpg', 1, 'activo'),
(6, 'Tarjeta Gráfica NVIDIA RTX 4070 Ti Super', '16GB GDDR6X, DLSS 3.5, Ray Tracing de 3ra Generación, Arquitectura Ada Lovelace', 3900000.00, 3, 'rtx4070_ti.jpg', 2, 'activo'),
(7, 'Procesador AMD Ryzen 7 7800X3D', '8 núcleos, 16 hilos, 4.2GHz base, 104MB Cache con tecnología 3D V-Cache', 1850000.00, 10, 'ryzen_7800x3d.jpg', 2, 'activo'),
(8, 'Procesador Intel Core i9 14900K', '24 núcleos (8P + 16E), 32 hilos, hasta 6.0 GHz, Socket LGA1700', 2550000.00, 5, 'intel_i9_14900k.jpg', 2, 'activo'),
(9, 'Memoria RAM Corsair Vengeance DDR5 32GB', 'Kit 2x16GB 6000MHz CL30, optimizado para perfiles AMD EXPO e Intel XMP 3.0', 650000.00, 14, 'ram_corsair_32gb.jpg', 2, 'activo'),
(10, 'Placa Base ASUS ROG Strix Z790-F WiFi', 'Socket LGA1700, DDR5, PCIe 5.0, Wi-Fi 6E, Factor de forma ATX', 1450000.00, 6, 'prod_1791744330_7859.jpg', 2, 'activo'),
(11, 'Samsung Galaxy S24 Ultra', 'Pantalla Dynamic AMOLED 2X 6.8, 12GB RAM, 512GB, Cámara 200MP, S-Pen', 5100000.00, 7, 'samsung_s24_ultra.jpg', 3, 'activo'),
(12, 'iPhone 15 Pro Max 256GB', 'Titanio Natural, Chip A17 Pro, Pantalla Super Retina XDR 6.7, Cámara 48MP', 5600000.00, 5, 'iphone_15_promax.jpg', 3, 'activo'),
(13, 'Xiaomi 14 Ultra 5G', 'Procesador Snapdragon 8 Gen 3, 16GB RAM, 512GB, Óptica Leica Quad Camera', 4300000.00, 6, 'xiaomi_14_ultra.jpg', 3, 'activo'),
(14, 'Tablet Apple iPad Air M2 11 Pulgadas', 'Chip M2, 128GB Wi-Fi, Pantalla Liquid Retina, compatible con Apple Pencil Pro', 2900000.00, 9, 'ipad_air_m2.jpg', 3, 'activo'),
(15, 'Tablet Samsung Galaxy Tab S9 FE', 'Pantalla 10.9 90Hz, 6GB RAM, 128GB, incluye S-Pen, Resistencia IP68', 1750000.00, 11, 'prod_1791744259_7413.jpg', 3, 'activo'),
(16, 'Monitor Gamer Samsung Odyssey G7 27', 'Curvo 1000R, QHD (2560x1440), 240Hz, 1ms, HDR600, G-Sync Compatible', 2100000.00, 3, 'samsung_odyssey_g7.jpg', 4, 'activo'),
(17, 'Monitor LG UltraGear 24 144Hz', 'Pantalla IPS Full HD, 1ms MBR, AMD FreeSync Premium, Ajuste de Inclinación', 680000.00, 14, 'lg_ultragear_24.jpg', 4, 'activo'),
(18, 'Monitor Profesional ASUS ProArt 27 4K', 'Resolución 3840x2160 IPS, 100% sRGB, Calibración de fábrica Calman Verified', 1950000.00, 4, 'asus_proart_27.jpg', 4, 'activo'),
(19, 'Monitor Gamer Alienware 34 Curved OLED', 'UWQHD (3440x1440), 175Hz, 0.1ms, Quantum Dot OLED, VESA DisplayHDR True Black', 4600000.00, 2, 'alienware_34_oled.jpg', 4, 'activo'),
(20, 'Monitor Xiaomi Gaming Monitor G27i', '27 Pulgadas IPS, Full HD, 165Hz, 1ms, FreeSync, Bisel Delgado', 590000.00, 18, 'prod_1791744180_1297.jpg', 4, 'activo'),
(21, 'Teclado Mecánico Logitech G PRO X TKL', 'Switches Tactile, Conectividad LIGHTSPEED inalámbrica, Iluminación RGB LIGHTSYNC', 720000.00, 10, 'logitech_gpro_tkl.jpg', 5, 'activo'),
(22, 'Mouse Gamer Razer DeathAdder V3 Pro', 'Inalámbrico, Sensor Óptico Focus Pro 30K DPI, 63 gramos de peso ultra ligero', 580000.00, 12, 'razer_deathadder_v3.jpg', 5, 'activo'),
(23, 'Diadema HyperX Cloud III Inalámbrica', 'Audio Espacial DTS Headphone:X 3D, Autonomía de hasta 120 horas, Micrófono 10mm', 490000.00, 14, 'hyperx_cloud_3.jpg', 5, 'activo'),
(24, 'Micrófono Condensador Shure MV7 USB/XLR', 'Diseñado para Podcast y Streaming, Panel Táctil de Control, Salida de Auriculares', 1150000.00, 5, 'shure_mv7.jpg', 5, 'activo'),
(25, 'Mouse Ergonomico Logitech MX Master 3S', 'Sensor 8000 DPI, Desplazamiento MagSpeed silencioso, Conexión Multidispositivo', 420000.00, 20, 'prod_1791744107_8068.jpg', 5, 'activo'),
(26, 'SSD NVMe M.2 Samsung 990 PRO 2TB', 'PCIe Gen 4.0x4, Lectura hasta 7450 MB/s, Escritura 6900 MB/s con Disipador', 820000.00, 10, 'samsung_990pro_2tb.jpg', 6, 'activo'),
(27, 'SSD NVMe M.2 Kingston FURY Renegade 1TB', 'PCIe Gen 4.0x4, Velocidad de lectura 7300 MB/s, ideal para PC y PS5', 410000.00, 16, 'kingston_renegade_1tb.jpg', 6, 'activo'),
(28, 'Disco Duro Externo WD My Passport 4TB', 'USB 3.2 Gen 1, Cifrado por Hardware AES de 256 bits, Factor de Forma 2.5', 480000.00, 14, 'wd_mypassport_4tb.jpg', 6, 'activo'),
(29, 'SSD Portátil SanDisk Extreme 1TB', 'Inalámbrico/USB-C, Lectura 1050 MB/s, Protección contra caídas e IP65', 520000.00, 8, 'prod_1792456357_1605.jpg', 6, 'activo'),
(30, 'SSD SATA III Crucial BX500 480GB', 'Factor de Forma 2.5 Pulgadas, Lectura 540 MB/s, Mejora de Arranque de Sistema', 160000.00, 25, 'prod_1791744030_8705.jpg', 6, 'activo'),
(31, 'Router Gaming TP-Link Archer AXE75', 'Wi-Fi 6E Tribanda AX5400, Procesador Quad-Core 1.7GHz, Puerto USB 3.0', 780000.00, 6, 'tplink_archer_ax75.jpg', 7, 'activo'),
(32, 'Sistema Wi-Fi Mesh Mercusys Halo H80X (Pack x3)', 'Wi-Fi 6 Doble Banda AX3000, Cobertura hasta 650m², Conexión hasta 150 dispositivos', 650000.00, 8, 'mercusys_halo_h80x.jpg', 7, 'activo'),
(33, 'Switch Gigabit D-Link de 16 Puertos', 'Carcasa Metálica de Escritorio o Montaje en Rack, Plug and Play, Ahorro de Energía', 280000.00, 11, 'dlink_switch_16p.jpg', 7, 'activo'),
(34, 'Adaptador Wi-Fi USB TP-Link Archer TX20U Plus', 'Wi-Fi 6 Inalámbrico Dual Band AX1800, Antenas de Alta Ganancia USB 3.0', 140000.00, 18, 'tplink_tx20u_plus.jpg', 7, 'activo'),
(35, 'Router ASUS RT-AX82U AX5400', 'Wi-Fi 6 Dual-Band, Modo de Juego Móvil, AURA RGB, Soporte AiMesh', 890000.00, 4, 'prod_1791743891_8223.jpg', 7, 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Cliente'),
(3, 'Gestor de Productos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL DEFAULT 2,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `pin_recuperacion` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`, `telefono`, `direccion`, `fecha_registro`, `pin_recuperacion`) VALUES
(1, 'Administrador Principal', 'admin@mundotecnologico.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '+57 300 111 2233', 'Calle 100 # 15-20, Bogotá D.C.', '2026-10-11 03:16:48', NULL),
(2, 'Carlos Gestor de Inventario', 'gestor@mundotecnologico.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 3, '+57 310 222 3344', 'Av. Carrera 45 # 108-10, Bogotá D.C.', '2026-10-11 03:16:48', NULL),
(4, 'Juan Pérez', 'juan.perez@mundotecnologico.com', '$2y$10$IbuwL/NcOzCUxPluJ0OzAuD7ph/XT6Hpmiaaz9OvU2j1HZWrE8IPm', 2, '34343435444', '', '2026-10-11 03:18:35', NULL),
(5, 'Ana Torres M', 'anat23@gmail.com', '$2y$10$N7w1SnDMiKdIxA/g8bNyneQHqHWWS66yHHIa1B3Y3q.Y7wZ01Hza6', 2, '34343435444', 'Calle 2 # 12A - 76', '2026-10-11 18:18:18', NULL),
(6, 'Maria Paredes', 'maria.paredes@gmail.com', '$2y$10$joeXV51Xr7b5Qcaf/gTyAu9K5aVFYUpb36xfE5TeCcPajE2V6pEze', 2, '5656767654', 'KM 8 callejón San Juan vía Candelaria', '2026-10-19 21:52:23', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD CONSTRAINT `detalle_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE SET NULL;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE SET NULL;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE CASCADE;
--
-- Base de datos: `mundo_tecnologico_db8`
--
CREATE DATABASE IF NOT EXISTS `mundo_tecnologico_db8` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mundo_tecnologico_db8`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT 'default_cat.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`, `descripcion`, `imagen`) VALUES
(1, 'Laptops y Portátiles', 'Equipos portátiles de alto rendimiento para trabajo, estudio y gaming.', 'cat_1791730335.jpg'),
(2, 'Componentes de PC', 'Tarjetas gráficas, procesadores, memorias RAM y placas base.', 'componentes.jpg'),
(3, 'Smartphones y Tablets', 'Dispositivos móviles de última generación, celulares gama alta y tablets.', 'cat_1791730634.jpg'),
(4, 'Monitores y Pantallas', 'Monitores gamer, pantallas 4K y monitores profesionales ultra-wide.', 'cat_1791730376.jpg'),
(5, 'Periféricos', 'Teclados mecánicos, ratones ergonómicos, diademas y micrófonos.', 'perifericos.jpg'),
(6, 'Almacenamiento', 'Unidades de estado sólido SSD NVMe y discos duros externos.', 'cat_1791740753.jpg'),
(7, 'Redes y Conectividad', 'Routers Wi-Fi 6, switches gigabit, repetidores y adaptadores de red.', 'redes.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT current_timestamp(),
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `iva` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `metodo_pago` varchar(50) DEFAULT 'Tarjeta Visa (Pasarela V6)',
  `referencia_pago` varchar(100) DEFAULT NULL,
  `estado` enum('Pendiente','Procesando','Enviado','Completado','Cancelado') DEFAULT 'Completado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `id_usuario`, `fecha_compra`, `subtotal`, `iva`, `total`, `metodo_pago`, `referencia_pago`, `estado`) VALUES
(2, 4, '2026-10-11 03:19:07', 2600000.00, 494000.00, 3094000.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACB002B1910C', 'Completado'),
(3, 4, '2026-10-11 03:19:32', 650000.00, 123500.00, 773500.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACB0044C6662', 'Completado'),
(4, 4, '2026-10-11 18:10:19', 6680000.00, 1269200.00, 7949200.00, 'Tarjeta de Crédito Visa', 'PAY-MUNDO-6ACBD10B39F6F', 'Completado'),
(5, 5, '2026-10-11 19:19:45', 490000.00, 93100.00, 583100.00, 'Tarjeta de Crédito Visa', 'PAY-MUNDO-6ACBE15116C2D', 'Completado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `valor` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `clave`, `valor`) VALUES
(1, 'nombre_tienda', 'Mundo Tecnológico S.A.S'),
(2, 'logo_url', 'assets/img/logo_1791688901.png'),
(3, 'acerca_titulo', 'Sobre Mundo Tecnológico V6 S.A.S'),
(4, 'acerca_historia', 'Fundada en 2019 en la ciudad de Bogotá, Mundo Tecnológico V6 nació con la firme visión de acercar la innovación, el hardware de última generación y los componentes de alta gama a todo el mercado colombiano. A lo largo de los años nos hemos consolidado como líderes en distribución tecnológica, garantizando siempre respaldo, garantía, confianza absoluta y un servicio excepcional para cada uno de nuestros clientes y empresas aliadas.'),
(5, 'acerca_direccion', 'Calle 100 # 15-20, Oficina 402, Bogotá D.C., Colombia'),
(6, 'acerca_telefono', '+57 (1) 790 5500 / +57 310 400 5000'),
(7, 'acerca_email', 'mundotecnologico@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compras`
--

CREATE TABLE `detalle_compras` (
  `id_detalle` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `valor_iva` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_compras`
--

INSERT INTO `detalle_compras` (`id_detalle`, `id_compra`, `id_producto`, `cantidad`, `precio_unitario`, `valor_iva`, `subtotal`) VALUES
(1, 2, 4, 1, 2600000.00, 494000.00, 3094000.00),
(2, 3, 9, 1, 650000.00, 123500.00, 773500.00),
(3, 4, 5, 1, 6400000.00, 1216000.00, 7616000.00),
(4, 4, 33, 1, 280000.00, 53200.00, 333200.00),
(5, 5, 23, 1, 490000.00, 93100.00, 583100.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 10,
  `imagen` varchar(255) DEFAULT 'default_prod.jpg',
  `id_categoria` int(11) DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`, `id_categoria`, `estado`) VALUES
(1, 'Laptop Gamer ASUS ROG Strix G16', 'Intel Core i7 13700HX, 16GB RAM DDR5, 512GB SSD NVMe, NVIDIA RTX 4060 8GB', 5200000.00, 4, 'laptop_asus_rog.jpg', 1, 'activo'),
(2, 'MacBook Air M2 13.6 Pulgadas', 'Chip Apple M2 de 8 núcleos, 8GB memoria unificada, SSD 256GB, Pantalla Liquid Retina', 4800000.00, 8, 'macbook_air_m2.jpg', 1, 'activo'),
(3, 'Laptop Lenovo Legion 5 Pro', 'AMD Ryzen 7 7745HX, 16GB RAM, SSD 1TB, NVIDIA RTX 4070 8GB, Pantalla 165Hz', 5900000.00, 3, 'lenovo_legion5.jpg', 1, 'activo'),
(4, 'Laptop HP Pavilion X360 Convertible', 'Intel Core i5 1235U, 8GB RAM, SSD 512GB, Pantalla Táctil 14 FHD', 2600000.00, 11, 'hp_pavilion_x360.jpg', 1, 'activo'),
(5, 'Laptop Dell XPS 13 Plus', 'Intel Core i7 1360P, 16GB RAM, SSD 1TB NVMe, Pantalla OLED 3.5K Táctil', 6400000.00, 1, 'prod_1791730576.jpg', 1, 'activo'),
(6, 'Tarjeta Gráfica NVIDIA RTX 4070 Ti Super', '16GB GDDR6X, DLSS 3.5, Ray Tracing de 3ra Generación, Arquitectura Ada Lovelace', 3900000.00, 3, 'rtx4070_ti.jpg', 2, 'activo'),
(7, 'Procesador AMD Ryzen 7 7800X3D', '8 núcleos, 16 hilos, 4.2GHz base, 104MB Cache con tecnología 3D V-Cache', 1850000.00, 10, 'ryzen_7800x3d.jpg', 2, 'activo'),
(8, 'Procesador Intel Core i9 14900K', '24 núcleos (8P + 16E), 32 hilos, hasta 6.0 GHz, Socket LGA1700', 2550000.00, 5, 'intel_i9_14900k.jpg', 2, 'activo'),
(9, 'Memoria RAM Corsair Vengeance DDR5 32GB', 'Kit 2x16GB 6000MHz CL30, optimizado para perfiles AMD EXPO e Intel XMP 3.0', 650000.00, 14, 'ram_corsair_32gb.jpg', 2, 'activo'),
(10, 'Placa Base ASUS ROG Strix Z790-F WiFi', 'Socket LGA1700, DDR5, PCIe 5.0, Wi-Fi 6E, Factor de forma ATX', 1450000.00, 6, 'prod_1791744330_7859.jpg', 2, 'activo'),
(11, 'Samsung Galaxy S24 Ultra', 'Pantalla Dynamic AMOLED 2X 6.8, 12GB RAM, 512GB, Cámara 200MP, S-Pen', 5100000.00, 7, 'samsung_s24_ultra.jpg', 3, 'activo'),
(12, 'iPhone 15 Pro Max 256GB', 'Titanio Natural, Chip A17 Pro, Pantalla Super Retina XDR 6.7, Cámara 48MP', 5600000.00, 5, 'iphone_15_promax.jpg', 3, 'activo'),
(13, 'Xiaomi 14 Ultra 5G', 'Procesador Snapdragon 8 Gen 3, 16GB RAM, 512GB, Óptica Leica Quad Camera', 4300000.00, 6, 'xiaomi_14_ultra.jpg', 3, 'activo'),
(14, 'Tablet Apple iPad Air M2 11 Pulgadas', 'Chip M2, 128GB Wi-Fi, Pantalla Liquid Retina, compatible con Apple Pencil Pro', 2900000.00, 9, 'ipad_air_m2.jpg', 3, 'activo'),
(15, 'Tablet Samsung Galaxy Tab S9 FE', 'Pantalla 10.9 90Hz, 6GB RAM, 128GB, incluye S-Pen, Resistencia IP68', 1750000.00, 11, 'prod_1791744259_7413.jpg', 3, 'activo'),
(16, 'Monitor Gamer Samsung Odyssey G7 27', 'Curvo 1000R, QHD (2560x1440), 240Hz, 1ms, HDR600, G-Sync Compatible', 2100000.00, 3, 'samsung_odyssey_g7.jpg', 4, 'activo'),
(17, 'Monitor LG UltraGear 24 144Hz', 'Pantalla IPS Full HD, 1ms MBR, AMD FreeSync Premium, Ajuste de Inclinación', 680000.00, 14, 'lg_ultragear_24.jpg', 4, 'activo'),
(18, 'Monitor Profesional ASUS ProArt 27 4K', 'Resolución 3840x2160 IPS, 100% sRGB, Calibración de fábrica Calman Verified', 1950000.00, 4, 'asus_proart_27.jpg', 4, 'activo'),
(19, 'Monitor Gamer Alienware 34 Curved OLED', 'UWQHD (3440x1440), 175Hz, 0.1ms, Quantum Dot OLED, VESA DisplayHDR True Black', 4600000.00, 2, 'alienware_34_oled.jpg', 4, 'activo'),
(20, 'Monitor Xiaomi Gaming Monitor G27i', '27 Pulgadas IPS, Full HD, 165Hz, 1ms, FreeSync, Bisel Delgado', 590000.00, 18, 'prod_1791744180_1297.jpg', 4, 'activo'),
(21, 'Teclado Mecánico Logitech G PRO X TKL', 'Switches Tactile, Conectividad LIGHTSPEED inalámbrica, Iluminación RGB LIGHTSYNC', 720000.00, 10, 'logitech_gpro_tkl.jpg', 5, 'activo'),
(22, 'Mouse Gamer Razer DeathAdder V3 Pro', 'Inalámbrico, Sensor Óptico Focus Pro 30K DPI, 63 gramos de peso ultra ligero', 580000.00, 12, 'razer_deathadder_v3.jpg', 5, 'activo'),
(23, 'Diadema HyperX Cloud III Inalámbrica', 'Audio Espacial DTS Headphone:X 3D, Autonomía de hasta 120 horas, Micrófono 10mm', 490000.00, 14, 'hyperx_cloud_3.jpg', 5, 'activo'),
(24, 'Micrófono Condensador Shure MV7 USB/XLR', 'Diseñado para Podcast y Streaming, Panel Táctil de Control, Salida de Auriculares', 1150000.00, 5, 'shure_mv7.jpg', 5, 'activo'),
(25, 'Mouse Ergonomico Logitech MX Master 3S', 'Sensor 8000 DPI, Desplazamiento MagSpeed silencioso, Conexión Multidispositivo', 420000.00, 20, 'prod_1791744107_8068.jpg', 5, 'activo'),
(26, 'SSD NVMe M.2 Samsung 990 PRO 2TB', 'PCIe Gen 4.0x4, Lectura hasta 7450 MB/s, Escritura 6900 MB/s con Disipador', 820000.00, 10, 'samsung_990pro_2tb.jpg', 6, 'activo'),
(27, 'SSD NVMe M.2 Kingston FURY Renegade 1TB', 'PCIe Gen 4.0x4, Velocidad de lectura 7300 MB/s, ideal para PC y PS5', 410000.00, 16, 'kingston_renegade_1tb.jpg', 6, 'activo'),
(28, 'Disco Duro Externo WD My Passport 4TB', 'USB 3.2 Gen 1, Cifrado por Hardware AES de 256 bits, Factor de Forma 2.5', 480000.00, 14, 'wd_mypassport_4tb.jpg', 6, 'activo'),
(29, 'SSD Portátil SanDisk Extreme 1TB', 'Inalámbrico/USB-C, Lectura 1050 MB/s, Protección contra caídas e IP65', 520000.00, 8, 'sandisk_extreme_1tb.jpg', 6, 'activo'),
(30, 'SSD SATA III Crucial BX500 480GB', 'Factor de Forma 2.5 Pulgadas, Lectura 540 MB/s, Mejora de Arranque de Sistema', 160000.00, 25, 'prod_1791744030_8705.jpg', 6, 'activo'),
(31, 'Router Gaming TP-Link Archer AXE75', 'Wi-Fi 6E Tribanda AX5400, Procesador Quad-Core 1.7GHz, Puerto USB 3.0', 780000.00, 6, 'tplink_archer_ax75.jpg', 7, 'activo'),
(32, 'Sistema Wi-Fi Mesh Mercusys Halo H80X (Pack x3)', 'Wi-Fi 6 Doble Banda AX3000, Cobertura hasta 650m², Conexión hasta 150 dispositivos', 650000.00, 8, 'mercusys_halo_h80x.jpg', 7, 'activo'),
(33, 'Switch Gigabit D-Link de 16 Puertos', 'Carcasa Metálica de Escritorio o Montaje en Rack, Plug and Play, Ahorro de Energía', 280000.00, 11, 'dlink_switch_16p.jpg', 7, 'activo'),
(34, 'Adaptador Wi-Fi USB TP-Link Archer TX20U Plus', 'Wi-Fi 6 Inalámbrico Dual Band AX1800, Antenas de Alta Ganancia USB 3.0', 140000.00, 18, 'tplink_tx20u_plus.jpg', 7, 'activo'),
(35, 'Router ASUS RT-AX82U AX5400', 'Wi-Fi 6 Dual-Band, Modo de Juego Móvil, AURA RGB, Soporte AiMesh', 890000.00, 4, 'prod_1791743891_8223.jpg', 7, 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Cliente'),
(3, 'Gestor de Productos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL DEFAULT 2,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `pin_recuperacion` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`, `telefono`, `direccion`, `fecha_registro`, `pin_recuperacion`) VALUES
(1, 'Administrador Principal', 'admin@mundotecnologico.com', 'Admin2026!', 1, '+57 300 111 2233', 'Calle 100 # 15-20, Bogotá D.C.', '2026-10-11 03:16:48', '6162'),
(2, 'Carlos Gestor de Inventario', 'gestor@mundotecnologico.com', 'Gestor2026!', 3, '+57 310 222 3344', 'Av. Carrera 45 # 108-10, Bogotá D.C.', '2026-10-11 03:16:48', NULL),
(4, 'Juan Pérez', 'juan.perez@mundotecnologico.com', '$2y$10$IbuwL/NcOzCUxPluJ0OzAuD7ph/XT6Hpmiaaz9OvU2j1HZWrE8IPm', 2, '34343435444', '', '2026-10-11 03:18:35', NULL),
(5, 'Ana Torres M', 'anat23@gmail.com', 'anat23!', 2, '34343435444', 'Calle 2 # 12A - 76', '2026-10-11 18:18:18', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD CONSTRAINT `detalle_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE SET NULL;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE SET NULL;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE CASCADE;
--
-- Base de datos: `mundo_tecnologico_larav`
--
CREATE DATABASE IF NOT EXISTS `mundo_tecnologico_larav` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mundo_tecnologico_larav`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT 'default_cat.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`, `descripcion`, `imagen`) VALUES
(1, 'Laptops y Portátiles', 'Equipos portátiles de alto rendimiento para trabajo, estudio y gaming.', 'cat_1791730335.jpg'),
(2, 'Componentes de PC', 'Tarjetas gráficas, procesadores, memorias RAM y placas base.', 'componentes.jpg'),
(3, 'Smartphones y Tablets', 'Dispositivos móviles de última generación, celulares gama alta y tablets.', 'cat_1791730634.jpg'),
(4, 'Monitores y Pantallas', 'Monitores gamer, pantallas 4K y monitores profesionales ultra-wide.', 'cat_1791730376.jpg'),
(5, 'Periféricos', 'Teclados mecánicos, ratones ergonómicos, diademas y micrófonos.', 'perifericos.jpg'),
(6, 'Almacenamiento', 'Unidades de estado sólido SSD NVMe y discos duros externos.', 'cat_1791740753.jpg'),
(7, 'Redes y Conectividad', 'Routers Wi-Fi 6, switches gigabit, repetidores y adaptadores de red.', 'redes.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT current_timestamp(),
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `iva` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `metodo_pago` varchar(50) DEFAULT 'Tarjeta Visa (Pasarela V6)',
  `referencia_pago` varchar(100) DEFAULT NULL,
  `estado` enum('Pendiente','Procesando','Enviado','Completado','Cancelado') DEFAULT 'Completado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `id_usuario`, `fecha_compra`, `subtotal`, `iva`, `total`, `metodo_pago`, `referencia_pago`, `estado`) VALUES
(2, 4, '2026-10-11 03:19:07', 2600000.00, 494000.00, 3094000.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACB002B1910C', 'Completado'),
(3, 4, '2026-10-11 03:19:32', 650000.00, 123500.00, 773500.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACB0044C6662', 'Completado'),
(4, 4, '2026-10-11 18:10:19', 6680000.00, 1269200.00, 7949200.00, 'Tarjeta de Crédito Visa', 'PAY-MUNDO-6ACBD10B39F6F', 'Completado'),
(5, 5, '2026-10-11 19:19:45', 490000.00, 93100.00, 583100.00, 'Tarjeta de Crédito Visa', 'PAY-MUNDO-6ACBE15116C2D', 'Completado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `valor` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `clave`, `valor`) VALUES
(1, 'nombre_tienda', 'Mundo Tecnológico S.A.S'),
(2, 'logo_url', 'assets/img/logo_1791688901.png'),
(3, 'acerca_titulo', 'Sobre Mundo Tecnológico S.A.S'),
(4, 'acerca_historia', 'Fundada en 2019 en la ciudad de Bogotá, Mundo Tecnológico V7 nació con la firme visión de acercar la innovación, el hardware de última generación y los componentes de alta gama a todo el mercado colombiano. A lo largo de los años nos hemos consolidado como líderes en distribución tecnológica, garantizando siempre respaldo, garantía, confianza absoluta y un servicio excepcional para cada uno de nuestros clientes y empresas aliadas.'),
(5, 'acerca_direccion', 'Calle 100 # 15-20, Oficina 402, Bogotá D.C., Colombia'),
(6, 'acerca_telefono', '+57 (1) 790 5500 / +57 310 400 5000'),
(7, 'acerca_email', 'mundotecnologico@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compras`
--

CREATE TABLE `detalle_compras` (
  `id_detalle` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `valor_iva` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_compras`
--

INSERT INTO `detalle_compras` (`id_detalle`, `id_compra`, `id_producto`, `cantidad`, `precio_unitario`, `valor_iva`, `subtotal`) VALUES
(1, 2, 4, 1, 2600000.00, 494000.00, 3094000.00),
(2, 3, 9, 1, 650000.00, 123500.00, 773500.00),
(3, 4, 5, 1, 6400000.00, 1216000.00, 7616000.00),
(4, 4, 33, 1, 280000.00, 53200.00, 333200.00),
(5, 5, 23, 1, 490000.00, 93100.00, 583100.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 10,
  `imagen` varchar(255) DEFAULT 'default_prod.jpg',
  `id_categoria` int(11) DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`, `id_categoria`, `estado`) VALUES
(1, 'Laptop Gamer ASUS ROG Strix G16', 'Intel Core i7 13700HX, 16GB RAM DDR5, 512GB SSD NVMe, NVIDIA RTX 4060 8GB', 5200000.00, 4, 'laptop_asus_rog.jpg', 1, 'activo'),
(2, 'MacBook Air M2 13.6 Pulgadas', 'Chip Apple M2 de 8 núcleos, 8GB memoria unificada, SSD 256GB, Pantalla Liquid Retina', 4800000.00, 8, 'macbook_air_m2.jpg', 1, 'activo'),
(3, 'Laptop Lenovo Legion 5 Pro', 'AMD Ryzen 7 7745HX, 16GB RAM, SSD 1TB, NVIDIA RTX 4070 8GB, Pantalla 165Hz', 5900000.00, 3, 'lenovo_legion5.jpg', 1, 'activo'),
(4, 'Laptop HP Pavilion X360 Convertible', 'Intel Core i5 1235U, 8GB RAM, SSD 512GB, Pantalla Táctil 14 FHD', 2600000.00, 11, 'hp_pavilion_x360.jpg', 1, 'activo'),
(5, 'Laptop Dell XPS 13 Plus', 'Intel Core i7 1360P, 16GB RAM, SSD 1TB NVMe, Pantalla OLED 3.5K Táctil', 6400000.00, 1, 'prod_1791730576.jpg', 1, 'activo'),
(6, 'Tarjeta Gráfica NVIDIA RTX 4070 Ti Super', '16GB GDDR6X, DLSS 3.5, Ray Tracing de 3ra Generación, Arquitectura Ada Lovelace', 3900000.00, 3, 'rtx4070_ti.jpg', 2, 'activo'),
(7, 'Procesador AMD Ryzen 7 7800X3D', '8 núcleos, 16 hilos, 4.2GHz base, 104MB Cache con tecnología 3D V-Cache', 1850000.00, 10, 'ryzen_7800x3d.jpg', 2, 'activo'),
(8, 'Procesador Intel Core i9 14900K', '24 núcleos (8P + 16E), 32 hilos, hasta 6.0 GHz, Socket LGA1700', 2550000.00, 5, 'intel_i9_14900k.jpg', 2, 'activo'),
(9, 'Memoria RAM Corsair Vengeance DDR5 32GB', 'Kit 2x16GB 6000MHz CL30, optimizado para perfiles AMD EXPO e Intel XMP 3.0', 650000.00, 14, 'ram_corsair_32gb.jpg', 2, 'activo'),
(10, 'Placa Base ASUS ROG Strix Z790-F WiFi', 'Socket LGA1700, DDR5, PCIe 5.0, Wi-Fi 6E, Factor de forma ATX', 1450000.00, 6, 'prod_1791744330_7859.jpg', 2, 'activo'),
(11, 'Samsung Galaxy S24 Ultra', 'Pantalla Dynamic AMOLED 2X 6.8, 12GB RAM, 512GB, Cámara 200MP, S-Pen', 5100000.00, 7, 'samsung_s24_ultra.jpg', 3, 'activo'),
(12, 'iPhone 15 Pro Max 256GB', 'Titanio Natural, Chip A17 Pro, Pantalla Super Retina XDR 6.7, Cámara 48MP', 5600000.00, 5, 'iphone_15_promax.jpg', 3, 'activo'),
(13, 'Xiaomi 14 Ultra 5G', 'Procesador Snapdragon 8 Gen 3, 16GB RAM, 512GB, Óptica Leica Quad Camera', 4300000.00, 6, 'xiaomi_14_ultra.jpg', 3, 'activo'),
(14, 'Tablet Apple iPad Air M2 11 Pulgadas', 'Chip M2, 128GB Wi-Fi, Pantalla Liquid Retina, compatible con Apple Pencil Pro', 2900000.00, 9, 'ipad_air_m2.jpg', 3, 'activo'),
(15, 'Tablet Samsung Galaxy Tab S9 FE', 'Pantalla 10.9 90Hz, 6GB RAM, 128GB, incluye S-Pen, Resistencia IP68', 1750000.00, 11, 'prod_1791744259_7413.jpg', 3, 'activo'),
(16, 'Monitor Gamer Samsung Odyssey G7 27', 'Curvo 1000R, QHD (2560x1440), 240Hz, 1ms, HDR600, G-Sync Compatible', 2100000.00, 3, 'samsung_odyssey_g7.jpg', 4, 'activo'),
(17, 'Monitor LG UltraGear 24 144Hz', 'Pantalla IPS Full HD, 1ms MBR, AMD FreeSync Premium, Ajuste de Inclinación', 680000.00, 14, 'lg_ultragear_24.jpg', 4, 'activo'),
(18, 'Monitor Profesional ASUS ProArt 27 4K', 'Resolución 3840x2160 IPS, 100% sRGB, Calibración de fábrica Calman Verified', 1950000.00, 4, 'asus_proart_27.jpg', 4, 'activo'),
(19, 'Monitor Gamer Alienware 34 Curved OLED', 'UWQHD (3440x1440), 175Hz, 0.1ms, Quantum Dot OLED, VESA DisplayHDR True Black', 4600000.00, 2, 'alienware_34_oled.jpg', 4, 'activo'),
(20, 'Monitor Xiaomi Gaming Monitor G27i', '27 Pulgadas IPS, Full HD, 165Hz, 1ms, FreeSync, Bisel Delgado', 590000.00, 18, 'prod_1791744180_1297.jpg', 4, 'activo'),
(21, 'Teclado Mecánico Logitech G PRO X TKL', 'Switches Tactile, Conectividad LIGHTSPEED inalámbrica, Iluminación RGB LIGHTSYNC', 720000.00, 10, 'logitech_gpro_tkl.jpg', 5, 'activo'),
(22, 'Mouse Gamer Razer DeathAdder V3 Pro', 'Inalámbrico, Sensor Óptico Focus Pro 30K DPI, 63 gramos de peso ultra ligero', 580000.00, 12, 'razer_deathadder_v3.jpg', 5, 'activo'),
(23, 'Diadema HyperX Cloud III Inalámbrica', 'Audio Espacial DTS Headphone:X 3D, Autonomía de hasta 120 horas, Micrófono 10mm', 490000.00, 14, 'hyperx_cloud_3.jpg', 5, 'activo'),
(24, 'Micrófono Condensador Shure MV7 USB/XLR', 'Diseñado para Podcast y Streaming, Panel Táctil de Control, Salida de Auriculares', 1150000.00, 5, 'shure_mv7.jpg', 5, 'activo'),
(25, 'Mouse Ergonomico Logitech MX Master 3S', 'Sensor 8000 DPI, Desplazamiento MagSpeed silencioso, Conexión Multidispositivo', 420000.00, 20, 'prod_1791744107_8068.jpg', 5, 'activo'),
(26, 'SSD NVMe M.2 Samsung 990 PRO 2TB', 'PCIe Gen 4.0x4, Lectura hasta 7450 MB/s, Escritura 6900 MB/s con Disipador', 820000.00, 10, 'samsung_990pro_2tb.jpg', 6, 'activo'),
(27, 'SSD NVMe M.2 Kingston FURY Renegade 1TB', 'PCIe Gen 4.0x4, Velocidad de lectura 7300 MB/s, ideal para PC y PS5', 410000.00, 16, 'kingston_renegade_1tb.jpg', 6, 'activo'),
(28, 'Disco Duro Externo WD My Passport 4TB', 'USB 3.2 Gen 1, Cifrado por Hardware AES de 256 bits, Factor de Forma 2.5', 480000.00, 14, 'wd_mypassport_4tb.jpg', 6, 'activo'),
(29, 'SSD Portátil SanDisk Extreme 1TB', 'Inalámbrico/USB-C, Lectura 1050 MB/s, Protección contra caídas e IP65', 520000.00, 8, 'prod_1792456357_1605.jpg', 6, 'activo'),
(30, 'SSD SATA III Crucial BX500 480GB', 'Factor de Forma 2.5 Pulgadas, Lectura 540 MB/s, Mejora de Arranque de Sistema', 160000.00, 25, 'prod_1791744030_8705.jpg', 6, 'activo'),
(31, 'Router Gaming TP-Link Archer AXE75', 'Wi-Fi 6E Tribanda AX5400, Procesador Quad-Core 1.7GHz, Puerto USB 3.0', 780000.00, 6, 'tplink_archer_ax75.jpg', 7, 'activo'),
(32, 'Sistema Wi-Fi Mesh Mercusys Halo H80X (Pack x3)', 'Wi-Fi 6 Doble Banda AX3000, Cobertura hasta 650m², Conexión hasta 150 dispositivos', 650000.00, 8, 'mercusys_halo_h80x.jpg', 7, 'activo'),
(33, 'Switch Gigabit D-Link de 16 Puertos', 'Carcasa Metálica de Escritorio o Montaje en Rack, Plug and Play, Ahorro de Energía', 280000.00, 11, 'dlink_switch_16p.jpg', 7, 'activo'),
(34, 'Adaptador Wi-Fi USB TP-Link Archer TX20U Plus', 'Wi-Fi 6 Inalámbrico Dual Band AX1800, Antenas de Alta Ganancia USB 3.0', 140000.00, 18, 'tplink_tx20u_plus.jpg', 7, 'activo'),
(35, 'Router ASUS RT-AX82U AX5400', 'Wi-Fi 6 Dual-Band, Modo de Juego Móvil, AURA RGB, Soporte AiMesh', 890000.00, 4, 'prod_1791743891_8223.jpg', 7, 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Cliente'),
(3, 'Gestor de Productos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('igCuqQuKlS09fgXk8XsOQL6XiA15KkSLRxHm0mTF', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRFhrdERnVDBrOUVNQnNqUWZRR28za3JtMDhQaUJKeGREOEJ6TEdLaiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1794583317),
('LhGweJXu3Mo2YZnixNNl0yMQnK7N3ZQumeT1A5lF', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:160.0) Gecko/20100101 Firefox/160.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieGx6c0o4NmtwaTBRa3Uyd3RIdXFIZjU2c2t5bzg2ODFKdGxqTlhKdiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1794583329),
('rOtskliDjldV4TBY8IIYr4cSrcBLpyIi01am6rKR', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:160.0) Gecko/20100101 Firefox/160.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidDBsaVBPNDdvWXdtd3hraElqbjR2c0FHaVYxUVdSb3AyZ1VOeTh3YyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1794588957);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL DEFAULT 2,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `pin_recuperacion` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`, `telefono`, `direccion`, `fecha_registro`, `pin_recuperacion`) VALUES
(1, 'Administrador Principal', 'admin@mundotecnologico.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '+57 300 111 2233', 'Calle 100 # 15-20, Bogotá D.C.', '2026-10-11 03:16:48', NULL),
(2, 'Carlos Gestor de Inventario', 'gestor@mundotecnologico.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 3, '+57 310 222 3344', 'Av. Carrera 45 # 108-10, Bogotá D.C.', '2026-10-11 03:16:48', NULL),
(4, 'Juan Pérez', 'juan.perez@mundotecnologico.com', '$2y$10$IbuwL/NcOzCUxPluJ0OzAuD7ph/XT6Hpmiaaz9OvU2j1HZWrE8IPm', 2, '34343435444', '', '2026-10-11 03:18:35', NULL),
(5, 'Ana Torres M', 'anat23@gmail.com', '$2y$10$N7w1SnDMiKdIxA/g8bNyneQHqHWWS66yHHIa1B3Y3q.Y7wZ01Hza6', 2, '34343435444', 'Calle 2 # 12A - 76', '2026-10-11 18:18:18', NULL),
(6, 'Maria Paredes', 'maria.paredes@gmail.com', '$2y$10$joeXV51Xr7b5Qcaf/gTyAu9K5aVFYUpb36xfE5TeCcPajE2V6pEze', 2, '5656767654', 'KM 8 callejón San Juan vía Candelaria', '2026-10-19 21:52:23', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD CONSTRAINT `detalle_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE SET NULL;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE SET NULL;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE CASCADE;
--
-- Base de datos: `mundo_tecnologico_min`
--
CREATE DATABASE IF NOT EXISTS `mundo_tecnologico_min` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `mundo_tecnologico_min`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`) VALUES
(1, 'Administrador Master', 'admin@tienda.com', '123456', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Base de datos: `mundo_tecnologico_minc`
--
CREATE DATABASE IF NOT EXISTS `mundo_tecnologico_minc` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `mundo_tecnologico_minc`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`) VALUES
(1, 'Administrador Master', 'admin@tienda.com', '123456', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Base de datos: `mundo_tecnologico_v3`
--
CREATE DATABASE IF NOT EXISTS `mundo_tecnologico_v3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mundo_tecnologico_v3`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `created_at`) VALUES
(1, 'Laptops y Portátiles', 'Equipos portátiles de alto rendimiento para trabajo, estudio y gaming', '2026-10-04 23:15:35'),
(2, 'Smartphones', 'Teléfonos inteligentes con tecnología de última generación', '2026-10-04 23:15:35'),
(3, 'Accesorios', 'Periféricos y complementos para tu setup y oficina', '2026-10-04 23:15:35'),
(4, 'Componentes de PC', 'Hardware interno para ensamblar o actualizar tu computadora', '2026-10-04 23:15:35'),
(5, 'Monitores y Pantallas', 'Monitores de alta definición, alta tasa de refresco y trabajo profesional', '2026-10-04 23:15:35'),
(6, 'Audio y Sonido', 'Audífonos, parlantes y micrófonos de alta fidelidad', '2026-10-04 23:15:35'),
(7, 'Consolas y Videojuegos', 'Sistemas de entretenimiento, consolas y controles', '2026-10-04 23:15:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(255) DEFAULT 'default.jpg',
  `stock` int(11) NOT NULL DEFAULT 10,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `categoria_id`, `nombre`, `descripcion`, `precio`, `imagen`, `stock`, `created_at`) VALUES
(1, 1, 'Laptop Asus ROG Strix G16', 'Intel Core i7-13650HX, 16GB RAM, 512GB SSD, RTX 4060 8GB', 4500000.00, 'laptop_asus_rog.jpg', 12, '2026-10-04 23:15:35'),
(2, 1, 'MacBook Air M2', 'Apple M2, 8GB RAM, 256GB SSD, Pantalla Liquid Retina 13.6\"', 5200000.00, 'macbook_air_m2.jpg', 8, '2026-10-04 23:15:35'),
(3, 1, 'Lenovo IdeaPad Slim 3', 'AMD Ryzen 5 7520U, 8GB RAM, 512GB SSD, 15.6\" FHD', 2100000.00, 'lenovo_ideapad.jpg', 20, '2026-10-04 23:15:35'),
(4, 1, 'HP Pavilion 15', 'Intel Core i5-1235U, 16GB RAM, 512GB SSD, Pantalla Táctil', 2800000.00, 'hp_pavilion_15.jpg', 15, '2026-10-04 23:15:35'),
(5, 1, 'Dell XPS 13 Plus', 'Intel Core i7-1360P, 16GB RAM, 1TB SSD, OLED 3.5K', 6300000.00, 'dell_xps_13.jpg', 5, '2026-10-04 23:15:35'),
(6, 2, 'iPhone 15 Pro', 'Pantalla Super Retina XDR 6.1\", Chip A17 Pro, 128GB', 4800000.00, 'iphone_15_pro.jpg', 10, '2026-10-04 23:15:35'),
(7, 2, 'Samsung Galaxy S24 Ultra', 'Pantalla Dynamic AMOLED 2X 6.8\", Snapdragon 8 Gen 3, 256GB', 5100000.00, 'samsung_s24_ultra.jpg', 7, '2026-10-04 23:15:35'),
(8, 2, 'Xiaomi 13T Pro', 'Procesador Dimensity 9200+, Cámara Leica, 12GB RAM, 512GB', 2400000.00, 'xiaomi_13t_pro.jpg', 18, '2026-10-04 23:15:35'),
(9, 2, 'Motorola Edge 40 Neo', 'Pantalla pOLED 144Hz, 256GB Storage, Carga Rápida 68W', 1600000.00, 'motorola_edge_40.jpg', 25, '2026-10-04 23:15:35'),
(10, 2, 'Google Pixel 8', 'Procesador Google Tensor G3, Cámara de 50MP, 128GB', 3200000.00, 'google_pixel_8.jpg', 9, '2026-10-04 23:15:35'),
(11, 3, 'Mouse Inalámbrico Logitech MX Master 3S', 'Sensor 8000 DPI, Clicks Silenciosos, Scroll MagSpeed', 420000.00, 'mouse_logitech_mx.jpg', 30, '2026-10-04 23:15:35'),
(12, 3, 'Teclado Mecánico Redragon Kumara K552', 'Switches Red, Retroiluminación RGB, Formato TKL 80%', 180000.00, 'teclado_redragon.jpg', 40, '2026-10-04 23:15:35'),
(13, 3, 'Soporte de Aluminio Regulable', 'Diseño ergonómico plegable para laptops de 10\" a 17\"', 85000.00, 'soporte_laptop.jpg', 50, '2026-10-04 23:15:35'),
(14, 3, 'Hub USB-C 7 en 1 Anker PowerExpand', 'HDMI 4K, SD/TF, 2x USB 3.0, Carga PD 100W', 160000.00, 'hub_anker.jpg', 22, '2026-10-04 23:15:35'),
(15, 3, 'Webcam Logitech C920 HD Pro', 'Resolución Full HD 1080p a 30fps, Micrófono Estéreo', 310000.00, 'webcam_c920.jpg', 14, '2026-10-04 23:15:35'),
(16, 4, 'NVIDIA GeForce RTX 4070 Ventus 3X', '12GB GDDR6X, PCIe 4.0, DLSS 3, Ray Tracing', 3100000.00, 'rtx_4070.jpg', 6, '2026-10-04 23:15:35'),
(17, 4, 'Procesador AMD Ryzen 7 7800X3D', '8 Núcleos, 16 Hilos, 5.0GHz Max Boost, Socket AM5', 1950000.00, 'ryzen_7800x3d.jpg', 11, '2026-10-04 23:15:35'),
(18, 4, 'Memoria RAM Corsair Vengeance 32GB (2x16GB)', 'DDR5 6000MHz CL36 RGB, Perfil AMD EXPO / Intel XMP', 620000.00, 'ram_corsair_ddr5.jpg', 25, '2026-10-04 23:15:35'),
(19, 4, 'SSD M.2 NVMe Samsung 990 Pro 1TB', 'Lectura 7450 MB/s, Escritura 6900 MB/s, PCIe 4.0', 540000.00, 'ssd_samsung_990.jpg', 35, '2026-10-04 23:15:35'),
(20, 4, 'Fuente de Poder ASUS ROG Strix 850W', 'Certificación 80 Plus Gold, Totalmente Modular', 720000.00, 'fuente_asus_850w.jpg', 10, '2026-10-04 23:15:35'),
(21, 5, 'Monitor Gamer LG UltraGear 27GN650', '27\" IPS Full HD, 144Hz, 1ms, FreeSync / G-Sync Compatible', 950000.00, 'monitor_lg_27.jpg', 12, '2026-10-04 23:15:35'),
(22, 5, 'Monitor Curvo Samsung Odyssey G5 32\"', '32\" QHD (2560x1440), 165Hz, Curvatura 1000R, 1ms', 1650000.00, 'monitor_samsung_g5.jpg', 8, '2026-10-04 23:15:35'),
(23, 5, 'Monitor ASUS TUF Gaming VG249Q1A', '23.8\" IPS Full HD, 165Hz, 1ms, Altavoces Integrados', 780000.00, 'monitor_asus_tuf.jpg', 16, '2026-10-04 23:15:35'),
(24, 5, 'Monitor Dell UltraSharp U2723QE', '27\" 4K UHD, Panel IPS Black, Hub USB-C 90W PD', 2200000.00, 'monitor_dell_4k.jpg', 4, '2026-10-04 23:15:35'),
(25, 5, 'Monitor MSI Optix G271CQR', '27\" Curvo WQHD, 170Hz, 1ms, HDR Ready', 1100000.00, 'monitor_msi_optix.jpg', 9, '2026-10-04 23:15:35'),
(26, 6, 'Audífonos Sony WH-1000XM5', 'Cancelación de Ruido Inteligente, Bluetooth 5.2, 30h Batería', 1450000.00, 'audifonos_sony_xm5.jpg', 10, '2026-10-04 23:15:35'),
(27, 6, 'Audífonos Gamer HyperX Cloud II Wireless', 'Sonido Envolvente 7.1 Virtual, Micrófono Desmontable', 320000.00, 'hyperx_cloud_ii.jpg', 18, '2026-10-04 23:15:35'),
(28, 6, 'Parlante Bluetooth JBL Charge 5', 'Potencia 40W, Resistente al Agua y Polvo IP67, Batería 20h', 680000.00, 'jbl_charge_5.jpg', 15, '2026-10-04 23:15:35'),
(29, 6, 'Micrófono USB HyperX QuadCast S', 'Patrones Polares Seleccionables, Iluminación RGB, Filtro Pop', 590000.00, 'mic_hyperx_quadcast.jpg', 12, '2026-10-04 23:15:35'),
(30, 6, 'Barra de Sonido Bose Solo Soundbar Series II', 'Modo Diálogo Aumentado, Conexión Óptica y Bluetooth', 980000.00, 'bose_solo_soundbar.jpg', 7, '2026-10-04 23:15:35'),
(31, 7, 'Consola PlayStation 5 Standard', 'Edición con Lector de Discos, SSD 825GB, Incluye Control DualSense', 2700000.00, 'ps5_console.jpg', 6, '2026-10-04 23:15:35'),
(32, 7, 'Consola Xbox Series X', '1TB SSD NVMe Custom, Arquitectura Velocity, 4K Real a 120fps', 2600000.00, 'xbox_series_x.jpg', 8, '2026-10-04 23:15:35'),
(33, 7, 'Nintendo Switch OLED Model', 'Pantalla OLED 7\", 64GB Memoria Interna, Dock con Puerto LAN', 1550000.00, 'nintendo_switch_oled.jpg', 14, '2026-10-04 23:15:35'),
(34, 7, 'Control Inalámbrico DualSense PS5', 'Retroalimentación Háptica, Gatillos Adaptativos, Color Blanco', 310000.00, 'dualsense_ps5.jpg', 22, '2026-10-04 23:15:35'),
(35, 7, 'Control Inalámbrico Xbox Wireless', 'Diseño Ergonómico, Textura Envolvente, Color Carbon Black', 280000.00, 'xbox_controller.jpg', 20, '2026-10-04 23:15:35');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_productos_categorias` (`categoria_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_productos_categorias` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Base de datos: `mundo_tecnologico_v6`
--
CREATE DATABASE IF NOT EXISTS `mundo_tecnologico_v6` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mundo_tecnologico_v6`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT 'default_cat.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`, `descripcion`, `imagen`) VALUES
(1, 'Laptops y Portátiles', 'Equipos portátiles de alto rendimiento para trabajo, estudio y gaming.', 'cat_1791730335.jpg'),
(2, 'Componentes de PC', 'Tarjetas gráficas, procesadores, memorias RAM y placas base.', 'componentes.jpg'),
(3, 'Smartphones y Tablets', 'Dispositivos móviles de última generación, celulares gama alta y tablets.', 'cat_1791730634.jpg'),
(4, 'Monitores y Pantallas', 'Monitores gamer, pantallas 4K y monitores profesionales ultra-wide.', 'cat_1791730376.jpg'),
(5, 'Periféricos', 'Teclados mecánicos, ratones ergonómicos, diademas y micrófonos.', 'perifericos.jpg'),
(6, 'Almacenamiento', 'Unidades de estado sólido SSD NVMe y discos duros externos.', 'cat_1791740753.jpg'),
(7, 'Redes y Conectividad', 'Routers Wi-Fi 6, switches gigabit, repetidores y adaptadores de red.', 'redes.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT current_timestamp(),
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `iva` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `metodo_pago` varchar(50) DEFAULT 'Tarjeta Visa (Pasarela V6)',
  `referencia_pago` varchar(100) DEFAULT NULL,
  `estado` enum('Pendiente','Procesando','Enviado','Completado','Cancelado') DEFAULT 'Completado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `id_usuario`, `fecha_compra`, `subtotal`, `iva`, `total`, `metodo_pago`, `referencia_pago`, `estado`) VALUES
(2, 4, '2026-10-11 03:19:07', 2600000.00, 494000.00, 3094000.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACB002B1910C', 'Completado'),
(3, 4, '2026-10-11 03:19:32', 650000.00, 123500.00, 773500.00, 'Tarjeta Visa (Pasarela V5)', 'PAY-COL-6ACB0044C6662', 'Completado'),
(4, 4, '2026-10-11 18:10:19', 6680000.00, 1269200.00, 7949200.00, 'Tarjeta de Crédito Visa', 'PAY-MUNDO-6ACBD10B39F6F', 'Completado'),
(5, 5, '2026-10-11 19:19:45', 490000.00, 93100.00, 583100.00, 'Tarjeta de Crédito Visa', 'PAY-MUNDO-6ACBE15116C2D', 'Completado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `valor` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `clave`, `valor`) VALUES
(1, 'nombre_tienda', 'Mundo Tecnológico S.A.S'),
(2, 'logo_url', 'assets/img/logo_1791688901.png'),
(3, 'acerca_titulo', 'Sobre Mundo Tecnológico S.A.S'),
(4, 'acerca_historia', 'Fundada en 2019 en la ciudad de Bogotá, Mundo Tecnológico V7 nació con la firme visión de acercar la innovación, el hardware de última generación y los componentes de alta gama a todo el mercado colombiano. A lo largo de los años nos hemos consolidado como líderes en distribución tecnológica, garantizando siempre respaldo, garantía, confianza absoluta y un servicio excepcional para cada uno de nuestros clientes y empresas aliadas.'),
(5, 'acerca_direccion', 'Calle 100 # 15-20, Oficina 402, Bogotá D.C., Colombia'),
(6, 'acerca_telefono', '+57 (1) 790 5500 / +57 310 400 5000'),
(7, 'acerca_email', 'mundotecnologico@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compras`
--

CREATE TABLE `detalle_compras` (
  `id_detalle` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `valor_iva` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_compras`
--

INSERT INTO `detalle_compras` (`id_detalle`, `id_compra`, `id_producto`, `cantidad`, `precio_unitario`, `valor_iva`, `subtotal`) VALUES
(1, 2, 4, 1, 2600000.00, 494000.00, 3094000.00),
(2, 3, 9, 1, 650000.00, 123500.00, 773500.00),
(3, 4, 5, 1, 6400000.00, 1216000.00, 7616000.00),
(4, 4, 33, 1, 280000.00, 53200.00, 333200.00),
(5, 5, 23, 1, 490000.00, 93100.00, 583100.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 10,
  `imagen` varchar(255) DEFAULT 'default_prod.jpg',
  `id_categoria` int(11) DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`, `id_categoria`, `estado`) VALUES
(1, 'Laptop Gamer ASUS ROG Strix G16', 'Intel Core i7 13700HX, 16GB RAM DDR5, 512GB SSD NVMe, NVIDIA RTX 4060 8GB', 5200000.00, 4, 'laptop_asus_rog.jpg', 1, 'activo'),
(2, 'MacBook Air M2 13.6 Pulgadas', 'Chip Apple M2 de 8 núcleos, 8GB memoria unificada, SSD 256GB, Pantalla Liquid Retina', 4800000.00, 8, 'macbook_air_m2.jpg', 1, 'activo'),
(3, 'Laptop Lenovo Legion 5 Pro', 'AMD Ryzen 7 7745HX, 16GB RAM, SSD 1TB, NVIDIA RTX 4070 8GB, Pantalla 165Hz', 5900000.00, 3, 'lenovo_legion5.jpg', 1, 'activo'),
(4, 'Laptop HP Pavilion X360 Convertible', 'Intel Core i5 1235U, 8GB RAM, SSD 512GB, Pantalla Táctil 14 FHD', 2600000.00, 11, 'hp_pavilion_x360.jpg', 1, 'activo'),
(5, 'Laptop Dell XPS 13 Plus', 'Intel Core i7 1360P, 16GB RAM, SSD 1TB NVMe, Pantalla OLED 3.5K Táctil', 6400000.00, 1, 'prod_1791730576.jpg', 1, 'activo'),
(6, 'Tarjeta Gráfica NVIDIA RTX 4070 Ti Super', '16GB GDDR6X, DLSS 3.5, Ray Tracing de 3ra Generación, Arquitectura Ada Lovelace', 3900000.00, 3, 'rtx4070_ti.jpg', 2, 'activo'),
(7, 'Procesador AMD Ryzen 7 7800X3D', '8 núcleos, 16 hilos, 4.2GHz base, 104MB Cache con tecnología 3D V-Cache', 1850000.00, 10, 'ryzen_7800x3d.jpg', 2, 'activo'),
(8, 'Procesador Intel Core i9 14900K', '24 núcleos (8P + 16E), 32 hilos, hasta 6.0 GHz, Socket LGA1700', 2550000.00, 5, 'intel_i9_14900k.jpg', 2, 'activo'),
(9, 'Memoria RAM Corsair Vengeance DDR5 32GB', 'Kit 2x16GB 6000MHz CL30, optimizado para perfiles AMD EXPO e Intel XMP 3.0', 650000.00, 14, 'ram_corsair_32gb.jpg', 2, 'activo'),
(10, 'Placa Base ASUS ROG Strix Z790-F WiFi', 'Socket LGA1700, DDR5, PCIe 5.0, Wi-Fi 6E, Factor de forma ATX', 1450000.00, 6, 'prod_1791744330_7859.jpg', 2, 'activo'),
(11, 'Samsung Galaxy S24 Ultra', 'Pantalla Dynamic AMOLED 2X 6.8, 12GB RAM, 512GB, Cámara 200MP, S-Pen', 5100000.00, 7, 'samsung_s24_ultra.jpg', 3, 'activo'),
(12, 'iPhone 15 Pro Max 256GB', 'Titanio Natural, Chip A17 Pro, Pantalla Super Retina XDR 6.7, Cámara 48MP', 5600000.00, 5, 'iphone_15_promax.jpg', 3, 'activo'),
(13, 'Xiaomi 14 Ultra 5G', 'Procesador Snapdragon 8 Gen 3, 16GB RAM, 512GB, Óptica Leica Quad Camera', 4300000.00, 6, 'xiaomi_14_ultra.jpg', 3, 'activo'),
(14, 'Tablet Apple iPad Air M2 11 Pulgadas', 'Chip M2, 128GB Wi-Fi, Pantalla Liquid Retina, compatible con Apple Pencil Pro', 2900000.00, 9, 'ipad_air_m2.jpg', 3, 'activo'),
(15, 'Tablet Samsung Galaxy Tab S9 FE', 'Pantalla 10.9 90Hz, 6GB RAM, 128GB, incluye S-Pen, Resistencia IP68', 1750000.00, 11, 'prod_1791744259_7413.jpg', 3, 'activo'),
(16, 'Monitor Gamer Samsung Odyssey G7 27', 'Curvo 1000R, QHD (2560x1440), 240Hz, 1ms, HDR600, G-Sync Compatible', 2100000.00, 3, 'samsung_odyssey_g7.jpg', 4, 'activo'),
(17, 'Monitor LG UltraGear 24 144Hz', 'Pantalla IPS Full HD, 1ms MBR, AMD FreeSync Premium, Ajuste de Inclinación', 680000.00, 14, 'lg_ultragear_24.jpg', 4, 'activo'),
(18, 'Monitor Profesional ASUS ProArt 27 4K', 'Resolución 3840x2160 IPS, 100% sRGB, Calibración de fábrica Calman Verified', 1950000.00, 4, 'asus_proart_27.jpg', 4, 'activo'),
(19, 'Monitor Gamer Alienware 34 Curved OLED', 'UWQHD (3440x1440), 175Hz, 0.1ms, Quantum Dot OLED, VESA DisplayHDR True Black', 4600000.00, 2, 'alienware_34_oled.jpg', 4, 'activo'),
(20, 'Monitor Xiaomi Gaming Monitor G27i', '27 Pulgadas IPS, Full HD, 165Hz, 1ms, FreeSync, Bisel Delgado', 590000.00, 18, 'prod_1791744180_1297.jpg', 4, 'activo'),
(21, 'Teclado Mecánico Logitech G PRO X TKL', 'Switches Tactile, Conectividad LIGHTSPEED inalámbrica, Iluminación RGB LIGHTSYNC', 720000.00, 10, 'logitech_gpro_tkl.jpg', 5, 'activo'),
(22, 'Mouse Gamer Razer DeathAdder V3 Pro', 'Inalámbrico, Sensor Óptico Focus Pro 30K DPI, 63 gramos de peso ultra ligero', 580000.00, 12, 'razer_deathadder_v3.jpg', 5, 'activo'),
(23, 'Diadema HyperX Cloud III Inalámbrica', 'Audio Espacial DTS Headphone:X 3D, Autonomía de hasta 120 horas, Micrófono 10mm', 490000.00, 14, 'hyperx_cloud_3.jpg', 5, 'activo'),
(24, 'Micrófono Condensador Shure MV7 USB/XLR', 'Diseñado para Podcast y Streaming, Panel Táctil de Control, Salida de Auriculares', 1150000.00, 5, 'shure_mv7.jpg', 5, 'activo'),
(25, 'Mouse Ergonomico Logitech MX Master 3S', 'Sensor 8000 DPI, Desplazamiento MagSpeed silencioso, Conexión Multidispositivo', 420000.00, 20, 'prod_1791744107_8068.jpg', 5, 'activo'),
(26, 'SSD NVMe M.2 Samsung 990 PRO 2TB', 'PCIe Gen 4.0x4, Lectura hasta 7450 MB/s, Escritura 6900 MB/s con Disipador', 820000.00, 10, 'samsung_990pro_2tb.jpg', 6, 'activo'),
(27, 'SSD NVMe M.2 Kingston FURY Renegade 1TB', 'PCIe Gen 4.0x4, Velocidad de lectura 7300 MB/s, ideal para PC y PS5', 410000.00, 16, 'kingston_renegade_1tb.jpg', 6, 'activo'),
(28, 'Disco Duro Externo WD My Passport 4TB', 'USB 3.2 Gen 1, Cifrado por Hardware AES de 256 bits, Factor de Forma 2.5', 480000.00, 14, 'wd_mypassport_4tb.jpg', 6, 'activo'),
(29, 'SSD Portátil SanDisk Extreme 1TB', 'Inalámbrico/USB-C, Lectura 1050 MB/s, Protección contra caídas e IP65', 520000.00, 8, 'prod_1792456357_1605.jpg', 6, 'activo'),
(30, 'SSD SATA III Crucial BX500 480GB', 'Factor de Forma 2.5 Pulgadas, Lectura 540 MB/s, Mejora de Arranque de Sistema', 160000.00, 25, 'prod_1791744030_8705.jpg', 6, 'activo'),
(31, 'Router Gaming TP-Link Archer AXE75', 'Wi-Fi 6E Tribanda AX5400, Procesador Quad-Core 1.7GHz, Puerto USB 3.0', 780000.00, 6, 'tplink_archer_ax75.jpg', 7, 'activo'),
(32, 'Sistema Wi-Fi Mesh Mercusys Halo H80X (Pack x3)', 'Wi-Fi 6 Doble Banda AX3000, Cobertura hasta 650m², Conexión hasta 150 dispositivos', 650000.00, 8, 'mercusys_halo_h80x.jpg', 7, 'activo'),
(33, 'Switch Gigabit D-Link de 16 Puertos', 'Carcasa Metálica de Escritorio o Montaje en Rack, Plug and Play, Ahorro de Energía', 280000.00, 11, 'dlink_switch_16p.jpg', 7, 'activo'),
(34, 'Adaptador Wi-Fi USB TP-Link Archer TX20U Plus', 'Wi-Fi 6 Inalámbrico Dual Band AX1800, Antenas de Alta Ganancia USB 3.0', 140000.00, 18, 'tplink_tx20u_plus.jpg', 7, 'activo'),
(35, 'Router ASUS RT-AX82U AX5400', 'Wi-Fi 6 Dual-Band, Modo de Juego Móvil, AURA RGB, Soporte AiMesh', 890000.00, 4, 'prod_1791743891_8223.jpg', 7, 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Cliente'),
(3, 'Gestor de Productos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL DEFAULT 2,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `pin_recuperacion` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`, `telefono`, `direccion`, `fecha_registro`, `pin_recuperacion`) VALUES
(1, 'Administrador Principal', 'admin@mundotecnologico.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '+57 300 111 2233', 'Calle 100 # 15-20, Bogotá D.C.', '2026-10-11 03:16:48', NULL),
(2, 'Carlos Gestor de Inventario', 'gestor@mundotecnologico.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 3, '+57 310 222 3344', 'Av. Carrera 45 # 108-10, Bogotá D.C.', '2026-10-11 03:16:48', NULL),
(4, 'Juan Pérez', 'juan.perez@mundotecnologico.com', '$2y$10$IbuwL/NcOzCUxPluJ0OzAuD7ph/XT6Hpmiaaz9OvU2j1HZWrE8IPm', 2, '34343435444', '', '2026-10-11 03:18:35', NULL),
(5, 'Ana Torres M', 'anat23@gmail.com', '$2y$10$N7w1SnDMiKdIxA/g8bNyneQHqHWWS66yHHIa1B3Y3q.Y7wZ01Hza6', 2, '34343435444', 'Calle 2 # 12A - 76', '2026-10-11 18:18:18', NULL),
(6, 'Maria Paredes', 'maria.paredes@gmail.com', '$2y$10$joeXV51Xr7b5Qcaf/gTyAu9K5aVFYUpb36xfE5TeCcPajE2V6pEze', 2, '5656767654', 'KM 8 callejón San Juan vía Candelaria', '2026-10-19 21:52:23', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD CONSTRAINT `detalle_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE SET NULL;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE SET NULL;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE CASCADE;
--
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Volcado de datos para la tabla `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"phpmyadmin\",\"table\":\"pma__central_columns\"},{\"db\":\"mysql\",\"table\":\"general_log\"},{\"db\":\"phpmyadmin\",\"table\":\"pma__history\"},{\"db\":\"phpmyadmin\",\"table\":\"pma__column_info\"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2024-11-05 23:32:08', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"es\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Base de datos: `tiendapeliculas`
--
CREATE DATABASE IF NOT EXISTS `tiendapeliculas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `tiendapeliculas`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alquileres`
--

CREATE TABLE `alquileres` (
  `id_alquiler` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_pelicula` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_alquiler` date NOT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `devuelto` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alquileres`
--

INSERT INTO `alquileres` (`id_alquiler`, `id_cliente`, `id_pelicula`, `id_usuario`, `fecha_alquiler`, `fecha_devolucion`, `devuelto`) VALUES
(1, 1, 1, 1, '2024-10-01', '2024-10-05', 1),
(2, 2, 2, 2, '2024-10-02', NULL, 0),
(3, 3, 3, 3, '2024-10-03', NULL, 0),
(4, 4, 4, 4, '2024-10-04', '2024-10-08', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre_cliente` varchar(50) NOT NULL,
  `telefono_cliente` varchar(20) DEFAULT NULL,
  `correo_cliente` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre_cliente`, `telefono_cliente`, `correo_cliente`) VALUES
(1, 'Juan Pérez', '555-1234', 'juan@example.com'),
(2, 'Ana Gómez', '555-5678', 'ana@example.com'),
(3, 'Carlos Ruiz', '555-9101', 'carlos@example.com'),
(4, 'María López', '555-1122', 'maria@example.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `peliculas`
--

CREATE TABLE `peliculas` (
  `id_pelicula` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `genero` varchar(50) NOT NULL,
  `año_lanzamiento` year(4) NOT NULL,
  `disponible` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `peliculas`
--

INSERT INTO `peliculas` (`id_pelicula`, `titulo`, `genero`, `año_lanzamiento`, `disponible`) VALUES
(1, 'Inception', 'Ciencia Ficción', '2010', 1),
(2, 'Matrix', 'Acción', '1999', 1),
(3, 'El Señor de los Anillos', 'Fantasía', '2001', 1),
(4, 'Titanic', 'Romance', '1997', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_rol`) VALUES
(1, 'Administrador'),
(2, 'Empleado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `correo`, `contraseña`, `id_rol`) VALUES
(1, 'Admin1', 'admin1@example.com', '1234', 1),
(2, 'Empleado1', 'empleado1@example.com', '1234', 2),
(3, 'Empleado2', 'empleado2@example.com', '1234', 2),
(4, 'Admin2', 'admin2@example.com', '1234', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alquileres`
--
ALTER TABLE `alquileres`
  ADD PRIMARY KEY (`id_alquiler`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_pelicula` (`id_pelicula`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `correo_cliente` (`correo_cliente`);

--
-- Indices de la tabla `peliculas`
--
ALTER TABLE `peliculas`
  ADD PRIMARY KEY (`id_pelicula`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alquileres`
--
ALTER TABLE `alquileres`
  MODIFY `id_alquiler` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `peliculas`
--
ALTER TABLE `peliculas`
  MODIFY `id_pelicula` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alquileres`
--
ALTER TABLE `alquileres`
  ADD CONSTRAINT `alquileres_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `alquileres_ibfk_2` FOREIGN KEY (`id_pelicula`) REFERENCES `peliculas` (`id_pelicula`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `alquileres_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Base de datos: `tienda_tech_verano`
--
CREATE DATABASE IF NOT EXISTS `tienda_tech_verano` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `tienda_tech_verano`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `icon` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `icon`) VALUES
(1, 'Computadores', 'Portátiles y computadores para productividad.', '💻'),
(2, 'Celulares', 'Smartphones y accesorios móviles.', '📱'),
(3, 'Audio', 'Audífonos, parlantes y soluciones de sonido.', '🎧'),
(4, 'Gaming', 'Equipos y accesorios para videojuegos.', '🎮'),
(5, 'Monitores', 'Pantallas para trabajo y entretenimiento.', '🖥️'),
(6, 'Periféricos', 'Teclados, mouse, cámaras y accesorios.', '⌨️'),
(7, 'Redes', 'Conectividad para hogares y empresas.', '📡');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `status` enum('pending','confirmed','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total`, `status`, `created_at`) VALUES
(1, 3, 1088000.00, 'confirmed', '2026-10-06 21:18:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`) VALUES
(1, 1, 14, 1, 699000.00),
(2, 1, 15, 1, 389000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `emoji` varchar(20) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `price`, `stock`, `emoji`, `active`, `created_at`) VALUES
(1, 1, 'Laptop Nova 14', 'Portátil para trabajo y estudio.', 2499000.00, 10, '💻', 1, '2026-10-06 21:02:50'),
(2, 1, 'Laptop Pro 15', 'Portátil de alto rendimiento.', 3899000.00, 8, '💻', 1, '2026-10-06 21:02:50'),
(3, 1, 'Mini PC Breeze', 'Computador compacto.', 1899000.00, 12, '🖥️', 1, '2026-10-06 21:02:50'),
(4, 1, 'Desktop Creator', 'Equipo para creación de contenido.', 4299000.00, 5, '🖥️', 1, '2026-10-06 21:02:50'),
(5, 1, 'Chromebook Summer', 'Equipo ligero educativo.', 1499000.00, 15, '💻', 1, '2026-10-06 21:02:50'),
(6, 2, 'Smartphone Solar X', 'Teléfono inteligente.', 1699000.00, 14, '📱', 1, '2026-10-06 21:02:50'),
(7, 2, 'Smartphone Wave 5G', 'Conectividad 5G.', 2199000.00, 9, '📱', 1, '2026-10-06 21:02:50'),
(8, 2, 'Smartphone Breeze', 'Modelo equilibrado.', 999000.00, 20, '📱', 1, '2026-10-06 21:02:50'),
(9, 2, 'PowerPhone Max', 'Batería de gran capacidad.', 2399000.00, 7, '📱', 1, '2026-10-06 21:02:50'),
(10, 2, 'Pocket Phone', 'Smartphone compacto.', 799000.00, 18, '📱', 1, '2026-10-06 21:02:50'),
(11, 3, 'Auriculares AirBeat', 'Audífonos inalámbricos.', 299000.00, 25, '🎧', 1, '2026-10-06 21:02:50'),
(12, 3, 'Headset Studio', 'Audífonos multimedia.', 459000.00, 16, '🎧', 1, '2026-10-06 21:02:50'),
(13, 3, 'Speaker Wave', 'Parlante portátil.', 349000.00, 18, '🔊', 1, '2026-10-06 21:02:50'),
(14, 3, 'SoundBar Home', 'Barra de sonido.', 699000.00, 9, '🔊', 1, '2026-10-06 21:02:50'),
(15, 3, 'Mic Pro USB', 'Micrófono para streaming.', 389000.00, 11, '🎙️', 1, '2026-10-06 21:02:50'),
(16, 4, 'GamePad X', 'Control inalámbrico.', 249000.00, 20, '🎮', 1, '2026-10-06 21:02:50'),
(17, 4, 'Keyboard Gamer RGB', 'Teclado mecánico RGB.', 399000.00, 13, '⌨️', 1, '2026-10-06 21:02:50'),
(18, 4, 'Mouse Gamer Pro', 'Mouse de precisión.', 219000.00, 22, '🖱️', 1, '2026-10-06 21:02:50'),
(19, 4, 'Gaming Chair Air', 'Silla gamer.', 899000.00, 6, '🪑', 1, '2026-10-06 21:02:50'),
(20, 4, 'WebCam Stream', 'Cámara para streaming.', 329000.00, 11, '📷', 1, '2026-10-06 21:02:50'),
(21, 5, 'Monitor 24 Full HD', 'Monitor para oficina.', 699000.00, 12, '🖥️', 1, '2026-10-06 21:02:50'),
(22, 5, 'Monitor 27 IPS', 'Pantalla IPS.', 1099000.00, 10, '🖥️', 1, '2026-10-06 21:02:50'),
(23, 5, 'Monitor 32 Ultra', 'Pantalla amplia.', 1799000.00, 6, '🖥️', 1, '2026-10-06 21:02:50'),
(24, 5, 'Monitor 24 Gamer', 'Pantalla gaming.', 1299000.00, 8, '🖥️', 1, '2026-10-06 21:02:50'),
(25, 5, 'Monitor Portable 15', 'Monitor portátil.', 899000.00, 9, '🖥️', 1, '2026-10-06 21:02:50'),
(26, 6, 'Keyboard Office', 'Teclado ergonómico.', 119000.00, 30, '⌨️', 1, '2026-10-06 21:02:50'),
(27, 6, 'Mouse Office', 'Mouse inalámbrico.', 89000.00, 35, '🖱️', 1, '2026-10-06 21:02:50'),
(28, 6, 'WebCam HD', 'Cámara HD.', 179000.00, 17, '📷', 1, '2026-10-06 21:02:50'),
(29, 6, 'Hub USB-C', 'Hub multipuerto.', 159000.00, 21, '🔌', 1, '2026-10-06 21:02:50'),
(30, 6, 'SSD External 1TB', 'Almacenamiento externo.', 429000.00, 14, '💾', 1, '2026-10-06 21:02:50'),
(31, 7, 'Router WiFi 6', 'Router moderno.', 499000.00, 12, '📡', 1, '2026-10-06 21:02:50'),
(32, 7, 'Router Home Mesh', 'Sistema de cobertura.', 799000.00, 7, '📡', 1, '2026-10-06 21:02:50'),
(33, 7, 'Switch 8 Puertos', 'Switch para redes pequeñas.', 229000.00, 15, '🔀', 1, '2026-10-06 21:02:50'),
(34, 7, 'Access Point Pro', 'Punto de acceso.', 459000.00, 9, '📡', 1, '2026-10-06 21:02:50'),
(35, 7, 'Adaptador USB WiFi', 'Adaptador inalámbrico.', 99000.00, 25, '📶', 1, '2026-10-06 21:02:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(160) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('client','admin') NOT NULL DEFAULT 'client',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `active`, `created_at`) VALUES
(1, 'Administrador', 'admin@techverano.local', '$2y$10$nOybilzBv4C0rgln0o/nou8G0WkNvbO3kps9iIGJCUX/5TkUuhO6u', 'admin', 1, '2026-10-06 21:02:50'),
(2, 'Juan Perez', 'jperez@gmail.com', '$2y$10$hNnXPC9pkYUI2JUz36Ms5.oVaTEaomNQK1Aa8Q/pE1vQvuPnakH96', 'client', 1, '2026-10-06 21:15:52'),
(3, 'Juan Perez', 'jperez@hotmail.com', '$2y$10$gH3W2irEc65dO6Igi7yNrua6vl.JT1DujsK9SrQAus2itCxgyVxuq', 'client', 1, '2026-10-06 21:17:55');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Filtros para la tabla `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
--
-- Base de datos: `ventas`
--
CREATE DATABASE IF NOT EXISTS `ventas` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `ventas`;
--
-- Base de datos: `ventas2`
--
CREATE DATABASE IF NOT EXISTS `ventas2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ventas2`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre`, `direccion`, `telefono`, `email`) VALUES
(1, 'Juan Pérez', 'Calle Falsa 123', '555123456', 'juanperez@example.com'),
(2, 'Maria Gomez', 'Avenida Siempre Viva 456', '555654321', 'mariagomez@example.com'),
(3, 'Carlos Lopez', 'Boulevard de la Paz 789', '555987654', 'carloslopez@example.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleventas`
--

CREATE TABLE `detalleventas` (
  `id_detalle` int(11) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalleventas`
--

INSERT INTO `detalleventas` (`id_detalle`, `id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES
(1, 1, 1, 1, 1200.00),
(2, 2, 2, 2, 25.00),
(3, 3, 3, 1, 80.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id_factura` int(11) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `fecha_factura` date NOT NULL,
  `monto_total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`id_factura`, `id_venta`, `fecha_factura`, `monto_total`) VALUES
(1, 1, '2024-01-16', 1250.00),
(2, 2, '2024-01-21', 50.00),
(3, 3, '2024-01-26', 80.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_inventario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_inventario`, `id_producto`, `id_proveedor`, `cantidad`, `fecha_actualizacion`) VALUES
(1, 1, 1, 10, '2024-11-09 16:08:44'),
(2, 2, 2, 50, '2024-11-09 16:08:44'),
(3, 3, 3, 20, '2024-11-09 16:08:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientosinventario`
--

CREATE TABLE `movimientosinventario` (
  `id_movimiento` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `tipo_movimiento` enum('Entrada','Salida') NOT NULL,
  `fecha_movimiento` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `movimientosinventario`
--

INSERT INTO `movimientosinventario` (`id_movimiento`, `id_producto`, `cantidad`, `tipo_movimiento`, `fecha_movimiento`) VALUES
(1, 1, 10, 'Entrada', '2024-11-09 16:08:44'),
(2, 2, 5, 'Salida', '2024-11-09 16:08:44'),
(3, 3, 3, 'Entrada', '2024-11-09 16:08:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`) VALUES
(1, 'Laptop HP', 'Laptop con 8GB RAM y 256GB SSD', 1200.00, 10),
(2, 'Mouse Logitech', 'Mouse inalámbrico', 25.00, 50),
(3, 'Teclado Mecánico', 'Teclado mecánico retroiluminado', 80.00, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre`, `direccion`, `telefono`, `email`) VALUES
(1, 'Proveedor Tech', 'Carrera 45 #32', '555112233', 'proveedortech@example.com'),
(2, 'Distribuidor Global', 'Av. Central 100', '555223344', 'distglobal@example.com'),
(3, 'Electronica Premium', 'Calle 9 #76', '555334455', 'electropremium@example.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `fecha_venta` date NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `id_cliente`, `fecha_venta`, `total`) VALUES
(1, 1, '2024-01-15', 1250.00),
(2, 2, '2024-01-20', 50.00),
(3, 3, '2024-01-25', 80.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `detalleventas`
--
ALTER TABLE `detalleventas`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id_factura`),
  ADD KEY `id_venta` (`id_venta`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_inventario`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `movimientosinventario`
--
ALTER TABLE `movimientosinventario`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalleventas`
--
ALTER TABLE `detalleventas`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id_factura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_inventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `movimientosinventario`
--
ALTER TABLE `movimientosinventario`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalleventas`
--
ALTER TABLE `detalleventas`
  ADD CONSTRAINT `detalleventas_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalleventas_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `movimientosinventario`
--
ALTER TABLE `movimientosinventario`
  ADD CONSTRAINT `movimientosinventario_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE SET NULL ON UPDATE CASCADE;
--
-- Base de datos: `veterinaria_clinica`
--
CREATE DATABASE IF NOT EXISTS `veterinaria_clinica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `veterinaria_clinica`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `appointments`
--

CREATE TABLE `appointments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `pet_id` int(10) UNSIGNED NOT NULL,
  `veterinarian_id` int(10) UNSIGNED NOT NULL,
  `consultation_date` date NOT NULL,
  `consultation_time` time NOT NULL,
  `reason` varchar(500) NOT NULL,
  `observations` text DEFAULT NULL,
  `status` enum('Programada','Atendida','Cancelada','Reprogramada') NOT NULL DEFAULT 'Programada',
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `appointments`
--

INSERT INTO `appointments` (`id`, `owner_id`, `pet_id`, `veterinarian_id`, `consultation_date`, `consultation_time`, `reason`, `observations`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2026-09-02', '09:00:00', 'Control general', 'Paciente tranquila. Datos demostrativos.', 'Programada', 1, NULL, '2026-09-02 14:30:48', '2026-09-02 14:30:48'),
(2, 2, 2, 2, '2026-09-03', '10:30:00', 'Vacunación', 'Revisión previa a vacunación.', 'Programada', 2, NULL, '2026-09-02 14:30:48', '2026-09-02 14:30:48'),
(3, 3, 3, 8, '2026-09-02', '10:45:00', 'Vacunacion y control', 'Se aolica la 3 dosis de la vacuna triple viral y parvovirosis, además se aplicn 5 ml de complejo B via oral, estado general del perro bien, se recomienda refuerzo de vacunas dentro de 3 meses', 'Atendida', 1, 3, '2026-09-02 14:45:35', '2026-09-02 14:53:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(80) NOT NULL,
  `table_name` varchar(80) DEFAULT NULL,
  `record_id` varchar(80) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `details`, `ip_address`, `created_at`) VALUES
(1, 1, 'LOGIN', 'users', '1', 'Inicio de sesión exitoso', '127.0.0.1', '2026-09-02 14:43:17'),
(2, 1, 'CREATE_APPOINTMENT', 'appointments', '3', 'Operación realizada desde el módulo de citas', '127.0.0.1', '2026-09-02 14:45:35'),
(3, 2, 'LOGIN', 'users', '2', 'Inicio de sesión exitoso', '127.0.0.1', '2026-09-02 14:48:38'),
(4, 3, 'LOGIN', 'users', '3', 'Inicio de sesión exitoso', '127.0.0.1', '2026-09-02 14:50:26'),
(5, 3, 'UPDATE_APPOINTMENT', 'appointments', '3', 'Operación realizada desde el módulo de citas', '127.0.0.1', '2026-09-02 14:53:09'),
(6, 1, 'LOGIN', 'users', '1', 'Inicio de sesión exitoso', '::1', '2026-09-02 21:03:00'),
(7, 1, 'LOGIN', 'users', '1', 'Inicio de sesión exitoso', '::1', '2026-09-02 21:10:28'),
(8, 3, 'LOGIN', 'users', '3', 'Inicio de sesión exitoso', '::1', '2026-09-02 21:13:32'),
(9, 1, 'LOGIN', 'users', '1', 'Inicio de sesión exitoso', '::1', '2026-09-02 21:17:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `breeds`
--

CREATE TABLE `breeds` (
  `id` int(10) UNSIGNED NOT NULL,
  `species_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `breeds`
--

INSERT INTO `breeds` (`id`, `species_id`, `name`, `active`, `created_at`) VALUES
(1, 1, 'Labrador Retriever', 1, '2026-09-02 14:30:48'),
(2, 1, 'Golden Retriever', 1, '2026-09-02 14:30:48'),
(3, 1, 'Pastor Alemán', 1, '2026-09-02 14:30:48'),
(4, 1, 'Bulldog Francés', 1, '2026-09-02 14:30:48'),
(5, 1, 'Bulldog Inglés', 1, '2026-09-02 14:30:48'),
(6, 1, 'Beagle', 1, '2026-09-02 14:30:48'),
(7, 1, 'Poodle', 1, '2026-09-02 14:30:48'),
(8, 1, 'Chihuahua', 1, '2026-09-02 14:30:48'),
(9, 1, 'Rottweiler', 1, '2026-09-02 14:30:48'),
(10, 1, 'Husky Siberiano', 1, '2026-09-02 14:30:48'),
(11, 2, 'Siamés', 1, '2026-09-02 14:30:48'),
(12, 2, 'Persa', 1, '2026-09-02 14:30:48'),
(13, 2, 'Maine Coon', 1, '2026-09-02 14:30:48'),
(14, 2, 'Bengalí', 1, '2026-09-02 14:30:48'),
(15, 2, 'Esfinge (Sphynx)', 1, '2026-09-02 14:30:48'),
(16, 2, 'Angora Turco', 1, '2026-09-02 14:30:48'),
(17, 2, 'British Shorthair', 1, '2026-09-02 14:30:48'),
(18, 2, 'Ragdoll', 1, '2026-09-02 14:30:48'),
(19, 2, 'Scottish Fold', 1, '2026-09-02 14:30:48'),
(20, 2, 'Azul Ruso', 1, '2026-09-02 14:30:48'),
(21, 3, 'Holandés', 1, '2026-09-02 14:30:48'),
(22, 3, 'Cabeza de León', 1, '2026-09-02 14:30:48'),
(23, 3, 'Rex', 1, '2026-09-02 14:30:48'),
(24, 3, 'Mini Rex', 1, '2026-09-02 14:30:48'),
(25, 3, 'Bélier', 1, '2026-09-02 14:30:48'),
(26, 3, 'Gigante de Flandes', 1, '2026-09-02 14:30:48'),
(27, 3, 'Californiano', 1, '2026-09-02 14:30:48'),
(28, 3, 'Nueva Zelanda', 1, '2026-09-02 14:30:48'),
(29, 3, 'Himalayo', 1, '2026-09-02 14:30:48'),
(30, 3, 'Angora', 1, '2026-09-02 14:30:48'),
(31, 4, 'Sirio', 1, '2026-09-02 14:30:48'),
(32, 4, 'Ruso Enano', 1, '2026-09-02 14:30:48'),
(33, 4, 'Roborovski', 1, '2026-09-02 14:30:48'),
(34, 4, 'Chino', 1, '2026-09-02 14:30:48'),
(35, 4, 'Campbell', 1, '2026-09-02 14:30:48'),
(36, 4, 'Teddy Bear', 1, '2026-09-02 14:30:48'),
(37, 4, 'Panda', 1, '2026-09-02 14:30:48'),
(38, 4, 'Black Bear', 1, '2026-09-02 14:30:48'),
(39, 4, 'Dorado', 1, '2026-09-02 14:30:48'),
(40, 4, 'Winter White', 1, '2026-09-02 14:30:48'),
(41, 5, 'Americano', 1, '2026-09-02 14:30:48'),
(42, 5, 'Abisinio', 1, '2026-09-02 14:30:48'),
(43, 5, 'Peruano', 1, '2026-09-02 14:30:48'),
(44, 5, 'Silkie', 1, '2026-09-02 14:30:48'),
(45, 5, 'Teddy', 1, '2026-09-02 14:30:48'),
(46, 5, 'Texel', 1, '2026-09-02 14:30:48'),
(47, 5, 'Coronet', 1, '2026-09-02 14:30:48'),
(48, 5, 'Skinny', 1, '2026-09-02 14:30:48'),
(49, 5, 'Rex', 1, '2026-09-02 14:30:48'),
(50, 5, 'Alpaca', 1, '2026-09-02 14:30:48'),
(51, 6, 'Sable', 1, '2026-09-02 14:30:48'),
(52, 6, 'Albino', 1, '2026-09-02 14:30:48'),
(53, 6, 'Canela', 1, '2026-09-02 14:30:48'),
(54, 6, 'Chocolate', 1, '2026-09-02 14:30:48'),
(55, 6, 'Champagne', 1, '2026-09-02 14:30:48'),
(56, 6, 'Black Sable', 1, '2026-09-02 14:30:48'),
(57, 6, 'Panda', 1, '2026-09-02 14:30:48'),
(58, 6, 'Blaze', 1, '2026-09-02 14:30:48'),
(59, 6, 'Silver', 1, '2026-09-02 14:30:48'),
(60, 6, 'Marked White', 1, '2026-09-02 14:30:48'),
(61, 7, 'Canario', 1, '2026-09-02 14:30:48'),
(62, 7, 'Periquito Australiano', 1, '2026-09-02 14:30:48'),
(63, 7, 'Ninfa / Cacatúa', 1, '2026-09-02 14:30:48'),
(64, 7, 'Agapornis', 1, '2026-09-02 14:30:48'),
(65, 7, 'Diamante Mandarín', 1, '2026-09-02 14:30:48'),
(66, 7, 'Cacatúa', 1, '2026-09-02 14:30:48'),
(67, 7, 'Loro Gris Africano', 1, '2026-09-02 14:30:48'),
(68, 7, 'Guacamaya Azul y Amarilla', 1, '2026-09-02 14:30:48'),
(69, 7, 'Cotorra Argentina', 1, '2026-09-02 14:30:48'),
(70, 7, 'Loro Eclectus', 1, '2026-09-02 14:30:48'),
(71, 8, 'Betta', 1, '2026-09-02 14:30:48'),
(72, 8, 'Goldfish', 1, '2026-09-02 14:30:48'),
(73, 8, 'Guppy', 1, '2026-09-02 14:30:48'),
(74, 8, 'Molly', 1, '2026-09-02 14:30:48'),
(75, 8, 'Platy', 1, '2026-09-02 14:30:48'),
(76, 8, 'Pez Ángel', 1, '2026-09-02 14:30:48'),
(77, 8, 'Tetra Neón', 1, '2026-09-02 14:30:48'),
(78, 8, 'Koi', 1, '2026-09-02 14:30:48'),
(79, 8, 'Oscar', 1, '2026-09-02 14:30:48'),
(80, 8, 'Pez Disco', 1, '2026-09-02 14:30:48'),
(81, 9, 'De Orejas Rojas', 1, '2026-09-02 14:30:48'),
(82, 9, 'Mediterránea', 1, '2026-09-02 14:30:48'),
(83, 9, 'Rusa', 1, '2026-09-02 14:30:48'),
(84, 9, 'Mora', 1, '2026-09-02 14:30:48'),
(85, 9, 'Sulcata', 1, '2026-09-02 14:30:48'),
(86, 9, 'Leopardo', 1, '2026-09-02 14:30:48'),
(87, 9, 'Caja', 1, '2026-09-02 14:30:48'),
(88, 9, 'Mapa', 1, '2026-09-02 14:30:48'),
(89, 9, 'Caimán', 1, '2026-09-02 14:30:48'),
(90, 9, 'De Florida', 1, '2026-09-02 14:30:48'),
(91, 10, 'Verde', 1, '2026-09-02 14:30:48'),
(92, 10, 'Roja', 1, '2026-09-02 14:30:48'),
(93, 10, 'Azul', 1, '2026-09-02 14:30:48'),
(94, 10, 'Rinoceronte', 1, '2026-09-02 14:30:48'),
(95, 10, 'Marina', 1, '2026-09-02 14:30:48'),
(96, 10, 'Desértica', 1, '2026-09-02 14:30:48'),
(97, 10, 'Negra de Cola Espinosa', 1, '2026-09-02 14:30:48'),
(98, 10, 'Chuckwalla', 1, '2026-09-02 14:30:48'),
(99, 10, 'De Fiji', 1, '2026-09-02 14:30:48'),
(100, 10, 'De las Rocas', 1, '2026-09-02 14:30:48'),
(101, 11, 'De Maíz', 1, '2026-09-02 14:30:48'),
(102, 11, 'Rey de California', 1, '2026-09-02 14:30:48'),
(103, 11, 'Pitón Bola', 1, '2026-09-02 14:30:48'),
(104, 11, 'Boa Constrictora', 1, '2026-09-02 14:30:48'),
(105, 11, 'Pitón Reticulada', 1, '2026-09-02 14:30:48'),
(106, 11, 'Pitón Real', 1, '2026-09-02 14:30:48'),
(107, 11, 'Serpiente de Leche', 1, '2026-09-02 14:30:48'),
(108, 11, 'Falsa Coral', 1, '2026-09-02 14:30:48'),
(109, 11, 'Gopher', 1, '2026-09-02 14:30:48'),
(110, 11, 'Hognose', 1, '2026-09-02 14:30:48'),
(111, 12, 'Leopardo', 1, '2026-09-02 14:30:48'),
(112, 12, 'Crestado', 1, '2026-09-02 14:30:48'),
(113, 12, 'Tokay', 1, '2026-09-02 14:30:48'),
(114, 12, 'De Cola Gorda Africano', 1, '2026-09-02 14:30:48'),
(115, 12, 'Gargoyle', 1, '2026-09-02 14:30:48'),
(116, 12, 'Diurno de Madagascar', 1, '2026-09-02 14:30:48'),
(117, 12, 'Gigante de Nueva Caledonia', 1, '2026-09-02 14:30:48'),
(118, 12, 'De Dedo de Hoja', 1, '2026-09-02 14:30:48'),
(119, 12, 'De Cola de Hoja', 1, '2026-09-02 14:30:48'),
(120, 12, 'De Pared', 1, '2026-09-02 14:30:48'),
(121, 13, 'Yemen', 1, '2026-09-02 14:30:48'),
(122, 13, 'Pantera', 1, '2026-09-02 14:30:48'),
(123, 13, 'Jackson', 1, '2026-09-02 14:30:48'),
(124, 13, 'Melleri', 1, '2026-09-02 14:30:48'),
(125, 13, 'Senegal', 1, '2026-09-02 14:30:48'),
(126, 13, 'Fischer', 1, '2026-09-02 14:30:48'),
(127, 13, 'Alfombra', 1, '2026-09-02 14:30:48'),
(128, 13, 'Velado', 1, '2026-09-02 14:30:48'),
(129, 13, 'Pigmeo', 1, '2026-09-02 14:30:48'),
(130, 13, 'Parson', 1, '2026-09-02 14:30:48'),
(131, 14, 'Africano Pigmeo', 1, '2026-09-02 14:30:48'),
(132, 14, 'Europeo', 1, '2026-09-02 14:30:48'),
(133, 14, 'Orejas Largas', 1, '2026-09-02 14:30:48'),
(134, 14, 'Desértico', 1, '2026-09-02 14:30:48'),
(135, 14, 'Somalí', 1, '2026-09-02 14:30:48'),
(136, 14, 'Egipcio de Orejas Largas', 1, '2026-09-02 14:30:48'),
(137, 14, 'Indio de Orejas Largas', 1, '2026-09-02 14:30:48'),
(138, 14, 'Amur', 1, '2026-09-02 14:30:48'),
(139, 14, 'Dauriano', 1, '2026-09-02 14:30:48'),
(140, 14, 'Brandt', 1, '2026-09-02 14:30:48'),
(141, 15, 'Estándar Gris', 1, '2026-09-02 14:30:48'),
(142, 15, 'Beige', 1, '2026-09-02 14:30:48'),
(143, 15, 'Blanca', 1, '2026-09-02 14:30:48'),
(144, 15, 'Ebony', 1, '2026-09-02 14:30:48'),
(145, 15, 'Violeta', 1, '2026-09-02 14:30:48'),
(146, 15, 'Sapphire', 1, '2026-09-02 14:30:48'),
(147, 15, 'Blue Diamond', 1, '2026-09-02 14:30:48'),
(148, 15, 'Mosaic', 1, '2026-09-02 14:30:48'),
(149, 15, 'Black Velvet', 1, '2026-09-02 14:30:48'),
(150, 15, 'Brown Velvet', 1, '2026-09-02 14:30:48'),
(151, 16, 'Dumbo', 1, '2026-09-02 14:30:48'),
(152, 16, 'Rex', 1, '2026-09-02 14:30:48'),
(153, 16, 'Hairless', 1, '2026-09-02 14:30:48'),
(154, 16, 'Hooded', 1, '2026-09-02 14:30:48'),
(155, 16, 'Berkshire', 1, '2026-09-02 14:30:48'),
(156, 16, 'Siamese', 1, '2026-09-02 14:30:48'),
(157, 16, 'Himalayan', 1, '2026-09-02 14:30:48'),
(158, 16, 'Blue', 1, '2026-09-02 14:30:48'),
(159, 16, 'Black', 1, '2026-09-02 14:30:48'),
(160, 16, 'Agouti', 1, '2026-09-02 14:30:48'),
(161, 17, 'Doméstico', 1, '2026-09-02 14:30:48'),
(162, 17, 'Fancy', 1, '2026-09-02 14:30:48'),
(163, 17, 'Albino', 1, '2026-09-02 14:30:48'),
(164, 17, 'Black', 1, '2026-09-02 14:30:48'),
(165, 17, 'Agouti', 1, '2026-09-02 14:30:48'),
(166, 17, 'Satin', 1, '2026-09-02 14:30:48'),
(167, 17, 'Long Hair', 1, '2026-09-02 14:30:48'),
(168, 17, 'Hairless', 1, '2026-09-02 14:30:48'),
(169, 17, 'Spiny', 1, '2026-09-02 14:30:48'),
(170, 17, 'Piebald', 1, '2026-09-02 14:30:48'),
(171, 18, 'Vietnamita', 1, '2026-09-02 14:30:48'),
(172, 18, 'Juliana', 1, '2026-09-02 14:30:48'),
(173, 18, 'Göttingen', 1, '2026-09-02 14:30:48'),
(174, 18, 'American Mini Pig', 1, '2026-09-02 14:30:48'),
(175, 18, 'Kunekune', 1, '2026-09-02 14:30:48'),
(176, 18, 'Yucatán', 1, '2026-09-02 14:30:48'),
(177, 18, 'Sinclair', 1, '2026-09-02 14:30:48'),
(178, 18, 'Ossabaw', 1, '2026-09-02 14:30:48'),
(179, 18, 'Pot-bellied', 1, '2026-09-02 14:30:48'),
(180, 18, 'Miniature White', 1, '2026-09-02 14:30:48'),
(181, 19, 'Enana Nigeriana', 1, '2026-09-02 14:30:48'),
(182, 19, 'Pygmy', 1, '2026-09-02 14:30:48'),
(183, 19, 'Boer', 1, '2026-09-02 14:30:48'),
(184, 19, 'Alpina', 1, '2026-09-02 14:30:48'),
(185, 19, 'Saanen', 1, '2026-09-02 14:30:48'),
(186, 19, 'Nubia', 1, '2026-09-02 14:30:48'),
(187, 19, 'LaMancha', 1, '2026-09-02 14:30:48'),
(188, 19, 'Toggenburg', 1, '2026-09-02 14:30:48'),
(189, 19, 'Anglo-Nubian', 1, '2026-09-02 14:30:48'),
(190, 19, 'Angora', 1, '2026-09-02 14:30:48'),
(191, 20, 'Criollo Colombiano', 1, '2026-09-02 14:30:48'),
(192, 20, 'Paso Fino', 1, '2026-09-02 14:30:48'),
(193, 20, 'Cuarto de Milla', 1, '2026-09-02 14:30:48'),
(194, 20, 'Árabe', 1, '2026-09-02 14:30:48'),
(195, 20, 'Pura Sangre Inglés', 1, '2026-09-02 14:30:48'),
(196, 20, 'Frisón', 1, '2026-09-02 14:30:48'),
(197, 20, 'Andaluz', 1, '2026-09-02 14:30:48'),
(198, 20, 'Appaloosa', 1, '2026-09-02 14:30:48'),
(199, 20, 'Percherón', 1, '2026-09-02 14:30:48'),
(200, 20, 'Shire', 1, '2026-09-02 14:30:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `owners`
--

CREATE TABLE `owners` (
  `id` int(10) UNSIGNED NOT NULL,
  `document_number` varchar(50) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `owners`
--

INSERT INTO `owners` (`id`, `document_number`, `full_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES
(1, '100000001', 'María Fernanda López', 'maria.lopez@example.local', '3001112233', '2026-09-02 14:30:48', '2026-09-02 14:30:48'),
(2, '100000002', 'Carlos Andrés Pérez', 'carlos.perez@example.local', '3012223344', '2026-09-02 14:30:48', '2026-09-02 14:30:48'),
(3, '45332234', 'Pedro Suarez', 'peter@gmail.com', '304345346', '2026-09-02 14:45:35', '2026-09-02 14:45:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(80) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`id`, `code`, `description`) VALUES
(1, 'dashboard.view', 'Consultar tablero principal'),
(2, 'appointments.view', 'Consultar citas'),
(3, 'appointments.create', 'Registrar citas'),
(4, 'appointments.update', 'Modificar citas'),
(5, 'appointments.delete', 'Eliminar citas'),
(6, 'catalogs.manage', 'Administrar especies, razas y veterinarios'),
(7, 'users.manage', 'Administrar usuarios y roles'),
(8, 'audit.view', 'Consultar auditoría');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pets`
--

CREATE TABLE `pets` (
  `id` int(10) UNSIGNED NOT NULL,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `species_id` int(10) UNSIGNED NOT NULL,
  `breed_id` int(10) UNSIGNED DEFAULT NULL,
  `custom_breed` varchar(120) DEFAULT NULL,
  `age_value` decimal(5,2) DEFAULT NULL,
  `age_unit` enum('meses','años') NOT NULL DEFAULT 'años',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pets`
--

INSERT INTO `pets` (`id`, `owner_id`, `name`, `species_id`, `breed_id`, `custom_breed`, `age_value`, `age_unit`, `active`, `created_at`, `updated_at`) VALUES
(1, 1, 'Luna', 2, 12, NULL, 3.00, 'años', 1, '2026-09-02 14:30:48', '2026-09-02 14:30:48'),
(2, 2, 'Max', 1, 1, NULL, 5.00, 'años', 1, '2026-09-02 14:30:48', '2026-09-02 14:30:48'),
(3, 3, 'Max', 1, 6, NULL, 3.00, 'años', 1, '2026-09-02 14:45:35', '2026-09-02 14:45:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `active`, `created_at`) VALUES
(1, 'ADMINISTRADOR', 'Acceso completo a la aplicación y administración', 1, '2026-09-02 14:30:48'),
(2, 'RECEPCIONISTA', 'Gestiona propietarios, mascotas y citas', 1, '2026-09-02 14:30:48'),
(3, 'VETERINARIO', 'Consulta y actualiza las citas asignadas', 1, '2026-09-02 14:30:48'),
(4, 'AUXILIAR', 'Consulta información operativa de citas', 1, '2026-09-02 14:30:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(3, 1),
(3, 2),
(3, 4),
(4, 1),
(4, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `species`
--

CREATE TABLE `species` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `species`
--

INSERT INTO `species` (`id`, `name`, `active`, `created_at`) VALUES
(1, 'Perro', 1, '2026-09-02 14:30:48'),
(2, 'Gato', 1, '2026-09-02 14:30:48'),
(3, 'Conejo', 1, '2026-09-02 14:30:48'),
(4, 'Hámster', 1, '2026-09-02 14:30:48'),
(5, 'Cobayo / Cuy', 1, '2026-09-02 14:30:48'),
(6, 'Hurón', 1, '2026-09-02 14:30:48'),
(7, 'Ave', 1, '2026-09-02 14:30:48'),
(8, 'Pez', 1, '2026-09-02 14:30:48'),
(9, 'Tortuga', 1, '2026-09-02 14:30:48'),
(10, 'Iguana', 1, '2026-09-02 14:30:48'),
(11, 'Serpiente', 1, '2026-09-02 14:30:48'),
(12, 'Gecko', 1, '2026-09-02 14:30:48'),
(13, 'Camaleón', 1, '2026-09-02 14:30:48'),
(14, 'Erizo', 1, '2026-09-02 14:30:48'),
(15, 'Chinchilla', 1, '2026-09-02 14:30:48'),
(16, 'Rata', 1, '2026-09-02 14:30:48'),
(17, 'Ratón', 1, '2026-09-02 14:30:48'),
(18, 'Cerdo miniatura', 1, '2026-09-02 14:30:48'),
(19, 'Cabra', 1, '2026-09-02 14:30:48'),
(20, 'Caballo', 1, '2026-09-02 14:30:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `veterinarian_id` int(10) UNSIGNED DEFAULT NULL,
  `full_name` varchar(150) NOT NULL,
  `username` varchar(60) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `role_id`, `veterinarian_id`, `full_name`, `username`, `email`, `password_hash`, `active`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'Administrador del Sistema', 'admin', 'admin@clinicaveterinaria.local', '$2y$12$FqEoS13p2rjYWHmLzxo0EeE3De.nnBKqs09Zj3xFMkWlOoYCuijtu', 1, '2026-09-02 16:17:35', '2026-09-02 14:30:48', '2026-09-02 21:17:35'),
(2, 2, NULL, 'Recepción Clínica', 'recepcion', 'recepcion@clinicaveterinaria.local', '$2y$12$5fUVvWr8ShqbBcjdoXOVUOCLrdGq0gX7wbZ.5sgZTwo5PsxnXLvn6', 1, '2026-09-02 09:48:38', '2026-09-02 14:30:48', '2026-09-02 14:48:38'),
(3, 3, 1, 'Dra. Laura Martínez', 'veterinaria1', 'laura@clinicaveterinaria.local', '$2y$12$DTfcP55lkIWEH.QjL45deuswkyo1R5bijmkk7u15mXVDEAaLFlxzq', 1, '2026-09-02 16:13:32', '2026-09-02 14:30:48', '2026-09-02 21:13:32'),
(4, 4, NULL, 'Auxiliar Clínica', 'auxiliar', 'auxiliar@clinicaveterinaria.local', '$2y$12$k0CxEwHdg7dsABA5RyfbseFr3KMBxYQGk8tcGtD2SS6BAATKRKIxS', 1, NULL, '2026-09-02 14:30:48', '2026-09-02 14:30:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `veterinarians`
--

CREATE TABLE `veterinarians` (
  `id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `license_number` varchar(80) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `specialty` varchar(120) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `veterinarians`
--

INSERT INTO `veterinarians` (`id`, `full_name`, `license_number`, `phone`, `email`, `specialty`, `active`, `created_at`) VALUES
(1, 'Dra. Laura Martínez', 'MVZ-2026-001', '300 000 0001', 'vet1@clinicaveterinaria.local', 'Medicina interna', 1, '2026-09-02 14:30:48'),
(2, 'Dr. Andrés Gómez', 'MVZ-2026-002', '300 000 0002', 'vet2@clinicaveterinaria.local', 'Dermatología', 1, '2026-09-02 14:30:48'),
(3, 'Dra. Carolina Rodríguez', 'MVZ-2026-003', '300 000 0003', 'vet3@clinicaveterinaria.local', 'Cirugía', 1, '2026-09-02 14:30:48'),
(4, 'Dr. Felipe Torres', 'MVZ-2026-004', '300 000 0004', 'vet4@clinicaveterinaria.local', 'Medicina felina', 1, '2026-09-02 14:30:48'),
(5, 'Dra. Natalia Herrera', 'MVZ-2026-005', '300 000 0005', 'vet5@clinicaveterinaria.local', 'Medicina preventiva', 1, '2026-09-02 14:30:48'),
(6, 'Dr. Sebastián Moreno', 'MVZ-2026-006', '300 000 0006', 'vet6@clinicaveterinaria.local', 'Medicina interna', 1, '2026-09-02 14:30:48'),
(7, 'Dra. Valentina Castro', 'MVZ-2026-007', '300 000 0007', 'vet7@clinicaveterinaria.local', 'Dermatología', 1, '2026-09-02 14:30:48'),
(8, 'Dr. Juan Pablo Ramírez', 'MVZ-2026-008', '300 000 0008', 'vet8@clinicaveterinaria.local', 'Cirugía', 1, '2026-09-02 14:30:48'),
(9, 'Dra. Diana López', 'MVZ-2026-009', '300 000 0009', 'vet9@clinicaveterinaria.local', 'Medicina felina', 1, '2026-09-02 14:30:48'),
(10, 'Dr. Miguel Ángel Vargas', 'MVZ-2026-010', '300 000 0010', 'vet10@clinicaveterinaria.local', 'Medicina preventiva', 1, '2026-09-02 14:30:48');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_appointments`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_appointments` (
`id` bigint(20) unsigned
,`owner_name` varchar(150)
,`owner_document` varchar(50)
,`owner_email` varchar(150)
,`owner_phone` varchar(30)
,`pet_name` varchar(100)
,`species_name` varchar(100)
,`breed_name` varchar(120)
,`age_value` decimal(5,2)
,`age_unit` enum('meses','años')
,`consultation_date` date
,`consultation_time` time
,`veterinarian_name` varchar(150)
,`reason` varchar(500)
,`observations` text
,`status` enum('Programada','Atendida','Cancelada','Reprogramada')
,`created_at` timestamp
,`updated_at` timestamp
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_appointments`
--
DROP TABLE IF EXISTS `vw_appointments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_appointments`  AS SELECT `a`.`id` AS `id`, `o`.`full_name` AS `owner_name`, `o`.`document_number` AS `owner_document`, `o`.`email` AS `owner_email`, `o`.`phone` AS `owner_phone`, `p`.`name` AS `pet_name`, `s`.`name` AS `species_name`, coalesce(`b`.`name`,`p`.`custom_breed`,'No especificada') AS `breed_name`, `p`.`age_value` AS `age_value`, `p`.`age_unit` AS `age_unit`, `a`.`consultation_date` AS `consultation_date`, `a`.`consultation_time` AS `consultation_time`, `v`.`full_name` AS `veterinarian_name`, `a`.`reason` AS `reason`, `a`.`observations` AS `observations`, `a`.`status` AS `status`, `a`.`created_at` AS `created_at`, `a`.`updated_at` AS `updated_at` FROM (((((`appointments` `a` join `owners` `o` on(`o`.`id` = `a`.`owner_id`)) join `pets` `p` on(`p`.`id` = `a`.`pet_id`)) join `species` `s` on(`s`.`id` = `p`.`species_id`)) left join `breeds` `b` on(`b`.`id` = `p`.`breed_id`)) join `veterinarians` `v` on(`v`.`id` = `a`.`veterinarian_id`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_appointments_created_by` (`created_by`),
  ADD KEY `fk_appointments_updated_by` (`updated_by`),
  ADD KEY `idx_appointments_date` (`consultation_date`),
  ADD KEY `idx_appointments_status` (`status`),
  ADD KEY `idx_appointments_owner` (`owner_id`),
  ADD KEY `idx_appointments_pet` (`pet_id`),
  ADD KEY `idx_appointments_vet` (`veterinarian_id`);

--
-- Indices de la tabla `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_user` (`user_id`),
  ADD KEY `idx_audit_action` (`action`),
  ADD KEY `idx_audit_date` (`created_at`);

--
-- Indices de la tabla `breeds`
--
ALTER TABLE `breeds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_breed_species` (`species_id`,`name`);

--
-- Indices de la tabla `owners`
--
ALTER TABLE `owners`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `document_number` (`document_number`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indices de la tabla `pets`
--
ALTER TABLE `pets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pets_owner` (`owner_id`),
  ADD KEY `fk_pets_species` (`species_id`),
  ADD KEY `fk_pets_breed` (`breed_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `fk_rp_permission` (`permission_id`);

--
-- Indices de la tabla `species`
--
ALTER TABLE `species`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_users_role` (`role_id`);

--
-- Indices de la tabla `veterinarians`
--
ALTER TABLE `veterinarians`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `license_number` (`license_number`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `breeds`
--
ALTER TABLE `breeds`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;

--
-- AUTO_INCREMENT de la tabla `owners`
--
ALTER TABLE `owners`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `pets`
--
ALTER TABLE `pets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `species`
--
ALTER TABLE `species`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `veterinarians`
--
ALTER TABLE `veterinarians`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `fk_appointments_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_appointments_owner` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_appointments_pet` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_appointments_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_appointments_vet` FOREIGN KEY (`veterinarian_id`) REFERENCES `veterinarians` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `breeds`
--
ALTER TABLE `breeds`
  ADD CONSTRAINT `fk_breeds_species` FOREIGN KEY (`species_id`) REFERENCES `species` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `pets`
--
ALTER TABLE `pets`
  ADD CONSTRAINT `fk_pets_breed` FOREIGN KEY (`breed_id`) REFERENCES `breeds` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pets_owner` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pets_species` FOREIGN KEY (`species_id`) REFERENCES `species` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `fk_rp_permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rp_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
