<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Correo con laravel</title>
</head>

<body>
    @if(session('success'))
    <li>{{session('success')}}</li>
    @endif
    <form action="{{route('enviar-correo')}}" method="POST" enctype="multipart/form-data">
        @csrf
        <label for="">Destinatario</label>
        <input type="email" name="destinatario" required>
        <label for="">Mensaje</label>
        <textarea name="mensaje" id="" cols="30" rows="3"></textarea>
        <label for="">Adjunto</label>
        <input type="file" name="adjunto" id="">
        <button type="submit">Enviar Correo</button>

    </form>
</body>

</html>