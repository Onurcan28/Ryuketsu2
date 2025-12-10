@echo off

for %%x in (Datenbank, Loginserver, Channel1, Channel2, Channel3) do (

	@rmdir /q "C:/Ryuketsu2-Git/Server/%%x/data" >nul 2>&1
	@del /Q "C:/Ryuketsu2-Git/Server/%%x\data" >nul 2>&1
	@mklink /D "C:/Ryuketsu2-Git/Server/%%x/data" "C:/Ryuketsu2-Git/Server/share/data"

	rmdir /q "C:/Ryuketsu2-Git/Server/%%x/locale" >nul 2>&1
	@del /Q "C:/Ryuketsu2-Git/Server/%%x\locale" >nul 2>&1
	@mklink /D "C:/Ryuketsu2-Git/Server/%%x/locale" "C:/Ryuketsu2-Git/Server/share"
)
