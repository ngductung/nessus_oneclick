@echo off
REM Khởi chạy Docker container
docker run -itd --name=nessus -p 8834:8834 vhae044/nessus

REM Tải các file cần thiết
curl -L -o admin.zip https://github.com/ngductung/nessus_oneclick/raw/main/admin.zip
curl -L -o update.sh https://github.com/ngductung/nessus_oneclick/raw/main/update.sh

REM Xóa bản update.sh cũ trong container (nếu có)
docker exec -it nessus bash -c "rm /nessus/update.sh"

REM Copy file update.sh vào container
docker cp update.sh nessus:/nessus/

REM Giải nén file admin.zip
powershell -Command "Expand-Archive -Force 'admin.zip' 'admin'"

REM Copy thư mục admin vào container
docker cp admin nessus:/opt/nessus/var/nessus/users/

REM Xóa file và thư mục tạm
del admin.zip
rmdir /s /q admin
del update.sh

REM Thực thi update.sh trong container
docker exec -it nessus bash /nessus/update.sh

cls
echo.
echo  ██   ██ ███████ ██   ██     ██    ██ ██   ██  █████  ███████                         
echo  ██   ██ ██      ██   ██     ██    ██ ██   ██ ██   ██ ██                              
echo  ███████ █████   ███████     ██    ██ ███████ ███████ █████       █████         █████ 
echo  ██   ██ ██      ██   ██      ██  ██  ██   ██ ██   ██ ██                              
echo  ██   ██ ███████ ██   ██       ████   ██   ██ ██   ██ ███████           ███████       
echo.
echo   src: fahai
echo   「 account day heh >< 」
echo   username: admin
echo   password: Vhae@04
echo.
echo   Host: https://127.0.0.1:8834
echo.
echo   src : elliot-bia
pause
