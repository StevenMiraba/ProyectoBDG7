create database LMRTOURS;
use LMRTOURS;

create table proveedor(
	id_proveedor int auto_increment PRIMARY KEY NOT NULL,
    nombre varchar(15),
    ciudad varchar(30),
    pais varchar(15),
    telefono varchar(15),
    email varchar(30)
);

create table empleado(
	id_empleado int auto_increment PRIMARY KEY NOT NULL,
    nombre varchar(15),
    apellido varchar(15),
    usuario varchar(10) NOT NULL,
    clave varchar(12) NOT NULL,
	email varchar(35),
	telefono varchar(15),
	direccion varchar(50),
	esadministrador boolean,
	escontador boolean,
	esasesor boolean,
	id_supervisor int NOT NULL,
    id_proveedor int,
    FOREIGN KEY(id_supervisor) REFERENCES empleado(id_empleado),
    FOREIGN KEY(id_proveedor) REFERENCES proveedor(id_proveedor)
);

create table cliente(
	cedulaCliente char(10) PRIMARY KEY NOT NULL,
    nombre varchar(15),
    apellido varchar(15),
    email varchar(35),
    telefono varchar(15),
	edad int,
	fechaNacimiento date,
    ciudad varchar(35),
	sector varchar(35),
	calleYavenida varchar(50),
    visaSioNo boolean,
    id_empleado int,
    FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado)
);

create table paqueteturistico(
	id_paqueteturistico int auto_increment PRIMARY KEY NOT NULL,
    descripcion varchar(50),
    precio decimal(7,2),
    fechaInicio date,
    fechaFin date,
    id_empleado int,
    FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado)
);

create table reserva(
	id_reserva int auto_increment PRIMARY KEY NOT NULL,
    montoTotal decimal(7,2),
    valorPendiente decimal(7,2),
    mesesPlazo int NOT NULL,
    totalApagar decimal(7,2),
    estadoPago enum('PENDIENTE','COMPLETADO'),
    estado enum('CONFIRMADA','CANCELADA'),
    numPersonas int,
    fechaReserva date,
    id_paqueteturistico int,
    cedulaCliente char(10),
    FOREIGN KEY(id_paqueteturistico) REFERENCES paqueteturistico(id_paqueteturistico),
    FOREIGN KEY(cedulaCliente) REFERENCES cliente(cedulaCliente)
);

create table pago(
	id_pago int auto_increment PRIMARY KEY NOT NULL,
    totalPagado decimal(7.2),
    formaPago enum('TC','TD','TRANSFERENCIA'),
    fechaPago date,
    id_reserva int,
    cedulaCliente char(10),
    FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva),
	FOREIGN KEY (cedulaCliente) REFERENCES cliente(cedulaCliente)
);

create table boletoaereo(
	id_boleto int auto_increment PRIMARY KEY NOT NULL,
    numAsiento varchar(15),
    numVuelo varchar(15),
    clase enum('ECONOMICA','EJECUTIVA','PRIMERA'),
    aerolinea varchar(35),
    fechaSalida datetime,
    aeroSalida varchar(35),
    aeroLlegada varchar(35),
    id_reserva int,
    id_empleado int,
    FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva),
	FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    precio decimal(6,2)
);

create table destino(
	id_destino int auto_increment PRIMARY KEY NOT NULL,
    pais varchar(35),
    ciudad varchar(35),
    necesitaVisaSioNo boolean
);

create table servicio(
	id_servicio int auto_increment PRIMARY KEY NOT NULL,
    descripcion varchar(50),
    precio decimal(5.2),
    tipo enum('HOTELERIA','CATERING','MOVILIZACION','ALIMENTACION','TICKETING')
);

create table tiene(
	id_packDestino int auto_increment NOT NULL,
    id_paqueteturistico int,
    id_destino int,
    PRIMARY KEY(id_packDestino,id_paqueteturistico,id_destino),
    FOREIGN KEY (id_paqueteturistico) REFERENCES paqueteturistico(id_paqueteturistico),
    FOREIGN KEY (id_destino) REFERENCES destino(id_destino)
);

create table incluido(
	id_servicio int,
    id_paqueteturistico int,
    PRIMARY KEY(id_servicio,id_paqueteturistico),
    FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio),
    FOREIGN KEY (id_paqueteturistico) REFERENCES paqueteturistico(id_paqueteturistico)
);

