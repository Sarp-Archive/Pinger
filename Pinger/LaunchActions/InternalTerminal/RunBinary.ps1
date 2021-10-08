$ProjectName = (get-item . ).Name
powershell.exe -nologo -noprofile -command ".\bin\${ProjectName}.exe"