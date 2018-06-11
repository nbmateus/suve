<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Inicio</title>
<link rel="stylesheet" type="text/css" href="css/estilos.css">
<script src="js/jquery-3.3.1.js"></script>
<script>
	$(document).ready(function() {

		$("#divBotonInicio").mouseenter(entraMouseBoton);
		$("#divBotonInicio").mouseleave(saleMouseBoton);
		$("#divBotonInicio").mousedown(apretaMouseBoton);
		$("#divBotonInicio").mouseup(sueltaMouseBoton);
	});

	function apretaMouseBoton() {
		etq = document.getElementById("lblBotonInicio");
		etq.style.marginTop = "2px";
		etq.style.marginLeft = "3px";
	}
	function sueltaMouseBoton() {
		etq.style.marginTop = "0px";
		etq.style.marginLeft = "0px";
		ingresar();
	}

	function entraMouseBoton() {
		miboton = document.getElementById("divBotonInicio");
		miboton.style.backgroundColor = "#3F608B";
	}
	function saleMouseBoton() {
		miboton = document.getElementById("divBotonInicio");
		miboton.style.backgroundColor = "#7092be";
	}
	
	function ingresar() {
		$.ajax({
			data : {
				"user" : $("#inpUser").val(),
				"pass" : $("#inpPass").val(),
			},
			url : "IniciarSesion",
			type : "POST",
			beforeSend : function() {
				$("#divEstadoLoggin").html("");
			},
			success : function(response) {
				$("#divEstadoLoggin").html("Sesion Iniciada");
				$("#divBienvenidoUsuario").html("<img alt=\"\" src=\"recursos/logginE.png\"><br>"+"Bievenido " + response.apellido + ", " + response.nombre);
				tipoSesion = response.tipo;
				$("#divIniciarSesion").hide();
				revisarContenido();
			},
			error : function(response) {
				$("#divEstadoLoggin").html("Usuario y/o contraseņa incorrectos");
			}
		});
	}

</script>
</head>
<body>
	<h1>Bienvenidos al sistema de gestion SUVE</h1>
	<div id="divIniciarSesion">
		
		<div id="divLoggin">
			<h1>Iniciar sesion</h1>
			<label id="lblUser">Usuario (DNI):</label> 
			<br>
			<input id="inpUser"></input>
			<br> 
			<label id="lblPass">Contraseņa:</label> 
			<br>
			<input id="inpPass" type="password"></input>
			<br>
			<div id=divBotonInicio>
				<label id="lblBotonInicio">Ingresar</label>
			</div>
		</div>
		<div id="divLogginPic"><img alt="" src="recursos/logginE.png"></div>
		<div id="divEstadoLoggin"></div>
	</div>
	
	
</body>
</html>