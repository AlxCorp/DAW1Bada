<?php

//conectar con la base de datos 
include ('conexion.php');


$sql = "INSERT INTO Usuarios (Nombre, Telefono, Direccion)
VALUES ('".$_POST['nombre']."','".$_POST['telefono']."','".$_POST['direccion']."')";
// inserta en la tabla alumno de la base de datos BIBLIOTECA 
if (mysqli_query($conn, $sql)) {
    echo "New record created successfully<br>";
} else {
    echo "Error: " . $sql . "<br>" . mysqli_error($conn);
}


mysqli_close($conn);

echo "<a href='home.html'>Volver Inicio </a>";
?>