create table ofrece(
	id_servicio int,
    id_proveedor int,
    PRIMARY KEY(id_servicio,id_proveedor),
    FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

INSERT INTO proveedor(id_proveedor,nombre,ciudad,pais,telefono,email) 
VALUES (1,'Julian','Quito','Ecuador','0998150383','juliangomez@gmail.com'),
(2,'Mariana','Lima','Perú','0987654321','marianalopez@example.com'),
 (3,'Carlos','Buenos Aires','Argentina','1234567890','carlosfuentes@example.com'), 
(4,'Laura','Santiago','Chile','9876543210','lauraramirez@example.com'), 
(5,'Pedro','Bogotá','Colombia','3216549870','pedromartinez@example.com'),
 (6,'Ángela','Ciudad de México','México','2135468790','angelamoreno@example.com'), 
(7,'Miguel','San José','Costa Rica','6549873210','miguelsanchez@example.com'), 
(8,'Sara','Montevideo','Uruguay','7890123456','sarafernandez@example.com'),
 (9,'Juan','Asunción','Paraguay','9012345678','juanperez@example.com'),
 (10,'Ana','La Paz','Bolivia','2345678901','analopez@example.com');

INSERT INTO empleado(id_empleado,nombre,apellido,usuario,clave,email,telefono,direccion,esadministrador,escontador,esasesor,id_supervisor) 
values (1,'Scarlet', 'Cevallos','scarCev','12345678','anamartinez@example.com','0987654321','Av. Siempre Viva 123, Quito',TRUE,FALSE,TRUE,1), 
(2,'Alvaro', 'Cabrera','alvaroCab','12345678','luisgomez@example.com','0987654322','Calle Falsa 456, Lima',FALSE,TRUE,FALSE,1), 
(3,'Paulo','Tapia','pauloTap','12345678','marialopez@example.com','0987654323','Av. de los Andes 789, Bogotá',TRUE,FALSE,FALSE,1),
(4,'Steven','Mirabá','stevenMir','12345678','carlosperez@example.com','0987654324','Calle del Sol 101, Buenos Aires',FALSE,TRUE,TRUE,1),
(5,'Lucía','Fernández','luciaFer','12345678','luciafernandez@example.com','0987654325','Av. Libertador 202, Santiago',FALSE,FALSE,TRUE,1),
(6,'Jorge','Ramírez','jorgeRam','12345678','jorgeramirez@example.com','0987654326','Calle Principal 303, Ciudad de México',TRUE,TRUE,FALSE,1),
(7,'Elena','Torres','elenaTor','12345678','elenatorres@example.com','0987654327','Av. Central 404, Montevideo',FALSE,TRUE,FALSE,1),
(8,'Diego','Morales','diegoMor','12345678','diegomorales@example.com','0987654328','Calle Secundaria 505, Asunción',TRUE,FALSE,TRUE,1),
(9,'Sofía','Castillo','sofiaCas','12345678','sofiacastillo@example.com','0987654329','Av. Los Pinos 606, La Paz',FALSE,TRUE,TRUE,1),
(10,'Andrés','Vargas','andresVar','12345678','andresvargas@example.com','0987654330','Calle del Sol 707, San José',TRUE,FALSE,FALSE,1);

INSERT INTO cliente(cedulaCliente,telefono,edad,fechaNacimiento,ciudad,sector,calleYavenida,nombre,visaSIoNo,email,apellido) 
values ('0102030405','0991234567',30,date('1993-05-12'),'Quito','Centro', 'Av. Amazonas 123', 'Juan', TRUE, 'juan@example.com', 'Pérez'), 
('0203040506','0997654321',25,date('1998-03-23'),'Guayaquil','Norte', 'Calle 1 456', 'María', FALSE, 'maria@example.com', 'Gómez'),
 ('0304050607','0987654321',35,date('1988-11-05'),'Cuenca','Sur', 'Av. Loja 789', 'Carlos', TRUE, 'carlos@example.com', 'Rodríguez'), 
('0405060708','0976543210',28,date('1995-07-19'),'Loja','Este', 'Calle Sucre 101', 'Ana', FALSE, 'ana@example.com', 'Martínez'), 
('0506070809','0965432109',40,date('1983-01-15'),'Manta','Oeste', 'Av. Malecón 202', 'Luis', TRUE, 'luis@example.com', 'Fernández'), 
('0607080910','0954321098',22,date('2001-02-27'),'Ambato','Centro', 'Calle Bolívar 303', 'Sofía', FALSE, 'sofia@example.com', 'Vega'), 
('0708091011','0943210987',29,date('1994-04-30'),'Riobamba','Norte', 'Av. León 404', 'Jorge', TRUE, 'jorge@example.com', 'Mendoza'), 
('0809101112','0932109876',33,date('1990-09-10'),'Ibarra','Sur', 'Calle Quito 505', 'Lucía', FALSE, 'lucia@example.com', 'Ruiz'), 
('0910111213','0921098765',27,date('1996-06-18'),'Esmeraldas','Este', 'Av. Olmedo 606', 'Fernando', TRUE, 'fernando@example.com', 'Ramos'), 
('1011121314','0910987654',31,date('1992-12-25'),'Santo Domingo','Oeste', 'Calle Colón 707', 'Daniela', FALSE, 'daniela@example.com', 'Chávez');

INSERT INTO paqueteturistico(id_paqueteturistico,descripcion,precio,fechaFin,fechaInicio) 
values (1, 'Tour por las principales atracciones de Quito', 500.00, '2024-08-15', '2024-08-10'),
(2, 'Aventura en la Amazonía ecuatoriana', 750.00, '2024-09-20', '2024-09-15'),
(3, 'Descubre la historia de Cuenca', 400.00, '2024-10-05', '2024-10-01'),
(4, 'Exploración cultural en la Sierra Central', 600.00, '2024-11-12', '2024-11-08'),
(5, 'Relax en las playas de Manta', 350.00, '2024-12-25', '2024-12-20'),
(6, 'Excursión a las Islas Galápagos', 1200.00, '2025-01-15', '2025-01-10'), 
(7, 'Tour por los mercados artesanales de Otavalo', 300.00, '2025-02-10', '2025-02-07'),
(8, 'Descubre las cascadas y paisajes de Baños', 450.00, '2025-03-18', '2025-03-15'),
(9, 'Visita histórica a Guayaquil', 550.00, '2025-04-22', '2025-04-18'),
(10, 'Aventura en los volcanes de los Andes', 800.00, '2025-05-30', '2025-05-25');

INSERT INTO reserva(id_reserva,montoTotal,estado,numPersonas,fechaReserva,id_paqueteturistico,cedulaCliente)
values (1, 1500.00, 'CONFIRMADA', 2, date('2024-07-10'),3,'0304050607'), 
(2, 2000.00,'CANCELADA', 4, date('2024-07-15'),5,'1011121314'),
 (3, 750.00,'CONFIRMADA', 1, date('2024-08-01'),1,'0102030405'), 
(4, 3000.00,'CANCELADA', 5, date('2024-08-10'),8,'0809101112'), 
(5, 1200.00,'CONFIRMADA', 3, date('2024-08-20'),9,'0203040506'),
 (6, 900.00,'CANCELADA', 2, date('2024-09-05'),2,'0708091011'), 
(7, 1800.00,'CONFIRMADA', 4, date('2024-09-15'),4,'0405060708'), 
(8, 2200.00,'CONFIRMADA', 6, date('2024-09-25'),10,'0910111213'), 
(9, 1600.00,'CONFIRMADA', 3, date('2024-10-05'),6,'0506070809'),
 (10, 2500.00,'CANCELADA', 5, date('2024-10-15'),7,'0607080910');

INSERT INTO pago(id_pago,estado,formaPago,total,fechaPago,id_reserva,cedulaCliente) 
values (1, 'Completado', 'TC', 500.00,date('2024-07-20'),3,'0506070809'),
(2, 'Pendiente', 'TRANSFERENCIA', 250.00, date('2024-08-01'),2,'1011121314'),
(3, 'Vencido', 'TD', 750.00, date('2024-08-15'),1,'0102030405'), 
(4, 'Pendiente', 'TC', 300.00,date('2024-09-10'),9,'0304050607'), 
(5, 'Completado', 'TC', 450.00,date('2024-09-25'),10,'0607080910'), 
(6, 'Vencido', 'TC', 400.00,date('2024-10-05'),6,'0809101112'), 
(7, 'Completado', 'TC', 600.00,date('2024-10-20'),4,'0203040506'), 
(8, 'Pendiente', 'TD', 350.00,date('2024-11-01'),7,'0405060708'), 	
(9, 'Vencido', 'TC', 800.00,date('2024-11-15'),8,'0708091011'), 
(10, 'Pendiente', 'TC', 500.00,date('2024-12-05'),5,'0910111213');

INSERT INTO boletoaereo(id_boleto,numAsiento,numVuelo,clase,aerolinea,precio,fechaSalida,aeroSalida,aerollegada,id_reserva,id_empleado) 
values (1,'A1', 'VU123', 'ECONOMICA', 'Avianca', 200.00,'2024-08-10 10:00:00', 'Quito', 'Guayaquil', 1, 1),
(2,'A2', 'VU123', 'ECONOMICA', 'Avianca',200.00, '2024-08-10 10:00:00', 'Quito', 'Guayaquil', 1, 2),
(3,'B1', 'VU456', 'EJECUTIVA', 'Latam', 500.00,'2024-08-15 12:00:00', 'Lima', 'Bogotá', 2, 3),
(4,'B2', 'VU456', 'EJECUTIVA', 'Latam', 500.00, '2024-08-15 12:00:00', 'Lima', 'Bogotá', 2, 4),
(5,'C1', 'VU789', 'PRIMERA', 'American Airlines', 1000.00,'2024-09-01 14:00:00', 'New York', 'Miami', 3, 5),
(6,'C2', 'VU789', 'PRIMERA', 'American Airlines', 1000.00,'2024-09-01 14:00:00', 'New York', 'Miami', 3, 6),
(7,'D1', 'VU101', 'ECONOMICA', 'Delta', 300.00,'2024-09-10 16:00:00', 'Atlanta', 'Orlando', 4, 7),
(8,'D2', 'VU101', 'ECONOMICA', 'Delta', 300.00,'2024-09-10 16:00:00', 'Atlanta', 'Orlando', 4, 8),
(9,'E1', 'VU202', 'EJECUTIVA', 'United', 600.00,'2024-09-20 18:00:00', 'Los Angeles', 'San Francisco', 5, 9),
(10,'E2', 'VU202', 'EJECUTIVA', 'United', 600.00,'2024-09-20 18:00:00', 'Los Angeles', 'San Francisco', 5, 10);

INSERT INTO destino(id_destino, pais, ciudad, necesitaVisaSioNo) 
values (1,'Ecuador', 'Quito', FALSE),
(2,'Perú', 'Lima', FALSE),
(3,'Argentina', 'Buenos Aires', FALSE),
(4,'Chile', 'Santiago', FALSE),
(5,'Colombia', 'Bogotá', FALSE),
(6,'México', 'Ciudad de México', TRUE),
(7,'Costa Rica', 'San José', FALSE),
(8,'Uruguay', 'Montevideo', FALSE),
(9,'Paraguay', 'Asunción', FALSE),
(10,'Bolivia', 'La Paz', FALSE);

INSERT INTO servicio(id_servicio,descripcion,precio,tipo) 
values(1,'Tour por la ciudad', 100.00,'MOVILIZACION'),
(2,'Transporte al aeropuerto', 50.00,'MOVILIZACION'),
(3,'Cena de bienvenida', 80.00,'CATERING'),
(4,'Alojamiento en hotel', 150.00,'HOTELERIA'),
(5,'Entradas a museos', 120.00,'TICKETING'),
(6,'Alojamiento en hotel', 200.00,'HOTELERIA'),
(7,'Almuerzo en restaurante', 300.00,'ALIMENTACION'),
(8,'Cena en restaurante', 40.00,'ALIMENTACION'),
(9,'Transporte terrestre', 70.00,'MOVILIZACION'),
(10,'Entradas a parque turistico', 60.00,'TICKETING');

INSERT INTO tiene(id_packDestino,id_paqueteturistico,id_destino) 
VALUES (1,1,9),
(2,2,4),
(3,3,2),
(4,4,1),
(5,5,8),
(6,6,7),
(7,7,6),
(8,8,10),
(9,9,3),
(10,10,5);

INSERT INTO incluido(id_servicio,id_paqueteturistico) 
VALUES (1, 10),
(2, 9),
(3, 8),
(4, 7),
(5, 6),
(6, 5),
(7, 4),
(8, 3),
(9, 2),
(10, 1);

INSERT INTO ofrece(id_servicio,id_proveedor) 
VALUES (1, 5),
(2, 4),
(3, 1),
(4, 2),
(5, 10),
(6, 7),
(7, 8),
(8, 3),
(9, 9),
(10,6);

-- TRIGGERS
-- 1) Este trigger asegurara que los clientes tengan al menos 18 años.
DELIMITER //
CREATE TRIGGER validar_edad_cliente 
BEFORE INSERT ON CLIENTE
FOR EACH ROW 
BEGIN
	IF NEW.edad < 18 THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El cliente debe tener al menos 18 años.';
	END IF;
