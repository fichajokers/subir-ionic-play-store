#!/bin/sh

ayuda() { 
  echo -e "\n"
  echo "-----------------------------------------------------------"
  echo "|Bash compilar y firmar apk android para subir a la Store.|"
  echo "-----------------------------------------------------------"
  
  #echo -e "\n-----------------------------------------------------------"
  #echo -e "|1. Poner el archivo en la raiz de tu proyecto cordova/ionic"
  #echo -e "|Primera vez: subirStore -f [nombre proyecto]"
  #echo -e "|Otras veces: subirStore [-a | --apk] [-p | --proyecto] se ocupan siempre juntos"
  #echo "-----------------------------------------------------------"
  
  #echo -e "\n-----------------------------------------------------------"
  #echo -e "|Si es primera vez que se sube a la Store es necesario generar una keystore"
  #echo "-----------------------------------------------------------"

  echo -e "Opciones:\n"
  echo -e " -h,            Despliega información de ayuda de la herramienta\n
 -a, --apk      Nombre del 'archivo'.apk a generar\n
 -p, --proyecto Nombre del proyecto(nombre de a firma de la keystore)\n
 -f, crear la keystore. Esto es encesario para realizar la primera subida a la Store.
          "

  exit 1; 
}

compilarIonic(){
  apk="${apk}"
  proyecto="${proyecto}"

  #compilar la version de la aplcicacion
  ionic build android -release

  #copiar la version a la carpeta raiz del proyecto
  cp platforms/android/build/outputs/apk/android-release-unsigned.apk android-release-unsigned.apk 

  #eliminar, si es que existe el .apk que se genero anteriormente
  rm $apk.apk

  jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $proyecto.keystore android-release-unsigned.apk $proyecto
  jarsigner -verify -verbose -certs android-release-unsigned.apk
  zipalign -v 4 android-release-unsigned.apk $apk.apk
  
}

firmarApk(){
  firma="${firma}"
  keytool -genkey -v -keystore  $firma.keystore -alias $firma -keyalg RSA -keysize 2048 -validity 10000
 
}

while getopts ":a:p:apk:proyecto:h:f:" o; do
    case "${o}" in
        a)
            apk=${OPTARG}
            ;;
        apk)
            apk=${OPTARG}
            ;;
        p)
            proyecto=${OPTARG}
            ;;
        proyecto)
            proyecto=${OPTARG}
            ;;
        f)
            firma=${OPTARG}
            firmarApk
            ;;
        h)
            ayuda
            ;;
        *)
            ayuda
            ;;
    esac
done

if [ -n "${apk}" ] && [ -n "${proyecto}" ]; then
  compilarIonic
fi

