# subir-ionic-cordova-play-store
Bash para subir aplicación Android creada mediante ionic/cordova a la Playstore 


## Introducción
Para subir una aplicación android a la play store la primera vez hay que firmarla, esto se realiza mediante una serie de comandos, nada difícil.

Luego, una vez teniendo la firma hay que subirlo a la playstore, esto igual se realiza mediante una serie de comandos que a la larga son demasiado tediosos, es por ello que se creó esta herramienta en bash para poder firmar y subir la app creada a la playstore.

##Windows
si utilizan windows igual pueden ejecutar el programa, sólo deben bajar el termial Cygwin, el cual permite ejecutar archivos bash en windows.

Link: https://cygwin.com/install.html



##Importante
No olvidar modificar la versión de la aplicación antes de subirla a la playstore, si no se tendrá que repetir algunos pasos.
En el config.xml, modificar android-versionCode y version.

```
android-versionCode="16" version="3.1.4"

```


## Uso
Descargar el archivo subirStore.sh y ubicarlo en la raiz del proyecto ionic/cordova.

##Crear Firma (Sólo una vez)
Crear el archivo de firma (SÓLO SE HACE UNA VEZ ESTE PASO), se debe poner el comando -f seguido por el nombre del proyecto. (el texto se pone sin las comillas).

```
sh subirStore.sh -f "test"

```
##Hacer Build, Firmar, Verificar

significado de los comandos:
[ -a | --apk ]      : nombre del .apk
[ -p | --proyecto ] : nombre del proyecto

Ahora solo queda ejecutar el programa con los comandos [ -a | --apk ] y [ -p | --proyecto ], este comando hará los siguientes pasos.

1 Hará un ionic/cordova build android -release.

2 Se ejecuta el comando jarsigner, el cual nos pedirá una contraseña (que la creamos en el paso "Crear Firma").

3 Se verifica la firma del paso anterior.

4 finalemente se alinea el APK.

(el nombre del apk y del proyecto se ponen sin las comillas)

```
sh subirStore.sh -a "test" -p "test"

```

## Subir a la Store
Una vez realizado todos los pasos se generará un archivo .apk con el nombre del apk dado ([ -a | --apk ]), este archivo estará en la ruta raiz del proyecto cordova/ionic.

Finalmente entrar a la cuenta de desarrollador de android https://play.google.com/apps/publish , ingresar tu usuario y contraseña y subir la aplicación.