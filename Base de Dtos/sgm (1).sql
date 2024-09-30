-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3307
-- Tiempo de generación: 15-07-2024 a las 17:14:33
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sgm`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `prcAlumnoDelete` (`in_id_alumno` CHAR(15))   BEGIN
DELETE FROM alumno where id_alumno=in_id_alumno;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcAlumnoInsert` (IN `alu_nombres` VARCHAR(45), IN `alu_apellidos` VARCHAR(45), IN `alu_dni` INT(11), IN `alu_telefono` INT(11), IN `alu_direccion` VARCHAR(45), OUT `out_id` CHAR(15))   BEGIN
  SET out_id = (
    SELECT CONCAT('ALU-', SUBSTR(CONCAT('00000', (SUBSTR(COALESCE(MAX(id_alumno),0),5,5)+1)),-5)) FROM alumno
  );
  
  INSERT INTO alumno (id_alumno, alu_nombres, alu_apellidos, alu_dni, alu_telefono, alu_direccion) 
  VALUES (out_id, alu_nombres, alu_apellidos, alu_dni, alu_telefono, alu_direccion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcAlumnoSelectAll` ()   BEGIN

SELECT* FROM alumno;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcAlumnoSelectByCodigo` (IN `in_id_alumno` CHAR(15))   BEGIN
  SELECT * FROM alumno WHERE id_alumno = in_id_alumno;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcAlumnoUpdate` (IN `in_id_alumno` CHAR(15), IN `in_alu_nombres` VARCHAR(45), IN `in_alu_apellidos` VARCHAR(45), IN `in_alu_dni` INT(11), IN `in_alu_telefono` INT(11), IN `in_alu_direccion` VARCHAR(45))   BEGIN
  UPDATE alumno 
  SET alu_nombres = in_alu_nombres, 
      alu_apellidos = in_alu_apellidos, 
      alu_dni = in_alu_dni, 
      alu_telefono = in_alu_telefono, 
      alu_direccion = in_alu_direccion   
  WHERE id_alumno = in_id_alumno;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcAulaDelete` (IN `in_id_aula` CHAR(15))   BEGIN
DELETE FROM aula where 
id_aula=in_id_aula;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcAulaInsert` (IN `aul_descri` CHAR(45), IN `aul_estcod` INT(11), OUT `out_id` CHAR(15))   BEGIN
    SET out_id = (
        SELECT CONCAT('AUL-', SUBSTR(CONCAT('00000', (SUBSTR(COALESCE(MAX(id_aula),0),5,3)+1)),-3)) from aula
    );
    
    INSERT INTO aula (id_aula, aul_descri, aul_estcod) 
    VALUES (out_id, aul_descri, aul_estcod);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcAulaSelectAll` ()   BEGIN

SELECT* FROM aula;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcAulaSelectByCodigo` (`in_id_aula` CHAR(15))   BEGIN
SELECT * FROM  aula where id_aula=in_id_aula;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcAulaUpdate` (`in_id_aula` CHAR(15), `in_aul_descri` VARCHAR(45), `in_aul_estcod` INT(11))   BEGIN
UPDATE aula SET aul_descri=in_aul_descri, aul_estcod=in_aul_estcod  WHERE id_aula=in_id_aula;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcCursoDelete` (IN `in_id_curso` CHAR(15))   BEGIN
DELETE FROM curso where id_curso=in_id_curso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcCursoInsert` (IN `nombre_curso` VARCHAR(70), IN `descripcion_curso` VARCHAR(70), IN `estado_curso` INT(50), OUT `out_id` CHAR(15))   BEGIN
 SET out_id= (
    SELECT CONCAT('CUR-', SUBSTR(CONCAT('000', (SUBSTR(COALESCE(MAX(id_curso),0),5,3)+1)),-3)) from curso);
    
INSERT INTO curso
(id_curso, nombre_curso, descripcion_curso, estado_curso) 
values (out_id, nombre_curso, descripcion_curso, estado_curso );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcCursoSelectAll` ()   BEGIN

SELECT * FROM  curso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcCursoSelectByCodigo` (IN `in_id_curso` CHAR(7))   BEGIN
SELECT * FROM  curso where id_curso=in_id_curso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcCursosPorMatricula` (IN `matricula_id` VARCHAR(50))   BEGIN
    SELECT c.*
    FROM curso c
    INNER JOIN notas n ON c.id_curso = n.id_curso
    INNER JOIN matricula m ON n.id_matricula = m.id_matricula
    WHERE m.id_matricula = matricula_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcCursoUpdate` (`in_id_curso` CHAR(7), `in_nombre_curso` VARCHAR(70), `in_descripcion_curso` VARCHAR(70), `in_estado_curso` INT(50))   BEGIN
UPDATE  curso SET nombre_curso =in_nombre_curso, descripcion_curso=in_descripcion_curso, estado_curso=in_estado_curso  WHERE id_curso=in_id_curso;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcCurso_x_seccionDelete` (IN `cur_codigo` CHAR(7))   BEGIN
DELETE FROM curso_x_seccion where cur_codigo=cur_codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcCurso_x_seccionSelectAll` ()   BEGIN
SELECT * FROM curso_x_seccion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcCurso_x_seccionSelectByCodigo` (IN `cur_codigo` CHAR(7))   BEGIN
Select * from curso_x_seccion where cur_codigo=cur_codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcCurso_x_seccionUpdate` (IN `cur_codigo` CHAR(7), IN `id_seccion` CHAR(7), IN `id_aula` CHAR(7), IN `id_docente` CHAR(15), IN `estado` INT(11))   BEGIN
UPDATE  curso_x_seccion SET  id_seccion=id_seccion, id_aula =id_aula ,
 id_docente= id_docente, estado =estado WHERE cur_codigo=cur_codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcCurso_x_seccion_Insert` (IN `cur_codigo` CHAR(7), IN `id_seccion` CHAR(7), IN `id_aula` CHAR(7), IN `id_docente` CHAR(15), IN `estado` INT(11))   BEGIN
INSERT INTO curso_x_seccion(cur_codigo,id_seccion, id_aula, id_docente, estado) values (cur_codigo, id_seccion, id_aula, id_docente, estado); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcDocenteDelete` (IN `in_id_docente` CHAR(15))   BEGIN
  DELETE FROM docente WHERE id_docente = in_id_docente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcDocenteInsert` (IN `doc_descri` VARCHAR(45), IN `doc_estcod` INT(11), IN `doc_nombre` VARCHAR(45), IN `doc_apellido` VARCHAR(45), IN `doc_dni` INT(11), IN `doc_telefono` INT(11), OUT `out_id` CHAR(15))   BEGIN
 SET out_id= (
    SELECT CONCAT('MAT-', SUBSTR(CONCAT('000000', (SUBSTR(COALESCE(MAX(id_docente),0),5,5)+1)),-5)) from docente);
    
INSERT INTO docente(id_docente, doc_descri ,doc_estcod, doc_nombre, doc_apellido, doc_dni, doc_telefono) values (out_id, doc_descri ,doc_estcod, doc_nombre, doc_apellido, doc_dni, doc_telefono); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcDocenteSelectAll` ()   BEGIN
SELECT * FROM docente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcDocenteSelectByCodigo` (IN `in_id_docente` CHAR(15))   BEGIN
  SELECT * FROM docente WHERE id_docente = in_id_docente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcDocenteUpdate` (IN `in_id_docente` CHAR(15), IN `in_doc_descri` VARCHAR(45), IN `in_doc_estcod` INT(11), IN `in_doc_nombre` VARCHAR(45), IN `in_doc_apellido` VARCHAR(45), IN `in_doc_dni` INT(11), IN `in_doc_telefono` INT(11))   BEGIN
  UPDATE docente
  SET doc_descri = in_doc_descri,
      doc_estcod = in_doc_estcod,
      doc_nombre = in_doc_nombre,
      doc_apellido = in_doc_apellido,
      doc_dni = in_doc_dni,
      doc_telefono = in_doc_telefono
  WHERE id_docente = in_id_docente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcMatriculaDelete` (IN `in_id_matricula` CHAR(21))   BEGIN
  DELETE FROM matricula WHERE id_matricula = in_id_matricula;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcMatriculaInsert` (IN `id_alumno` CHAR(15), IN `id_seccion` CHAR(15), IN `matricula_fecha_ingreso` DATETIME, IN `matricula_estado` INT(11), OUT `out_id` CHAR(21))   BEGIN
 SET out_id= (
    SELECT CONCAT('MAT-', SUBSTR(CONCAT('000000', (SUBSTR(COALESCE(MAX(id_matricula),0),5,5)+1)),-5)) from matricula);
    
INSERT INTO matricula(id_matricula, id_alumno , id_seccion, matricula_fecha_ingreso, matricula_estado) values (out_id, id_alumno , id_seccion, matricula_fecha_ingreso, matricula_estado); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcMatriculaSelectAll` ()   BEGIN
SELECT * FROM matricula;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcMatriculaUpdate` (IN `in_id_matricula` CHAR(21), IN `in_id_alumno` CHAR(15), IN `in_id_seccion` CHAR(7), IN `in_matricula_fecha_ingreso` DATETIME, IN `in_matricula_estado` INT(11))   BEGIN
  UPDATE matricula SET
    id_alumno = in_id_alumno,
    id_seccion = in_id_seccion,
    matricula_fecha_ingreso = in_matricula_fecha_ingreso,
    matricula_estado = in_matricula_estado
  WHERE id_matricula = in_id_matricula;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcMostrarMatriculados` ()   BEGIN
select alu_nombres, alu_apellidos,  alu_dni, matricula_fecha_ingreso, matricula_estado,sec_descri,id_matricula,alumno.id_alumno    from
 matricula inner join alumno on matricula.id_alumno=alumno.id_alumno inner join seccion on matricula.id_seccion=seccion.id_seccion;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcNivelDelete` (IN `in_id_nivel` CHAR(7))   BEGIN
DELETE FROM nivel where id_nivel=in_id_nivel;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcNivelInsert` (IN `in_niv_estcod` INT(11), IN `in_niv_descri` VARCHAR(45), OUT `out_id` CHAR(7))   BEGIN
 SET out_id= (
    SELECT CONCAT('NIV-', SUBSTR(CONCAT('00000', (SUBSTR(COALESCE(MAX(id_nivel),0),5,3)+1)),-3)) from nivel);
    
INSERT INTO nivel
(id_nivel, niv_descri , niv_estcod) 
values (out_id, in_niv_descri, in_niv_estcod);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcNivelSelectAll` ()   BEGIN

SELECT * FROM  nivel;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcNivelSelectByCodigo` (IN `in_id_nivel` CHAR(7))   BEGIN
SELECT * FROM  nivel where id_nivel=in_id_nivel;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcNivelUpdate` (IN `in_id_nivel` CHAR(7), IN `in_niv_descri` VARCHAR(45), IN `in_niv_estcod` INT(11))   BEGIN
UPDATE  nivel SET  niv_descri=in_niv_descri, niv_estcod=in_niv_estcod  WHERE id_nivel=in_id_nivel;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcNotasDelete` (IN `in_id_notas` CHAR(21))   BEGIN
  DELETE FROM notas WHERE id_notas = in_id_notas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcNotasInsert` (IN `in_id_matricula` CHAR(21), IN `in_id_curso` CHAR(7), IN `in_not_observ` VARCHAR(200), IN `in_not_valor` DECIMAL(8,2), IN `in_not_estcod` INT(11))   BEGIN
  DECLARE out_id_notas CHAR(21);
  SET out_id_notas = (
    SELECT CONCAT('NOT-', SUBSTR(CONCAT('00000', (SUBSTR(COALESCE(MAX(id_notas),0),5,5)+1)),-5)) FROM notas
  );
  
  INSERT INTO notas (id_notas, id_matricula, id_curso, not_observ, not_valor, not_estcod)
  VALUES (out_id_notas, in_id_matricula, in_id_curso, in_not_observ, in_not_valor, in_not_estcod);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcNotasMostrarNotas` ()   BEGIN
select id_notas, matricula.id_matricula, descripcion_curso, not_observ, not_valor, 
not_estcod from notas inner join matricula on notas.id_matricula=matricula.id_matricula 
inner join curso on notas.id_curso=curso.id_curso;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcNotasSelectAll` ()   BEGIN
SELECT * FROM notas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcNotasSelectByCodigo` (IN `in_id_notas` CHAR(21))   BEGIN
    SELECT id_notas, matricula.id_matricula, descripcion_curso, not_observ, not_valor, not_estcod
    FROM notas
    INNER JOIN matricula ON notas.id_matricula = matricula.id_matricula
    INNER JOIN curso ON notas.id_curso = curso.id_curso
    WHERE id_notas = in_id_notas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcNotasSelectByMatricula` (IN `matricula_id` VARCHAR(50))   BEGIN
    SELECT * FROM notas WHERE id_matricula = matricula_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcNotasUpdate` (IN `in_id_notas` CHAR(21), IN `in_id_matricula` CHAR(21), IN `in_id_curso` CHAR(7), IN `in_not_observ` VARCHAR(200), IN `in_not_valor` DECIMAL(8,2), IN `in_not_estcod` INT(11))   BEGIN
  UPDATE notas SET
    id_matricula = in_id_matricula,
    id_curso = in_id_curso,
    not_observ = in_not_observ,
    not_valor = in_not_valor,
    not_estcod= in_not_estcod
  WHERE id_notas = in_id_notas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcPensionDelete` (IN `in_id_pension` CHAR(21))   BEGIN
  DELETE FROM pensiones WHERE id_pension = in_id_pension;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcPensionInsert` (IN `in_id_matricula` CHAR(21), IN `in_id_alumno` CHAR(15), IN `in_pension_mes` VARCHAR(20), IN `in_pension_monto` DECIMAL(8,3), IN `in_pension_descuento` DECIMAL(8,3), IN `in_pension_mora` DECIMAL(8,3), IN `in_pension_fecha_registro` DATETIME, IN `in_pension_fecha_vencimiento` DATETIME, IN `in_estado` INT(11))   BEGIN
  DECLARE out_id_pension CHAR(21);
  SET out_id_pension = (
    SELECT CONCAT('PEN-', SUBSTR(CONCAT('00000', (SUBSTR(COALESCE(MAX(id_pension),0),5,5)+1)),-5)) FROM pensiones
  );
  
  INSERT INTO pensiones (id_pension, id_matricula, id_alumno, pension_mes, pension_monto, pension_descuento,pension_mora,pension_fecha_registro,pension_fecha_vencimiento,estado)
  VALUES (out_id_pension, in_id_matricula, in_id_alumno, in_pension_mes, in_pension_monto, in_pension_descuento,in_pension_mora,in_pension_fecha_registro,in_pension_fecha_vencimiento,in_estado);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcPensionSelectAll` ()   BEGIN
select id_pension, matricula.id_matricula,alumno.id_alumno,pension_mes, pension_monto, pension_descuento,pension_mora,pension_fecha_registro,pension_fecha_vencimiento,estado 
from pensiones inner join matricula on pensiones.id_matricula=matricula.id_matricula 
inner join alumno on pensiones.id_alumno=alumno.id_alumno;

 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcPensionSelectByCodigo` (IN `in_id_pension` CHAR(21))   BEGIN
    SELECT
        m.id_pension,
        m.id_matricula,
        m.pension_mes,
m.pension_monto, m.pension_descuento,m.pension_mora,m.pension_fecha_registro,m.pension_fecha_vencimiento,m.estado,
        a.id_alumno,
        s.id_matricula
    FROM
        pensiones m
        INNER JOIN alumno a ON m.id_alumno = a.id_alumno
        INNER JOIN matricula s ON m.id_matricula = s.id_matricula
    WHERE
        m.id_pension = in_id_pension;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcPensionUpdate` (IN `in_id_pension` CHAR(21), IN `in_id_matricula` CHAR(21), IN `in_id_alumno` CHAR(15), IN `in_pension_mes` CHAR(2), IN `in_pension_monto` DECIMAL(8,3), IN `in_pension_descuento` DECIMAL(8,3), IN `in_pension_mora` DECIMAL(8,3), IN `in_pension_fecha_registro` DATETIME, IN `in_pension_fecha_vencimiento` DATETIME, IN `in_estado` INT(11))   BEGIN
  UPDATE pensiones SET
    id_matricula = in_id_matricula,
    id_alumno= in_id_alumno,
    pension_mes= in_pension_mes,
    pension_monto= in_pension_monto,
    pension_descuento=in_pension_descuento,
  pension_mora = in_pension_mora,
  pension_fecha_registro = in_pension_fecha_registro,
pension_fecha_vencimiento= in_pension_fecha_vencimiento,
estado = in_estado

  WHERE id_pension = in_id_pension;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcSeccionDelete` (IN `in_id_seccion` CHAR(7))   BEGIN
DELETE FROM seccion where id_seccion=in_id_seccion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcSeccionInsert` (IN `sec_descri` VARCHAR(45), IN `sec_estcod` INT(11), IN `id_aula` CHAR(7), IN `id_nivel` CHAR(7), OUT `out_id` CHAR(7))   BEGIN
  SET out_id = (
    SELECT CONCAT('SEC-', SUBSTR(CONCAT('000', (SUBSTR(COALESCE(MAX(id_seccion),0),5,3)+1)),-3)) FROM seccion
  );
  
  INSERT INTO seccion (id_seccion, sec_descri, sec_estcod, id_aula, id_nivel) 
               VALUES (out_id, sec_descri,  sec_estcod, id_aula,  id_nivel);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcSeccionSelectAll` ()   BEGIN

SELECT * FROM  seccion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcSeccionSelectByCodigo` (IN `in_id_seccion` CHAR(7))   BEGIN
SELECT * FROM  seccion where id_seccion=in_id_seccion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcSeccionUpdate` (IN `in_id_seccion` CHAR(7), IN `in_sec_descri` VARCHAR(45), IN `in_sec_estcod` INT(11), IN `in_id_aula` CHAR(7), IN `in_id_nivel` CHAR(7))   BEGIN
UPDATE  seccion SET sec_descri=in_sec_descri, sec_estcod=in_sec_estcod, id_aula=in_id_aula, id_nivel=in_id_nivel  WHERE id_seccion=in_id_seccion;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcSelectCursoSeccionDocenteAula_all` ()   BEGIN
select cur_codigo, nombre_curso, sec_descri, aul_descri, doc_nombre,id_nivel, estado from curso_x_seccion inner join curso on curso_x_seccion.cur_codigo=curso.id_curso inner join 
seccion on curso_x_seccion.id_seccion=seccion.id_seccion inner join aula on  curso_x_seccion.id_aula=aula.id_aula  inner join docente on curso_x_seccion.id_docente=docente.id_docente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prcUsuarioValidar` (IN `in_codigo_usuario` VARCHAR(11), IN `in_contrasena_usuario` VARCHAR(45))   BEGIN
SELECT * FROM usuario where codigo_usuario=in_codigo_usuario and contrasena_usuario=in_contrasena_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spaluxsexo` (IN `inicio` VARCHAR(10), IN `fin` VARCHAR(10))   BEGIN
    SELECT alu_sexo AS Sexo,
           COUNT(*) AS Total_Alumnos
    FROM alumno
    WHERE id_alumno BETWEEN inicio AND fin
    GROUP BY alu_sexo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spmatmes` (IN `anio_consulta` YEAR)   BEGIN
    SELECT MONTH(matfecha_ingreso) AS Mes,
           COUNT(*) AS Total_Matriculas
    FROM matricula
    WHERE YEAR(matfecha_ingreso) = anio_consulta
    GROUP BY MONTH(matfecha_ingreso)
    ORDER BY Mes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spsecaulas` (IN `rango_inicio` CHAR(7), IN `rango_fin` CHAR(7))   BEGIN
    SELECT id_aula, COUNT(*) AS cantidad_secciones
    FROM seccion
    WHERE id_seccion BETWEEN rango_inicio AND rango_fin
    AND (id_aula = 'AUL-000' OR id_aula = 'AUL-001')
    GROUP BY id_aula;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `id_alumno` char(15) NOT NULL,
  `alu_nombres` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `alu_apellidos` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `alu_dni` int(11) DEFAULT NULL,
  `alu_telefono` int(11) NOT NULL,
  `alu_sexo` varchar(10) NOT NULL,
  `alu_direccion` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`id_alumno`, `alu_nombres`, `alu_apellidos`, `alu_dni`, `alu_telefono`, `alu_sexo`, `alu_direccion`) VALUES
