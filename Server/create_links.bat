@echo off

for %%x in (Datenbank, Loginserver, Channel1, Channel2, Channel3, Channel99) do (

	rmdir /q "C:/Ryuketsu2-Git/Server/%%x/share" >nul 2>&1
	@del /Q "C:/Ryuketsu2-Git/Server/%%x\share" >nul 2>&1
	@mklink /D "C:/Ryuketsu2-Git/Server/%%x/share" "C:/Ryuketsu2-Git/Server/share"
)
