# Control de Tarjetas

App web instalable para registrar tarjetas y consumos. Las cuentas usan Supabase Auth; los registros se guardan en Supabase y quedan asociados al usuario autenticado.

## Conectar el servicio de cuentas

1. Creá una cuenta en [Supabase Dashboard](https://supabase.com/dashboard). Podés registrarte con correo o con un proveedor disponible en la pantalla.
2. En el Dashboard, creá un proyecto llamado `control-tarjetas`. La contraseña de base de datos es solo para administrar el proyecto; guardala en un lugar seguro y no la pongas en los archivos de la app.
3. En **SQL Editor**, ejecutá `supabase-schema.sql`.
4. En **Project Settings > API**, copiá la **Project URL** y la **publishable key**.
5. Pegá esos dos valores en `config.js`, reemplazando `TU_PROYECTO_URL` y `TU_CLAVE_PUBLICABLE`.
6. En **Authentication > URL Configuration**, agregá la dirección de GitHub Pages como Site URL y Redirect URL. Configurá el envío de confirmación por correo antes de habilitar el registro.

`config.js` usa una clave publicable que se puede incluir en el sitio web. La seguridad depende de la política RLS de la tabla. Nunca incluyas una secret key ni una service_role key en archivos del sitio.

## Publicar en GitHub Pages

Subí el contenido de esta carpeta a la raíz de un repositorio y activá **Settings > Pages > Deploy from a branch**, seleccionando la rama `main` y la carpeta `/ (root)`. GitHub Pages publica el sitio con HTTPS. Después agregá la URL final en la configuración de URLs de Supabase.

Una vez publicado, se puede instalar desde el menú del navegador en Android. En iPhone, abrí el enlace en Safari y elegí **Compartir > Agregar a pantalla de inicio**. La app necesita conexión a internet para iniciar sesión y sincronizar los datos.

## Datos y alcance

- El código no trae tarjetas ni compras de ejemplo; cada cuenta empieza vacía.
- Los registros de una cuenta se guardan en una fila privada, protegida con Row Level Security (RLS).
- La app guarda nombres de tarjetas, banco, tipo, límite, consumos, categorías, moneda y cuotas. No solicita el número completo de la tarjeta ni el código de seguridad.
- Esta primera versión sincroniza la lista completa de registros al guardar. Si la misma cuenta se edita simultáneamente desde dos dispositivos, el último guardado puede reemplazar cambios hechos en el otro dispositivo.
- El acceso depende de Supabase y de sus opciones de confirmación de correo; no se guardan contraseñas en la app.

## Vista previa local

Serví la carpeta con un servidor local y abrí la URL por `localhost` (no abrir `index.html` directamente desde el explorador de archivos). Para usar el registro, primero completá `config.js` y el esquema de la base de datos.

