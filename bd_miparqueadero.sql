-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-05-2023 a las 10:55:38
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_miparqueadero`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_cliente`
--

CREATE TABLE `tb_cliente` (
  `id_cliente` int(11) NOT NULL,
  `doc_identidad_cli` varchar(45) NOT NULL,
  `direccion_cli` varchar(45) DEFAULT NULL,
  `telefono_cli` varchar(45) NOT NULL,
  `correo_cli` varchar(45) DEFAULT NULL,
  `nombre_cli` varchar(45) NOT NULL,
  `apellido_cli` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tb_cliente`
--

INSERT INTO `tb_cliente` (`id_cliente`, `doc_identidad_cli`, `direccion_cli`, `telefono_cli`, `correo_cli`, `nombre_cli`, `apellido_cli`) VALUES
(6, '23455441', 'La Maria', '212454500', 'calderar@gmail.com', 'Rochy', 'Caldera uwu'),
(8, '64565911', 'Arabasta', '2808015', 'nefvivi@gmail.com', 'vivi', 'Nefertari'),
(9, '132131312', NULL, '2224', NULL, 'Angie', 'Jaimes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_empleado`
--

CREATE TABLE `tb_empleado` (
  `id_empleado` int(11) NOT NULL,
  `nombre_empleado` varchar(45) NOT NULL,
  `apellido_empleado` varchar(45) NOT NULL,
  `cargo_empleado` varchar(45) NOT NULL,
  `dir_empleado` varchar(45) NOT NULL,
  `tel_empleado` int(11) NOT NULL,
  `correo_empleado` varchar(45) NOT NULL,
  `usuario_empleado` varchar(45) NOT NULL,
  `contrasena_empleado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tarifa`
--

CREATE TABLE `tb_tarifa` (
  `id_tarifa` int(11) NOT NULL,
  `valor_hora` int(11) NOT NULL,
  `valor_fraccion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_ticket`
--

CREATE TABLE `tb_ticket` (
  `id_ticket` int(11) NOT NULL,
  `fecha_ingreso` datetime(6) NOT NULL,
  `fecha_salida` datetime(6) NOT NULL,
  `tiempo_estadia` time NOT NULL,
  `valor_pagar` int(11) NOT NULL,
  `id_vehiculo` int(11) NOT NULL,
  `id_tarifa` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_vehiculo`
--

CREATE TABLE `tb_vehiculo` (
  `id_vehiculo` int(11) NOT NULL,
  `placa_vehiculo` varchar(45) NOT NULL,
  `tipo_vehiculo` varchar(45) NOT NULL,
  `marca_vehiculo` varchar(45) NOT NULL,
  `modelo_vehiculo` varchar(45) DEFAULT NULL,
  `color_vehiculo` varchar(45) NOT NULL,
  `observaciones_veh` varchar(60) DEFAULT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tb_vehiculo`
--

INSERT INTO `tb_vehiculo` (`id_vehiculo`, `placa_vehiculo`, `tipo_vehiculo`, `marca_vehiculo`, `modelo_vehiculo`, `color_vehiculo`, `observaciones_veh`, `id_cliente`) VALUES
(2, 'EKD123', 'CARRO', 'KIA', NULL, 'GRIS', NULL, 6);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tb_cliente`
--
ALTER TABLE `tb_cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `tb_empleado`
--
ALTER TABLE `tb_empleado`
  ADD PRIMARY KEY (`id_empleado`);

--
-- Indices de la tabla `tb_tarifa`
--
ALTER TABLE `tb_tarifa`
  ADD PRIMARY KEY (`id_tarifa`);

--
-- Indices de la tabla `tb_ticket`
--
ALTER TABLE `tb_ticket`
  ADD PRIMARY KEY (`id_ticket`),
  ADD KEY `fk_vehiculo_idx` (`id_vehiculo`),
  ADD KEY `fk_tarifa_idx` (`id_tarifa`),
  ADD KEY `fk_empleado_idx` (`id_empleado`);

--
-- Indices de la tabla `tb_vehiculo`
--
ALTER TABLE `tb_vehiculo`
  ADD PRIMARY KEY (`id_vehiculo`),
  ADD KEY `fk_cliente_vehiculo` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tb_cliente`
--
ALTER TABLE `tb_cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tb_empleado`
--
ALTER TABLE `tb_empleado`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_tarifa`
--
ALTER TABLE `tb_tarifa`
  MODIFY `id_tarifa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_ticket`
--
ALTER TABLE `tb_ticket`
  MODIFY `id_ticket` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_vehiculo`
--
ALTER TABLE `tb_vehiculo`
  MODIFY `id_vehiculo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tb_ticket`
--
ALTER TABLE `tb_ticket`
  ADD CONSTRAINT `fk_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `tb_empleado` (`id_empleado`),
  ADD CONSTRAINT `fk_tarifa` FOREIGN KEY (`id_tarifa`) REFERENCES `tb_tarifa` (`id_tarifa`),
  ADD CONSTRAINT `fk_vehiculo_ticket` FOREIGN KEY (`id_vehiculo`) REFERENCES `tb_vehiculo` (`id_vehiculo`);

--
-- Filtros para la tabla `tb_vehiculo`
--
ALTER TABLE `tb_vehiculo`
  ADD CONSTRAINT `fk_cliente_vehiculo` FOREIGN KEY (`id_cliente`) REFERENCES `tb_cliente` (`id_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