END//
DELIMITER ;

-- 2) lanzará un error cada que se quiera ingresa una reserva que ya existe para un cliente
DELIMITER //
CREATE TRIGGER verificarReserva
BEFORE INSERT ON reserva
FOR EACH ROW
BEGIN
	declare resultado varchar(10);
	SELECT id_reserva INTO resultado
	FROM reserva
	WHERE id_reserva = new.id_reserva AND cedulaCliente IS NOT NULL;
	IF resultado IS NOT NULL THEN
		SIGNAL sqlstate '45000' set message_text = "Esta reserva ya tiene propietario";
	END IF;
END//
DELIMITER;

-- 3) Este trigger comprueba que cada que se haga un pago, se sume todos los pagos que se
-- han hecho a una reserva
DELIMITER //
CREATE TRIGGER comprobarReservaPagada
AFTER INSERT ON Pago
FOR EACH ROW
BEGIN
    DECLARE sumaPagos DECIMAL(7,2);
    DECLARE fechaCorte DATE;
    SELECT SUM(totalPagado) INTO sumaPagos
    FROM Pago
    WHERE id_reserva = NEW.id_reserva;
    SELECT DATEADD(DAY,5,fechaReserva) INTO fechaCorte
    FROM Reserva
    WHERE id_reserva = NEW.id_reserva;
    IF NEW.fechaPago > fechaCorte THEN
        UPDATE Reserva
        SET montoTotal = montoTotal + 5
        WHERE id_reserva = NEW.id_reserva;
    ELSEIF sumaPagos >= (Select montoTotal From Reserva WHERE id_reserva = NEW.id_reserva) THEN
        UPDATE Reserva
        SET estadoPago = 'COMPLETADO'
        WHERE id_reserva= NEW.id_reserva;
    ELSEIF NEW.totalPagado < totalApagar THEN
		UPDATE Reserva
        SET valorPendiente=totalApagar-NEW.totalPagado
        WHERE id_reserva = NEW.id_reserva;
	ELSE
		UPDATE Reserva
		SET totalApagar=montoTotal/mesesPlazo
        WHERE id_reserva = NEW.id_reserva;
    END IF;
