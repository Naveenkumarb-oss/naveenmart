@echo off
echo Starting NaveenMart...
echo Make sure MySQL is running and the database exists.
set /p DB_PASSWORD=Enter MySQL password:
set DB_USERNAME=root
set DB_URL=jdbc:mysql://localhost:3306/naveen_mart?createDatabaseIfNotExist=true^&useSSL=false^&allowPublicKeyRetrieval=true^&serverTimezone=Asia/Kolkata
call mvn clean package
if errorlevel 1 goto error
java -jar target/naveen-mart.jar
goto end
:error
echo Build failed. Check Java 17 and Maven installation.
pause
:end
