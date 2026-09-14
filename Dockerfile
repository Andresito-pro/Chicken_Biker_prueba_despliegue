# ==========================================
# Producción (Runtime)
# ==========================================
# Usar Tomcat 10 que tiene soporte nativo para Jakarta Servlets
FROM tomcat:10.1-jre17

# Limpiar las aplicaciones por defecto de Tomcat para evitar conflictos
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar el archivo .war ya compilado en el repositorio
# Se renombra a ROOT.war para que la app responda en la ruta principal (/) en lugar de /ChickenBiker
COPY ChickenBiker.war /usr/local/tomcat/webapps/ROOT.war

# Exponer el puerto por defecto de Tomcat
EXPOSE 8080

# Iniciar Tomcat
CMD ["catalina.sh", "run"]