END//
DELIMITER ;

-- 4)Este trigger es para calcular y actualizar el totalApagar mensual
DELIMITER //
CREATE TRIGGER calcularPagoMensual
AFTER INSERT ON Reserva
FOR EACH ROW
BEGIN
	UPDATE Reserva
    SET totalApagar = (SELECT montoTotal FROM Reserva WHERE id_reserva=NEW.id_reserva)/(SELECT mesePlazo FROM Reserva WHERE id_reserva=NEW.id_reserva)
    WHERE id_reserva=NEW.id_reserva;
END//
DELIMITER ;

-- REPORTES (VIEWS)
-- VISTA de boletos aereos con un precio menor de $200.
CREATE VIEW boletosMenoresA200 
AS SELECT b.id_boleto, b.numAsiento, b.numVuelo, b.clase, b.aerolinea, b.fechaSalida, b.aeroSalida, b.aeroLlegada, b.precio, c.nombre AS cliente_nombre, c.apellido AS cliente_apellido
	FROM boletoaereo b
	JOIN reserva r ON b.id_reserva = r.id_reserva
	JOIN cliente c ON r.cedulaCliente = c.cedulaCliente
	WHERE b.precio < 200;
    
-- VISTA de los pagos hechos a una reserva
CREATE VIEW reservaPagoPendiente
AS SELECT p.id_pago, p.totalPagado, p.formaPago, p.fechaPago, r.id_reserva, c.nombre AS cliente_nombre, c.apellido AS cliente_apellido
	FROM pago p
	JOIN reserva r ON p.id_reserva = r.id_reserva
	JOIN cliente c ON p.cedulaCliente = c.cedulaCliente;

