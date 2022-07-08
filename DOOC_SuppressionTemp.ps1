$array1 = @(Get-ChildItem -Path D:\Profils -Name) #Recupere tous les noms de dossier dans un tableau.
[System.Collections.ArrayList]$VHDX_ALL = $array1   #Change le type de tableau pour pouvoir le modifier
$VHDX_ALL.Remove('UVHD-template'+".vhdx")  #supprime la valeur qui ne nous interesse pas du tableau
$VHDX_ALL.Remove("UVHD-S-1-5-21-443697585-2139180038-671448135-500.vhdx")
$VHDX_ALL.Remove("UVHD-S-1-5-21-443697585-2139180038-671448135-1000.vhdx")
$VHDX_ALL.Remove("UVHD-S-1-5-21-1610557257-4114885241-1935438182-500.vhdx")
$VHDX_ALL.Remove("UVHD-S-1-5-21-1668510591-2779062798-1219217100-500.vhdx")
#$VHDX_ALL.Remove("")


#Dismount-DiskImage -ImagePath "F:\*" #Devrait théoriquement dismount tout image qui serait ouverte sur la VM04 mais j'ai peur que ca ferme aussi les sessions RDS...
foreach($vhdx in $VHDX_ALL)
{
    $path="D:\Profils\"
    $path2=$path+$vhdx
    Write-Host $path2
    Mount-DiskImage -ImagePath $path2
    Get-ChildItem -Path "F:\AppData\Local\Temp" -ErrorAction Ignore | Remove-Item -recurse -force
    Dismount-DiskImage -ImagePath $path2
}