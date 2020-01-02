@echo off
TITLE Steadfast5 server software for Minecraft: Bedrock Edition
cd /d %~dp0

if exist %~dp0PocketMine-MP\ goto PMSTART

where git >nul 2>nul || (powershell -command "& { iwr https://github.com/git-for-windows/git/releases/download/v2.20.1.windows.1/Git-2.20.1-64-bit.exe -OutFile Git-2.20.1-64-bit.exe }" & start Git-2.20.1-64-bit.exe & pause)

mkdir Steadfast5


cd Steadfast5

curl -s https://api.github.com/repos/jgm/pandoc/releases/latest \
| grep "https://github.com/IceCruelStuff/Steadfast5/releases/download/v1.2/Steadfast5.phar.*deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -

curl -s https://api.github.com/repos/jgm/pandoc/releases/latest \
| grep "https://github.com/IceCruelStuff/Steadfast5/releases/download/v1.1/start.cmd.*deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -


git clone https://github.com/IceCruelStuff/bin.git --recursive

if exist bin\php\php.exe (
	set PHPRC=""
	set PHP_BINARY=bin\php\php.exe
) else (
	set PHP_BINARY=php
)

if exist PocketMine-MP.phar (
	set POCKETMINE_FILE=PocketMine-MP.phar
) else (
	if exist Steadfast5.phar (
		set POCKETMINE_FILE=Steadfast5.phar
	) else (
		if exist src\pocketmine\PocketMine.php (
			set POCKETMINE_FILE=src\pocketmine\PocketMine.php
		) else (
			echo "Couldn't find a valid Steadfast5 installation"
			pause
			exit 1
		)
	)
)

REM if exist bin\php\php_wxwidgets.dll (
REM 	%PHP_BINARY% %POCKETMINE_FILE% --enable-gui %*
REM ) else (
	if exist bin\mintty.exe (
		start "" bin\mintty.exe -o Columns=88 -o Rows=32 -o AllowBlinking=0 -o FontQuality=3 -o Font="DejaVu Sans Mono" -o FontHeight=10 -o CursorType=0 -o CursorBlinks=1 -h error -t "PocketMine-MP" -i bin/pocketmine.ico -w max %PHP_BINARY% %POCKETMINE_FILE% --enable-ansi %*
	) else (
		%PHP_BINARY% -c bin\php %POCKETMINE_FILE% %*
	)
REM )