('ALU-00001', 'JHONATAN', 'MORALES', 61046365, 98765412, 'S', 'smp'),
('ALU-00002', 'ALVARO', 'CONTRERAS', 61904782, 99123123, 'M', 'los olivos'),
('ALU-00003', 'LUIS', 'QUEVEDO', 6104823, 987654523, 'M', 'sjl'),
('ALU-00004', 'MATEO', 'GALINDO', 61042364, 987675321, 'M', 'av metropolitana mz'),
('ALU-00005', 'ANTONIO', 'MENDEZ', 89562312, 989256145, 'M', 'los olivos'),
('ALU-00006', 'Carlos Eduardo', 'Garcia Ruiz', 61047896, 987654322, 'M', 'av brasil 5678'),
('ALU-00007', 'Mariana', 'Fernandez Soto', 61048974, 987654323, 'M', 'jr tacna 9123'),
('ALU-00008', 'Jose Luis', 'Diaz Chavez', 61049561, 987654324, 'M', 'av colonial 4567'),
('ALU-00009', 'Rosa Elena', 'Sanchez Torres', 61040782, 987654325, 'M', 'av universitaria 6789'),
('ALU-00010', 'Pedro', 'Alvarez Quispe', 61043067, 987654326, 'M', 'jr sucre 1234'),
('ALU-00011', 'Lucia', 'Gomez Salazar', 61044093, 987654327, 'M', 'av venezuela 5678'),
('ALU-00012', 'Diego', 'Mendoza Vargas', 61045672, 987654328, 'M', 'av peru 9123'),
('ALU-00013', 'Sofia', 'Ramos Guevara', 61046731, 987654329, 'M', 'jr independencia 4567'),
('ALU-00014', 'Alberto', 'Rojas Ramirez', 61047259, 987654330, 'M', 'av la marina 6789'),
('ALU-00015', 'Teresa', 'Martinez Salas', 61048360, 987654331, 'M', 'av salaverry 1234'),
('ALU-00016', 'Ricardo', 'Castillo Torres', 61049327, 987654332, 'M', 'av pardo 5678'),
('ALU-00017', 'Gabriela', 'Herrera Flores', 61049845, 987654333, 'M', 'jr libertad 9123'),
('ALU-00018', 'Sandra', 'Cruz Lopez', 61040567, 987654334, 'M', 'av argentina 7890'),
('ALU-00019', 'Miguel', 'Gutierrez Valdez', 61041678, 987654335, 'M', 'av aviacion 1234'),
('ALU-00020', 'Pablo', 'Ortega Torres', 61042789, 987654336, 'M', 'jr union 5678'),
('ALU-00021', 'Claudia', 'Castro Romero', 61043890, 987654337, 'M', 'av tarapaca 9123'),
('ALU-00022', 'Fernando', 'Vega Morales', 61044901, 987654338, 'M', 'av arenales 4567');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aula`
--

CREATE TABLE `aula` (
  `id_aula` char(7) NOT NULL,
  `aul_descri` varchar(45) DEFAULT NULL,
  `aul_estcod` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aula`
