-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-06-2019 a las 06:58:38
-- Versión del servidor: 10.1.36-MariaDB
-- Versión de PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sunat`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `idDepartamento` int(4) NOT NULL,
  `Nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `igv`
--

CREATE TABLE `igv` (
  `idIGV` int(4) NOT NULL,
  `monto` int(20) NOT NULL,
  `idDepartamento` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuestorenta`
--

CREATE TABLE `impuestorenta` (
  `idImpuestoRenta` int(4) NOT NULL,
  `monto` int(20) NOT NULL,
  `idDepartamento` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tributoaduanas`
--

CREATE TABLE `tributoaduanas` (
  `idTributoAduanas` int(4) NOT NULL,
  `monto` varchar(20) NOT NULL,
  `idDepartamento` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tributointerno`
--

CREATE TABLE `tributointerno` (
  `idTributointerno` int(4) NOT NULL,
  `monto` int(20) NOT NULL,
  `idDepartamento` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`idDepartamento`);

--
-- Indices de la tabla `igv`
--
ALTER TABLE `igv`
  ADD PRIMARY KEY (`idIGV`),
  ADD KEY `idDepartamento` (`idDepartamento`);

--
-- Indices de la tabla `impuestorenta`
--
ALTER TABLE `impuestorenta`
  ADD PRIMARY KEY (`idImpuestoRenta`),
  ADD KEY `idDepartamento` (`idDepartamento`);

--
-- Indices de la tabla `tributoaduanas`
--
ALTER TABLE `tributoaduanas`
  ADD PRIMARY KEY (`idTributoAduanas`),
  ADD KEY `idDepartamento` (`idDepartamento`);

--
-- Indices de la tabla `tributointerno`
--
ALTER TABLE `tributointerno`
  ADD PRIMARY KEY (`idTributointerno`),
  ADD KEY `idDepartamento` (`idDepartamento`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `idDepartamento` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `igv`
--
ALTER TABLE `igv`
  MODIFY `idIGV` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `impuestorenta`
--
ALTER TABLE `impuestorenta`
  MODIFY `idImpuestoRenta` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tributoaduanas`
--
ALTER TABLE `tributoaduanas`
  MODIFY `idTributoAduanas` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tributointerno`
--
ALTER TABLE `tributointerno`
  MODIFY `idTributointerno` int(4) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `igv`
--
ALTER TABLE `igv`
  ADD CONSTRAINT `igv_ibfk_1` FOREIGN KEY (`idDepartamento`) REFERENCES `departamento` (`idDepartamento`) ON DELETE CASCADE;

--
-- Filtros para la tabla `impuestorenta`
--
ALTER TABLE `impuestorenta`
  ADD CONSTRAINT `impuestorenta_ibfk_1` FOREIGN KEY (`idDepartamento`) REFERENCES `departamento` (`idDepartamento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tributoaduanas`
--
ALTER TABLE `tributoaduanas`
  ADD CONSTRAINT `tributoaduanas_ibfk_1` FOREIGN KEY (`idDepartamento`) REFERENCES `departamento` (`idDepartamento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tributointerno`
--
ALTER TABLE `tributointerno`
  ADD CONSTRAINT `tributointerno_ibfk_1` FOREIGN KEY (`idDepartamento`) REFERENCES `departamento` (`idDepartamento`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
