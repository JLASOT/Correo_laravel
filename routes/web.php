<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Mail;
use App\Mail\EnviarCorreo;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('home');
})->name('home');

Route::post('enviar_correo', function () {
    //return request()->all();
    /* para poder visualizar como se va a enviar el correo sin q se envie
    return new EnviarCorreo(request()->mensaje, request()->adjunto);
    */
    Mail::to(request()->destinatario)->send(new EnviarCorreo(request()->mensaje, request()->adjunto));
    return redirect()->route('home')->with('success', 'correo enviado exitosamente');
})->name('enviar-correo');