--

INSERT INTO `aula` (`id_aula`, `aul_descri`, `aul_estcod`) VALUES
('AUL-000', 'AULA NAVI', 0),
('AUL-001', 'AULA AMARILLO', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `id_curso` char(7) NOT NULL,
  `nombre_curso` varchar(70) DEFAULT NULL,
  `descripcion_curso` varchar(70) DEFAULT NULL,
  `estado_curso` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`id_curso`, `nombre_curso`, `descripcion_curso`, `estado_curso`) VALUES
('CUR-001', 'ALGEBRA I', 'NUMEROS', 1),
('CUR-002', 'TRIGONOMETRIA', 'Matematicas', 0),
('CUR-003', 'EDU. FISICA', 'FUTBOL', 1),
('CUR-004', 'FISICA', 'Programacion ', 1),
('CUR-005', 'Calculo I', 'curso que estudia los limites', 0),
('CUR-006', 'Fisica I', 'curso que estudia la mecanica', 0),
('CUR-007', 'Quimica General', 'curso que estudia la materia', 1),
('CUR-008', 'Biologia General', 'curso que estudia la vida', 1),
('CUR-009', 'Algoritmos I', 'curso que estudia algoritmos', 0),
('CUR-010', 'Estadistica', 'curso que estudia datos', 1),
('CUR-011', 'Ingles I', 'curso de ingles basico', 1),
('CUR-012', 'Historia del Peru', 'curso de historia nacional', 1),
('CUR-013', 'Geometria', 'curso que estudia formas', 0),
('CUR-014', 'Aritmética', 'curso de arimetica', 1),
('CUR-015', 'Lenguaje', 'curso de lenguaje', 1),
('CUR-016', 'Psicologia', 'curso de psicologia', 0),
('CUR-017', 'Derecho', 'curso de derecho', 0),
('CUR-018', 'Matemáticas', 'Curso de matemáticas básicas', 1),
('CUR-019', 'Ciencias Naturales', 'Curso de ciencias básicas', 1),
('CUR-020', 'Historia', 'Curso de historia general', 1),
('CUR-021', 'Geografía', 'Curso de geografía general', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso_x_seccion`
--

CREATE TABLE `curso_x_seccion` (
  `cur_codigo` char(7) NOT NULL,
  `id_seccion` char(7) NOT NULL,
  `id_aula` char(7) NOT NULL,
  `id_docente` char(15) NOT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `curso_x_seccion`
--

INSERT INTO `curso_x_seccion` (`cur_codigo`, `id_seccion`, `id_aula`, `id_docente`, `estado`) VALUES
('CUR-001', 'SEC-000', 'AUL-000', 'MAT-00001', 1),
('CUR-002', 'SEC-000', 'AUL-000', 'MAT-00001', 1),
('CUR-003', 'SEC-005', 'AUL-001', 'MAT-00002', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente`
--

CREATE TABLE `docente` (
  `id_docente` char(15) NOT NULL,
  `doc_descri` varchar(45) DEFAULT NULL,
  `doc_estcod` int(11) DEFAULT NULL,
  `doc_nombre` varchar(45) NOT NULL,
  `doc_apellido` varchar(45) NOT NULL,
  `doc_dni` int(11) NOT NULL,
  `doc_telefono` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `docente`
--

INSERT INTO `docente` (`id_docente`, `doc_descri`, `doc_estcod`, `doc_nombre`, `doc_apellido`, `doc_dni`, `doc_telefono`) VALUES
('MAT-00001', 'Docente de Educacion', 1, 'Jhonatan Morales', 'Galvez', 1231245, 981823412),
('MAT-00002', 'DOCENTE TALLER', 1, 'KARLO', 'MENDEZ', 7859654, 989252858);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matricula`
--

CREATE TABLE `matricula` (
  `id_matricula` char(21) NOT NULL,
  `id_alumno` char(15) NOT NULL,
  `id_seccion` char(7) NOT NULL,
  `matricula_fecha_ingreso` datetime DEFAULT NULL,
  `matricula_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `matricula`
--

INSERT INTO `matricula` (`id_matricula`, `id_alumno`, `id_seccion`, `matricula_fecha_ingreso`, `matricula_estado`) VALUES
('MAT-00001', 'ALU-00001', 'SEC-000', '2023-07-16 00:00:00', 1),
('MAT-00002', 'ALU-00003', 'SEC-000', '2023-07-19 00:00:00', 1),
('MAT-00003', 'ALU-00004', 'SEC-002', '2018-09-08 00:00:00', 1),
('MAT-00004', 'ALU-00005', 'SEC-001', '2018-09-09 00:00:00', 1),
('MAT-00005', 'ALU-00002', 'SEC-001', '2024-09-08 00:00:00', 1),
('MAT-00006', 'ALU-00006', 'SEC-006', '2023-03-25 03:21:27', 1),
('MAT-00007', 'ALU-00007', 'SEC-007', '2022-07-30 03:21:27', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivel`
--

CREATE TABLE `nivel` (
  `id_nivel` char(7) NOT NULL,
  `niv_descri` varchar(45) DEFAULT NULL,
  `niv_estcod` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `nivel`
--

INSERT INTO `nivel` (`id_nivel`, `niv_descri`, `niv_estcod`) VALUES
('NIV-000', 'INICIAL', 0),
('NIV-001', 'PRIMARIA', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas`
--

CREATE TABLE `notas` (
  `id_notas` char(21) NOT NULL,
  `id_matricula` char(21) NOT NULL,
  `id_curso` char(7) NOT NULL,
  `not_observ` varchar(200) DEFAULT NULL,
  `not_valor` decimal(8,2) DEFAULT NULL,
  `not_estcod` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notas`
--

INSERT INTO `notas` (`id_notas`, `id_matricula`, `id_curso`, `not_observ`, `not_valor`, `not_estcod`) VALUES
('NOT-00001', 'MAT-00001', 'CUR-001', 'DESAPROBADO', 10.00, 1),
('NOT-00002', 'MAT-00006', 'CUR-006', 'APROBADO', 19.00, 1),
('NOT-00003', 'MAT-00001', 'CUR-001', 'DESAPROBADO', 5.00, 1),
('NOT-00004', 'MAT-00002', 'CUR-002', 'DESAPROBADO', 10.00, 1),
('NOT-00005', 'MAT-00007', 'CUR-007', 'DESAPROBADO', 11.00, 1),
('NOT-0003', 'MAT-00005', 'CUR-004', 'APROBADO', 18.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pensiones`
--

CREATE TABLE `pensiones` (
  `id_pension` char(21) NOT NULL,
  `id_matricula` char(21) NOT NULL,
  `id_alumno` char(15) NOT NULL,
  `pension_mes` varchar(20) DEFAULT NULL,
  `pension_monto` decimal(8,3) DEFAULT NULL,
  `pension_descuento` decimal(8,3) DEFAULT NULL,
  `pension_mora` decimal(8,3) DEFAULT NULL,
  `pension_fecha_registro` datetime DEFAULT NULL,
  `pension_fecha_vencimiento` datetime DEFAULT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pensiones`
--

INSERT INTO `pensiones` (`id_pension`, `id_matricula`, `id_alumno`, `pension_mes`, `pension_monto`, `pension_descuento`, `pension_mora`, `pension_fecha_registro`, `pension_fecha_vencimiento`, `estado`) VALUES
('PEN-00001', 'MAT-00001', 'ALU-00001', '0', 250.000, 0.000, 0.000, '2023-07-22 00:00:00', '2023-07-30 00:00:00', 0),
('PEN-00002', 'MAT-00001', 'ALU-00001', '0', 250.000, 0.000, 0.000, '2023-07-22 00:00:00', '2023-07-30 00:00:00', 0),
('PEN-00003', 'MAT-00001', 'ALU-00001', 'Enero', 250.000, 0.000, 0.000, '2023-07-22 00:00:00', '2023-07-30 00:00:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` char(7) NOT NULL,
  `rol_nombre` varchar(45) NOT NULL,
  `rol_descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seccion`
--

CREATE TABLE `seccion` (
  `id_seccion` char(7) NOT NULL,
  `sec_descri` varchar(45) DEFAULT NULL,
  `sec_estcod` int(11) DEFAULT NULL,
  `id_aula` char(7) NOT NULL,
  `id_nivel` char(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `seccion`
--

INSERT INTO `seccion` (`id_seccion`, `sec_descri`, `sec_estcod`, `id_aula`, `id_nivel`) VALUES
('SEC-000', 'Seccion AS', 1, 'AUL-001', 'NIV-001'),
('SEC-001', 'Seccion B', 1, 'AUL-000', 'NIV-000'),
('SEC-002', 'seccion AbcS', 1, 'AUL-001', 'NIV-001'),
('SEC-005', 'Seccion E', 1, 'AUL-000', 'NIV-000'),
('SEC-006', 'Seccion F', 1, 'AUL-000', 'NIV-000'),
('SEC-007', 'Seccion G', 1, 'AUL-000', 'NIV-000'),
('SEC-008', 'Seccion H', 1, 'AUL-001', 'NIV-001'),
('SEC-009', 'Seccion I', 1, 'AUL-001', 'NIV-001'),
('SEC-010', 'Seccion J', 1, 'AUL-000', 'NIV-000'),
('SEC-011', 'Seccion K', 1, 'AUL-001', 'NIV-001'),
('SEC-012', 'Seccion L', 1, 'AUL-000', 'NIV-000'),
('SEC-013', 'Seccion M', 1, 'AUL-001', 'NIV-001'),
('SEC-014', 'Seccion N', 1, 'AUL-000', 'NIV-000'),
('SEC-015', 'Seccion O', 1, 'AUL-001', 'NIV-001'),
('SEC-016', 'Seccion P', 1, 'AUL-001', 'NIV-001'),
('SEC-017', 'Seccion Q', 1, 'AUL-000', 'NIV-000'),
('SEC-018', 'Seccion R', 1, 'AUL-001', 'NIV-001'),
('SEC-019', 'Seccion S', 1, 'AUL-000', 'NIV-000'),
('SEC-020', 'Seccion T', 1, 'AUL-001', 'NIV-001');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` char(11) NOT NULL,
  `codigo_usuario` varchar(45) NOT NULL,
  `id_docente` char(15) NOT NULL,
  `tipo_usuario` varchar(11) NOT NULL,
  `estado` int(15) NOT NULL,
  `contrasena_usuario` varchar(45) NOT NULL,
  `id_rol` char(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `codigo_usuario`, `id_docente`, `tipo_usuario`, `estado`, `contrasena_usuario`, `id_rol`) VALUES
('0001', 'admin123', '01023123', 'admin', 1, 'admin123', '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`id_alumno`);

--
-- Indices de la tabla `aula`
--
ALTER TABLE `aula`
  ADD PRIMARY KEY (`id_aula`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id_curso`);

--
-- Indices de la tabla `curso_x_seccion`
--
ALTER TABLE `curso_x_seccion`
  ADD PRIMARY KEY (`cur_codigo`),
  ADD KEY `sec_codigo` (`id_seccion`),
  ADD KEY `doc_codigo` (`id_docente`),
  ADD KEY `id_aula` (`id_aula`);

--
-- Indices de la tabla `docente`
--
ALTER TABLE `docente`
  ADD PRIMARY KEY (`id_docente`);

--
-- Indices de la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD PRIMARY KEY (`id_matricula`),
  ADD KEY `alu_codigo` (`id_alumno`),
  ADD KEY `sec_codigo` (`id_seccion`);

--
-- Indices de la tabla `nivel`
--
ALTER TABLE `nivel`
  ADD PRIMARY KEY (`id_nivel`);

--
-- Indices de la tabla `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`id_notas`),
  ADD KEY `mat_correlativo` (`id_matricula`),
  ADD KEY `cur_codigo` (`id_curso`);

--
-- Indices de la tabla `pensiones`
--
ALTER TABLE `pensiones`
  ADD PRIMARY KEY (`id_pension`),
  ADD KEY `id_matricula` (`id_matricula`),
  ADD KEY `id_alumno` (`id_alumno`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `seccion`
--
ALTER TABLE `seccion`
  ADD PRIMARY KEY (`id_seccion`),
  ADD KEY `aul_codigo` (`id_aula`),
  ADD KEY `id_nivel` (`id_nivel`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `id_docente` (`id_docente`),
  ADD KEY `roles_id_index` (`id_rol`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `curso_x_seccion`
--
ALTER TABLE `curso_x_seccion`
  ADD CONSTRAINT `curso_x_seccion_ibfk_1` FOREIGN KEY (`cur_codigo`) REFERENCES `curso` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `curso_x_seccion_ibfk_2` FOREIGN KEY (`id_seccion`) REFERENCES `seccion` (`id_seccion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `curso_x_seccion_ibfk_3` FOREIGN KEY (`id_docente`) REFERENCES `docente` (`id_docente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `curso_x_seccion_ibfk_4` FOREIGN KEY (`id_aula`) REFERENCES `aula` (`id_aula`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD CONSTRAINT `matricula_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `matricula_ibfk_2` FOREIGN KEY (`id_seccion`) REFERENCES `seccion` (`id_seccion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`id_matricula`) REFERENCES `matricula` (`id_matricula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `notas_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pensiones`
--
ALTER TABLE `pensiones`
  ADD CONSTRAINT `pensiones_ibfk_1` FOREIGN KEY (`id_matricula`) REFERENCES `matricula` (`id_matricula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `pensiones_ibfk_2` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `seccion`
--
ALTER TABLE `seccion`
  ADD CONSTRAINT `seccion_ibfk_1` FOREIGN KEY (`id_aula`) REFERENCES `aula` (`id_aula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `seccion_ibfk_2` FOREIGN KEY (`id_nivel`) REFERENCES `nivel` (`id_nivel`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