-- Vista de clientes que han adquirido un boleto de clase economica, su pago fue por transferencia y no poseen visa, ordenados de forma ascendente por sus nombres.
CREATE VIEW clientesClaseEconomicaTransferenciaSinVisa 
AS SELECT DISTINCT c.cedulaCliente, c.nombre, c.apellido, c.email, c.telefono, c.ciudad, c.sector, c.calleYavenida
	FROM cliente c
	JOIN reserva r ON c.cedulaCliente = r.cedulaCliente
	JOIN pago p ON r.id_reserva = p.id_reserva
	JOIN boletoaereo b ON r.id_reserva = b.id_reserva
	WHERE b.clase = 'ECONOMICA' AND p.formaPago = 'TRANSFERENCIA' AND c.visaSioNo = FALSE
	ORDER BY c.nombre ASC;

-- Vista de clientes con reservas cuyo paquete turístico cuesta mas de $10000
CREATE VIEW clienteReservasMas10000
AS SELECT c.nombre, c.apellido, pt.precio
	FROM cliente c
	JOIN reserva r using(cedulaCliente)
	JOIN paqueteturistico pt using(id_paqueteturistico)
 WHERE pt.precio>=10000
 GROUP BY c.nombre, c.apellido;
 
 -- Vista del top  5 clientes con mas reservas hechas en el mes de agosto con una edad entre 18 a 25 y que el paquete turistico no cueste más de 500
CREATE VIEW top5clientes 
AS SELECT c.cedulaCliente, c.nombre, c.apellido, COUNT(r.id_reserva) AS num_reservas
	FROM cliente c
	JOIN reserva r ON c.cedulaCliente = r.cedulaCliente
	JOIN paqueteturistico p ON r.id_paqueteturistico = p.id_paqueteturistico
	WHERE MONTH(r.fechaReserva) = 8 AND c.edad BETWEEN 18 AND 25 AND p.precio <= 500 
    GROUP BY c.cedulaCliente, c.nombre, c.apellido
	ORDER BY num_reservas DESC;

-- STORED PROCEDURES
-- ELIMINACION
-- eliminar cliente
DELIMITER //
CREATE PROCEDURE eliminarCliente(IN ciCliente CHAR(10))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al eliminar cliente';
    END;
    START TRANSACTION;
		DELETE FROM cliente WHERE cedulaCliente = ciCliente;
    COMMIT;
END//
DELIMITER ;

