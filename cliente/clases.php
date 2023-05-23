<?php

include 'conexion.php';

$pdo = new Conexion();

// GET tabla vehiculos
if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if(isset($_GET['id_vehiculo'])){ // consultar un solo registro de la tabla
        $sql = $pdo->prepare("SELECT * FROM tb_vehiculo WHERE id_vehiculo=:id_vehiculo");
        $sql->bindValue(':id_vehiculo', $_GET['id_vehiculo'] );
        $sql->execute();
        $resultados = $sql->fetchAll(PDO::FETCH_ASSOC);
        header("HTTP/1.1 200 OK");
        echo json_encode($resultados);
        exit;
    } else {
        $sql = $pdo->prepare("SELECT * FROM tb_vehiculo");
        $sql->execute();
        $resultados = $sql->fetchAll(PDO::FETCH_ASSOC);
        header("HTTP/1.1 200 OK");
        echo json_encode($resultados);
        exit;
    }
}


// POST tabla clientes
if ($_SERVER['REQUEST_METHOD'] == 'POST'){
    $sql = "INSERT INTO tb_cliente (doc_identidad_cli, direccion_cli, telefono_cli,
     correo_cli, nombre_cli, apellido_cli) VALUES (:doc_identidad_cli, :direccion_cli, :telefono_cli,
     :correo_cli, :nombre_cli, :apellido_cli)";

    $stmt = $pdo->prepare($sql);
    $stmt->bindValue(':doc_identidad_cli', $_POST['doc_identidad_cli'] );
    $stmt->bindValue(':direccion_cli', $_POST['direccion_cli'] );
    $stmt->bindValue(':telefono_cli', $_POST['telefono_cli'] );
    $stmt->bindValue(':correo_cli', $_POST['correo_cli'] );
    $stmt->bindValue(':nombre_cli', $_POST['nombre_cli'] );
    $stmt->bindValue(':apellido_cli', $_POST['apellido_cli'] );
    $stmt->execute();        
     $idPost = $pdo->lastInsertId(); // trae el id registrado en el post

     if($idPost){
        header("HTTP/1.1 200 OK");
        echo json_encode($idPost);
        exit;
     }

}

//PUT tabla clientes

if ($_SERVER['REQUEST_METHOD'] == 'PUT') {
    

    $sql = "UPDATE tb_cliente SET doc_identidad_cli = :doc_identidad_cli, direccion_cli = :direccion_cli,
        telefono_cli = :telefono_cli, correo_cli = :correo_cli, nombre_cli = :nombre_cli, apellido_cli = :apellido_cli WHERE id_cliente = :id_cliente";

    $stmt = $pdo->prepare($sql);
    $stmt->bindValue(':doc_identidad_cli', $_GET['doc_identidad_cli']);
    $stmt->bindValue(':direccion_cli', $_GET['direccion_cli']);
    $stmt->bindValue(':telefono_cli', $_GET['telefono_cli']);
    $stmt->bindValue(':correo_cli', $_GET['correo_cli']);
    $stmt->bindValue(':nombre_cli', $_GET['nombre_cli']);
    $stmt->bindValue(':apellido_cli', $_GET['apellido_cli']);
    $stmt->bindValue(':id_cliente', $_GET['id_cliente']);
    $stmt->execute();
    header("HTTP/1.1 200 OK");
    exit;
    

}

//DELETE tabla clientes

if ($_SERVER['REQUEST_METHOD'] == 'DELETE') {
    // Obtener el valor del ID del cliente de $_REQUEST
    $id_cliente = $_REQUEST['id_cliente'] ?? null;

    if ($id_cliente !== null) {
        $sql = "DELETE FROM tb_cliente WHERE id_cliente = :id_cliente";
        $stmt = $pdo->prepare($sql);
        $stmt->bindValue(':id_cliente', $id_cliente);
        $stmt->execute();

        $rowCount = $stmt->rowCount();

        if ($rowCount > 0) {
            header("HTTP/1.1 200 OK");
            echo json_encode($rowCount);
            exit;
        }
    }
}

header("HTTP/1.1 400 Bad REQUEST");


?>

