-- prueba2.php --

<html>
	<body>
		<p style="color:green"> Segundo Ejercicio </p>
		<?php
		
		//Zona declaración de variables
		$numero=5;
		
		//Si numero mayor o igual a 5 muestra texto Mayor, si no, muestra Menor
		if ($numero >= 5){
			echo '<p style="color:green">Mayor/Igual a 5</p>';
		}
		else {
			echo '<p style="color:red">Menor a 5</p>';
		};

		
		?>
	</body>
</html>