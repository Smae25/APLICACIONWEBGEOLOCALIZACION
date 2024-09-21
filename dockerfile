#este comando establece una imagen base de Node.js
#con la version 18 alpine la cual es una imagen ligera
#de linux as build es una fase para construir la app 
#no es parte de la imagen final
FROM node:18-alpine as build  

#aqui se establece el directorio de trabajo
#dentro del contenedor como /app todo los archivos o comandos
#se ejecutaran dentro de este directorio
WORKDIR /app

#copy..copiara todo los archivos del directorio local
#al directorio de trabajo dentro del contenedor /app
COPY . .

#se instala todas las dependencias necesarias 
#listadas en el archivo package.json de nuestro proyecto
RUN npm install

#Ejecuta el comando de construcción de Angular en modo producción
#esto compilara la aplicacion en archivos estaticos optimizados para produccion
RUN npm run build --prod

#Define otra imagen base, esta vez de Nginx en su versión Alpine, para servir el frontend generado.
FROM nginx:alpine

#Copia los archivos estáticos generados en la fase de construcción (build) 
#desde el directorio /app/dist/frontend (donde Angular guarda la salida del build) al directorio de Nginx que sirve archivos HTML (/usr/share/nginx/html).
COPY --from=build /app/dist/frontend /usr/share/nginx/html

#Expone el puerto 80 para que el contenedor esté accesible a través de ese puerto cuando se ejecute.
EXPOSE 80

#Define el comando que ejecutará el contenedor cuando se inicie. Este comando ejecuta Nginx con la opción daemon off, que permite ejecutar Nginx en primer plano
#el cual es necesario para que Docker mantenga el contenedor en ejecución.
CMD ["nginx", "-g", "daemon off;"]