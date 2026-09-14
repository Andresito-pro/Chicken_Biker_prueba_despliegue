# ==========================================
# Etapa 1: Construcción (Build)
# ==========================================
FROM eclipse-temurin:17-jdk AS builder

# Instalar Apache Ant para compilar el proyecto de NetBeans
RUN apt-get update && apt-get install -y ant

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar todos los archivos del repositorio al contenedor
COPY . .

# Ejecutar Ant usando el archivo build.xml para limpiar y compilar el .war
RUN ant -f build.xml clean dist

# ==========================================
# Etapa 2: Producción (Runtime)
# ==========================================
# Usar Tomcat 10 que tiene soporte nativo para Jakarta Servlets
FROM tomcat:10.1-jre17

# Limpiar las aplicaciones por defecto de Tomcat para evitar conflictos
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar el archivo .war generado en la Etapa 1
# Se renombra a ROOT.war para que la app responda en la ruta principal (/) en lugar de /ChickenBiker
COPY --from=builder /app/dist/*.war /usr/local/tomcat/webapps/ROOT.war

# Exponer el puerto por defecto de Tomcat
EXPOSE 8080

# Iniciar Tomcat
CMD ["catalina.sh", "run"]