-- eliminar Reserva
DELIMITER //
CREATE PROCEDURE eliminarReserva(IN idReserva INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al eliminar reserva';
    END;
    START TRANSACTION;
		DELETE FROM reserva WHERE id_reserva = idReserva;
    COMMIT;
END//
DELIMITER ;

-- eliminar Proveedor
DELIMITER //
CREATE PROCEDURE eliminarProveedor(IN idProveedor INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al eliminar proveedor';
    END;
    START TRANSACTION;
		DELETE FROM proveedor WHERE id_proveedor = idProveedor;
    COMMIT;
END//
DELIMITER ;

-- eliminar Empleado
DELIMITER //
CREATE PROCEDURE eliminarEmpleado(IN idEmpleado INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al eliminar empleado';
    END;
    START TRANSACTION;
		DELETE FROM empleado WHERE id_empleado = idEmpleado;
    COMMIT;
END//
DELIMITER ;

-- eliminar Paquete Turistico
DELIMITER //
CREATE PROCEDURE eliminarPaqueteTuristico(IN idPaqueteturistico INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al eliminar paquete turístico';
    END;
    START TRANSACTION;
		DELETE FROM paqueteturistico WHERE id_paqueteturistico = idPaqueteturistico;
    COMMIT;
END//
DELIMITER ;

-- eliminar Pago
DELIMITER //
CREATE PROCEDURE eliminarPago(IN idPago INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al eliminar pago';
    END;
    START TRANSACTION;
		DELETE FROM pago WHERE id_pago = idPago;
    COMMIT;
END//
DELIMITER ;

-- eliminar Boleto Aereo
DELIMITER //
CREATE PROCEDURE eliminarBoletoAereo(IN idBoleto INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al eliminar boleto aéreo';
    END;
    START TRANSACTION;
		DELETE FROM boletoaereo WHERE id_boleto = idBoleto;
    COMMIT;
END//
DELIMITER ;

-- ACTUALIZACION
-- Procedimiento para actualizar un registro en la tabla proveedor
DELIMITER //
CREATE PROCEDURE ActualizarProveedor(
     IN p_id_proveedor INT,
     IN p_nombre VARCHAR(15),
     IN p_ciudad VARCHAR(30),
     IN p_pais VARCHAR(15),
     IN p_telefono VARCHAR(15),
     IN p_email VARCHAR(30))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al actualizar registro de proveedor.';
    END;

    START TRANSACTION;


     UPDATE proveedor
 SET nombre = p_nombre, ciudad = p_ciudad, pais = p_pais, telefono = p_telefono, email = p_email
     WHERE id_proveedor = p_id_proveedor;
 COMMIT;
END //
DELIMITER ;


-- Procedimiento para actualizar un registro en la tabla paqueteturistico
DELIMITER //
CREATE PROCEDURE ActualizarPaqueteTuristico(
     IN p_id_paqueteturistico INT,
     IN p_descripcion VARCHAR(70),
     IN p_precio DECIMAL(7,2),
     IN p_fechaInicio DATE,
     IN p_fechaFin DATE,
     IN p_id_empleado INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al actualizar registro de paquete turistico.';
    END;

    START TRANSACTION;



     UPDATE paqueteturistico
     SET descripcion = p_descripcion, precio = p_precio, fechaInicio = p_fechaInicio,
         fechaFin = p_fechaFin, id_empleado = p_id_empleado
     WHERE id_paqueteturistico = p_id_paqueteturistico;
 COMMIT;
END //
DELIMITER ;

-- Procedimiento para actualizar un registro en la tabla pago
DELIMITER //
CREATE PROCEDURE ActualizarPago(
     IN p_id_pago INT,
     IN p_total DECIMAL(7,2),
     IN p_formaPago ENUM('TC','TD','TRANSFERENCIA'),
     IN p_fechaPago DATE,
     IN p_id_reserva INT,
     IN p_cedulaCliente CHAR(10))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al actualizar registro de pago.';
    END;
    START TRANSACTION;
     UPDATE pago
     SET totalPagado = p_total, formaPago = p_formaPago, 
         fechaPago = p_fechaPago, id_reserva = p_id_reserva,
         cedulaCliente = p_cedulaCliente
     WHERE id_pago = p_id_pago;
 COMMIT;
END //
DELIMITER ;

-- Procedimiento para actualizar un registro en la tabla boleto aereo
DELIMITER //
CREATE PROCEDURE ActualizarBoletoAereo(
     IN p_id_boleto INT,
     IN p_numAsiento VARCHAR(15),
     IN p_numVuelo VARCHAR(15),
     IN p_clase ENUM('ECONOMICA','EJECUTIVA','PRIMERA'),
     IN p_aerolinea VARCHAR(35),
     IN p_fechaSalida DATETIME,
     IN p_aeroSalida VARCHAR(35),
     IN p_aeroLlegada VARCHAR(35),
     IN p_id_reserva INT,
     IN p_id_empleado INT,
     IN p_precio DECIMAL(6,2))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al actualizar registro de boleto aereo.';
    END;

    START TRANSACTION;

     UPDATE boletoaereo
     SET numAsiento = p_numAsiento, numVuelo = p_numVuelo, clase = p_clase,
      aerolinea = p_aerolinea, fechaSalida = p_fechaSalida, aeroSalida = p_aeroSalida,
 aeroLlegada = p_aeroLlegada, id_reserva = p_id_reserva, id_empleado = p_id_empleado,
         precio = p_precio
     WHERE id_boleto = p_id_boleto;
 COMMIT;
END //
DELIMITER ;

-- PROCEDURE PARA MODIFICAR REGISTRO DE TABLA CLIENTE
DELIMITER //
CREATE PROCEDURE actualizarCliente(in cedCliente char(10), in cli_nombre varchar(15), in cli_apellido varchar(15), in cli_email varchar(35), in cli_telefono varchar(15), in cli_edad int, in cli_fecha_nac date, in cli_ciudad varchar(35), in cli_sector varchar(35), in cli_calleyavenida varchar(50), in cli_visaSioNo boolean, in cli_id_empleado int )
BEGIN
 DECLARE EXIT HANDLER FOR SQLEXCEPTION
 BEGIN
  ROLLBACK;
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al actualizar datos del cliente.';
 END;
 START TRANSACTION;

 UPDATE cliente
SET nombre=cli_nombre, apellido=cli_apellido, email=cli_email, telefono=cli_telefono, edad=cli_edad, fechaNacimiento=cli_fecha_nac, ciudad=cli_ciudad, sector=cli_sector,calleYavenida=cli_calleyavenida, visaSioNo=cli_visaSioNo, id_empleado=cli_id_empleado
 WHERE cedulaCliente = cedCliente;
 
 COMMIT;
END//
DELIMITER ;
drop procedure if exists actualizaDatosReserva;
-- PROCEDURE PARA ACTUALIZAR REGISTRO DE RESERVA
DELIMITER //
CREATE PROCEDURE actualizarReserva(in idReserva int, in montoTotalRes decimal(7,2), in valorPendienteRes decimal(7,2), in mesesPlazoRes int, in totalPagarRes decimal(7,2), in estadoPagoRes enum('PENDIENTE','COMPLETADA'), in estadoRes enum('CONFIRMADA','CANCELADA'), in numPersonasRes int, in fechares date, in paqueTuris int, cedula_cliente char(10) )
BEGIN
 DECLARE EXIT HANDLER FOR SQLEXCEPTION
 BEGIN
  ROLLBACK;
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al actualizar datos de la reserva.';
 END;
 START TRANSACTION;

 UPDATE reserva
 SET montoTotal=montoTotalRes, valorPendiente = valorPendienteRes, mesesPlazo=mesesPlazoRes ,totalPagar=totalPagarRes, estadoPago= estadoPagoRes, estado= estadoRes, numPersonas=numPersonasRes, fechaReserva = fechares, id_paqueteturistico = paqueTuris, cedulaCliente=cedula_cliente
 WHERE id_reserva = idReserva;
 COMMIT;
END//
DELIMITER;

-- actualizar datos empleado
DELIMITER //
CREATE PROCEDURE ActualizarEmpleado(
    IN p_id_empleado INT,
    IN p_nombre VARCHAR(15),
    IN p_apellido VARCHAR(15),
    IN p_usuario VARCHAR(10),
    IN p_clave VARCHAR(12),
    IN p_email VARCHAR(35),
    IN p_telefono VARCHAR(15),
    IN p_direccion VARCHAR(50),
    IN p_esadministrador BOOLEAN,
    IN p_escontador BOOLEAN,
    IN p_esasesor BOOLEAN,
    IN p_id_supervisor INT,
    IN p_id_proveedor INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al actualizar el empleado.';
    END;

    START TRANSACTION;

    UPDATE empleado
    SET 
        nombre = p_nombre,
        apellido = p_apellido,
        usuario = p_usuario,
        clave = p_clave,
        email = p_email,
        telefono = p_telefono,
        direccion = p_direccion,
        esadministrador = p_esadministrador,
        escontador = p_escontador,
        esasesor = p_esasesor,
        id_supervisor = p_id_supervisor,
        id_proveedor = p_id_proveedor
    WHERE id_empleado = p_id_empleado;

    COMMIT;
END//
DELIMITER ;

-- INSERCION
-- Procedimiento para insertar en la tabla proveedor
DELIMITER //
CREATE PROCEDURE InsertarProveedor(
     IN p_nombre VARCHAR(15),
     IN p_ciudad VARCHAR(30),
     IN p_pais VARCHAR(15),
     IN p_telefono VARCHAR(15),
     IN p_email VARCHAR(30)
)
BEGIN
     DECLARE EXIT HANDLER FOR SQLEXCEPTION
     BEGIN
          ROLLBACK;
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al insertar en la tabla proveedor.';
     END;

    START TRANSACTION;
    
    INSERT INTO proveedor (nombre, ciudad, pais, telefono, email)
    VALUES (p_nombre, p_ciudad, p_pais, p_telefono, p_email);
    
    COMMIT;
END //
DELIMITER ;
-- Procedimiento para insertar en la tabla empleado
DELIMITER //
CREATE PROCEDURE InsertarEmpleado(
     IN p_nombre VARCHAR(15),
     IN p_apellido VARCHAR(15),
     IN p_usuario VARCHAR(10),
     IN p_clave VARCHAR(12),
     IN p_email VARCHAR(35),
     IN p_telefono VARCHAR(15),
     IN p_direccion VARCHAR(70),
     IN p_esadministrador BOOLEAN,
     IN p_escontador BOOLEAN,
     IN p_esasesor BOOLEAN,
     IN p_id_supervisor INT,
     IN p_id_proveedor INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al insertar en la tabla empleado.';
    END;

    START TRANSACTION;
    
    INSERT INTO empleado (nombre, apellido, usuario, clave, email, telefono, direccion, esadministrador, escontador, esasesor, id_supervisor, id_proveedor)
    VALUES (p_nombre, p_apellido, p_usuario, p_clave, p_email, p_telefono, p_direccion, p_esadministrador, p_escontador, p_esasesor, p_id_supervisor, p_id_proveedor);
    
    COMMIT;
END //
DELIMITER;
-- Procedimiento para insertar en la tabla cliente
DELIMITER //
CREATE PROCEDURE InsertarCliente(
    IN p_cedulaCliente CHAR(10),
    IN p_nombre VARCHAR(15),
    IN p_apellido VARCHAR(15),
    IN p_email VARCHAR(35),
    IN p_telefono VARCHAR(15),
    IN p_edad INT,
    IN p_fechaNacimiento DATE,
    IN p_ciudad VARCHAR(15),
    IN p_sector VARCHAR(15),
    IN p_calleYavenida VARCHAR(50),
    IN p_visaSioNo BOOLEAN,
    IN p_id_empleado INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al insertar en la tabla cliente.';
    END;

    START TRANSACTION;
    
    INSERT INTO cliente (cedulaCliente, nombre, apellido, email, telefono, edad, fechaNacimiento, ciudad, sector, calleYavenida, visaSioNo, id_empleado)
    VALUES (p_cedulaCliente, p_nombre, p_apellido, p_email, p_telefono, p_edad, p_fechaNacimiento, p_ciudad, p_sector, p_calleYavenida, p_visaSioNo, p_id_empleado);
    
    COMMIT;
END //
DELIMITER ;
-- Procedimiento para insertar en la tabla paqueteturistico
DELIMITER //
CREATE PROCEDURE InsertarPaqueteTuristico(
    IN p_descripcion VARCHAR(70),
    IN p_precio DECIMAL(7,2),
    IN p_fechaInicio DATE,
    IN p_fechaFin DATE,
    IN p_id_empleado INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al insertar en la tabla paqueteturistico.';
    END;

    START TRANSACTION;
    
    INSERT INTO paqueteturistico (descripcion, precio, fechaInicio, fechaFin, id_empleado)
    VALUES (p_descripcion, p_precio, p_fechaInicio, p_fechaFin, p_id_empleado);
    
    COMMIT;
END //
DELIMITER ;

-- Procedimiento para insertar en la tabla reserva
DELIMITER //
CREATE PROCEDURE InsertarReserva(
    IN p_montoTotal DECIMAL(7,2),
    IN p_mesesPlazo int,
    IN p_estadoPago ENUM('PENDIENTE','COMPLETADA'),
    IN p_estado ENUM('CONFIRMADA', 'CANCELADA'),
    IN p_numPersonas INT,
    IN p_fechaReserva DATE,
    IN p_id_paqueteturistico INT,
    IN p_cedulaCliente CHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al insertar en la tabla reserva.';
    END;
    START TRANSACTION;
    INSERT INTO reserva (montoTotal, mesesPlazo, estadoPago, estado, numPersonas,fechaReserva,id_paqueteturistico, cedulaCliente)
    VALUES (p_montoTotal,p_mesesPlazo, p_estadoPago,p_estado, p_numPersonas, p_fechaReserva, p_id_paqueteturistico, p_cedulaCliente);
    COMMIT;
END //
DELIMITER ;

-- Procedimiento para insertar en la tabla pago
DELIMITER //
CREATE PROCEDURE InsertarPago(
    IN p_totalPagado DECIMAL(7,2),
    IN p_formaPago ENUM('TC', 'TD', 'TRANSFERENCIA'),
    IN p_fechaPago DATE,
    IN p_id_reserva INT,
    IN p_cedulaCliente CHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al insertar en la tabla pago.';
    END;

    START TRANSACTION;
    
    INSERT INTO pago(totalPagado, formaPago, fechaPago, id_reserva, cedulaCliente)
    VALUES (p_totalPagado, p_formaPago, p_fechaPago, p_id_reserva, p_cedulaCliente);
    
    COMMIT;
END //
DELIMITER ;
-- Procedimiento para insertar en la tabla boletoaereo
DELIMITER //
CREATE PROCEDURE InsertarBoletoAereo(
    IN p_numAsiento VARCHAR(15),
    IN p_numVuelo VARCHAR(15),
    IN p_clase ENUM('ECONOMICA', 'EJECUTIVA', 'PRIMERA'),
    IN p_aerolinea VARCHAR(35),
    IN p_fechaSalida DATETIME,
    IN p_aeroSalida VARCHAR(35),
    IN p_aeroLlegada VARCHAR(35),
    IN p_id_reserva INT,
    IN p_id_empleado INT,
    IN p_precio DECIMAL(6,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al insertar en la tabla boletoaereo.';
    END;

    START TRANSACTION;
    
    INSERT INTO boletoaereo (numAsiento, numVuelo, clase, aerolinea, fechaSalida, aeroSalida, aeroLlegada, id_reserva, id_empleado, precio)
    VALUES (p_numAsiento, p_numVuelo, p_clase, p_aerolinea, p_fechaSalida, p_aeroSalida, p_aeroLlegada, p_id_reserva, p_id_empleado, p_precio);
    
    COMMIT;
END //
DELIMITER ;


-- INDICES
-- Dado que la columna usuario es única y no nula, un índice aquí puede ayudar en las autenticaciones de usuario.
CREATE INDEX indice_usuario_empleado ON empleado(usuario);

-- Este índice optimiza las consultas que filtran los pagos por el id_reserva para conocer el estado de los valores a cancelar
CREATE INDEX indice_pagos ON reserva(id_reserva);

CREATE INDEX indice_email_cliente ON cliente(email);

CREATE INDEX indice_numVuelo_boleto ON boletoaereo(numVuelo);

CREATE INDEX indice_fechaReserva_reserva ON reserva(fechaReserva);
-- USUARIOS
CREATE USER 'wsmiraba'@'localhost' IDENTIFIED BY 'pass123'; 
CREATE USER 'pmtapia'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER 'scayceva'@'localhost' IDENTIFIED BY 'pass123'; 
CREATE USER 'alvdcabr'@'localhost' IDENTIFIED BY 'pass123'; 
CREATE USER 'irenecheung'@'localhost' IDENTIFIED BY 'pass123';

-- PERMISOS
-- 1 a SP 
GRANT EXECUTE ON PROCEDURE LMRTOURS.eliminarCliente TO 'wsmiraba'@'localhost';
-- 2 a VIEWS
GRANT SELECT ON LMRTOURS.boletosMenoresA200 TO 'pmtapia'@'localhost'; 
GRANT SELECT ON LMRTOURS.reservaPagoPendiente TO 'alvdcabr'@'localhost';
-- 7 sobrantes
GRANT UPDATE ON LMRTOURS.* TO 'pmtapia'@'localhost';
GRANT UPDATE ON LMRTOURS.* TO 'alvdcabr'@'localhost';
-- aqui hay dos permisos
GRANT ALL PRIVILEGES ON LMRTOURS.* TO ' irenecheung'@'localhost' WITH GRANT OPTION;
GRANT EXECUTE ON PROCEDURE LMRTOURS.actualizarReserva TO 'wsmiraba'@'localhost';
GRANT CREATE ON LMRTOURS.* TO 'scayceva'@'localhost';
GRANT DELETE ON LMRTOURS.* TO 'scayceva'@'localhost';
GRANT SELECT ON LMRTOURS.empleado TO 'wsmiraba'@'localhost';
GRANT SELECT ON LMRTOURS.empleado TO 'scayceva'@'localhost';
GRANT SELECT ON LMRTOURS.empleado TO 'alvdcabr'@'localhost';
GRANT SELECT ON LMRTOURS.empleado TO 'pmtapia'@'localhost';
-- AUN NO EJECUTADO
FLUSH PRIVILEGES;
