<###_VIRTUALSAFE_CHANGE_TRACKING_START_###
U2FsdGVkX1+to1IIxl5A4fy5QYCpYrKaU68B1y8AjRNbTHUGhj7WQfDP/pBg1jK0
###_VIRTUALSAFE_CHANGE_TRACKING_END_###>
param(
  [string]$buildVersion = "continuous",
  [string]$vsVersion = "continuous",
  [string]$signtool = "signtool sign /sha1 6FDEC9DFCFE59E6BAEE64B7ED97F00E120E70D97 `$p"
)

$buildDir = Split-Path -Parent $PSCommandPath

<###_VIRTUALSAFE_CHANGE_TRACKING_START_###
U2FsdGVkX19czJ/DOhoQQt30XigquaSurhuJ86/UubthLUH6lv6+j6J/dhIcdC1J
###_VIRTUALSAFE_CHANGE_TRACKING_END_###>
Write-Output "`$buildVersion=$buildVersion"
Write-Output "`$vsVersion=$vsVersion"
Write-Output "`$signtool=$signtool"
Write-Output "`$buildDir=$buildDir"
Write-Output "`$Env:JAVA_HOME=$Env:JAVA_HOME"

if (-not (Test-Path $Env:JAVA_HOME)) {
    Write-Output "JAVA_HOME not set or does not exist: $Env:JAVA_HOME"
    exit 1;
}

if(-not (Test-Path $Env:JAVA_HOME\jmods\jdk.packager.jar)){
    Write-Output "$Env:JAVA_HOME\jmods\jdk.packager.jar does not exist. You need to patch your JDK installation with the jar provided under ./tools"
    exit 1;
}

if(-not (Test-Path $Env:JAVA_HOME\bin\jdk.packager.jar)){
    Write-Output "$Env:JAVA_HOME\bin\jdk.packager.jar does not exist. You need to patch your JDK installation with the jar provided under ./tools"
    exit 1;
}

if(-not (Test-Path $Env:JAVA_HOME\bin\jpackager.exe)){
    Write-Output "$Env:JAVA_HOME\bin\jpackager.exe does not exist. You need to patch your JDK installation with the exe provided under ./tools"
    exit 1;
}

if(-not (Test-Path "C:\Program Files (x86)\Resource Hacker\ResourceHacker.exe")){
    Write-Output "C:\Program Files (x86)\Resource Hacker\ResourceHacker.exe does not exist. Please install from http://www.angusj.com/resourcehacker."
    exit 1;
}

# cleanup
Remove-Item -Recurse -ErrorAction Ignore -Force buildkit.zip, app, libs

<###_VIRTUALSAFE_CHANGE_TRACKING_START_###
U2FsdGVkX19MFuzRQTgS8Lxsr1eqzQRU1iY7cjd4J9MfhDI/hFcOEz/t3wdp+X5Y
G8YsQ0WHaWI3w1orsruVPWZauG2kaCPGgMR3/LX3BOsTTJFxMJUvpQSFJWjOr82Y
###_VIRTUALSAFE_CHANGE_TRACKING_END_###>
<#
# configure stuff
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#>

<###_VIRTUALSAFE_CHANGE_TRACKING_START_###
U2FsdGVkX1/oC6xdDyQlJbgsk5jPAIE1odzKhQW11NOk/joiN6ld1BmN16snTRNg
0zhjIqvwvUO6+wjxaQ6SDuhOgE9rV8NHAEOxKhaoMHz/RMJq49nbqiWY+fHj4zQ6
###_VIRTUALSAFE_CHANGE_TRACKING_END_###>
<# download and extract buildkit
$buildkitUrl = "https://dl.bintray.com/cryptomator/cryptomator/${buildVersion}/buildkit-win.zip"
$wc = New-Object System.Net.WebClient
Write-Output "Downloading ${buildkitUrl}..."
$wc.Downloadfile($buildkitUrl, "buildkit.zip")
#>
Copy-Item "..\virtualsafe-based-on-cryptomator-1.4.10\main\buildkit\target\buildkit-win.zip" -Destination "buildkit.zip"
Expand-Archive -Path buildkit.zip -DestinationPath .
if (-not (Test-Path libs)) {
    Write-Output "libs/ does not exist. Buildkit damaged?"
    exit 1;
}

<###_VIRTUALSAFE_CHANGE_TRACKING_START_###
U2FsdGVkX18yLF8nOX1WCkODkC1hlduzTAB17CfSJlNry3n8MrY5m4urfx1MPf+X
iZZQXxv+UlqwSOdReWfvYqerIdg0znEl6SsbRH8jnFpalkxP6RdHcsMzZf1a3MWx
yuhHN916wEFcS0mluSHMiWMCj0PZ6smiCbq4RiusUnk+NR+0O+bydT3I4KLadtcP
###_VIRTUALSAFE_CHANGE_TRACKING_END_###>
# create application dir
& "$Env:JAVA_HOME\bin\jpackager" `
  create-image `
  --verbose `
  --echo-mode `
  --input libs `
  --output app `
  --name VirtualSAFE `
  --class org.cryptomator.launcher.Cryptomator `
  --main-jar launcher-$buildVersion.jar `
  --icon resources/app/VirtualSAFE.ico `
  --jvm-args "-Dcryptomator.logDir=`"~/AppData/Roaming/VirtualSAFE`"" `
  --jvm-args "-Dcryptomator.settingsPath=`"~/AppData/Roaming/VirtualSAFE/settings.json`"" `
  --jvm-args "-Dcryptomator.ipcPortPath=`"~/AppData/Roaming/VirtualSAFE/ipcPort.bin`"" `
  --jvm-args "-Dcryptomator.keychainPath=`"~/AppData/Roaming/VirtualSAFE/keychain.json`"" `
  --jvm-args "-Xss2m" `
  --jvm-args "-Xmx512m" `
  --identifier org.cryptomator `
  --version $vsVersion `
  --module-path `"$Env:JAVA_HOME\jmods`" `
  --add-modules java.base,java.logging,java.xml,java.sql,java.management,java.security.sasl,java.naming,java.datatransfer,java.security.jgss,java.rmi,java.scripting,java.prefs,java.desktop,jdk.unsupported `
  --strip-native-commands

<###_VIRTUALSAFE_CHANGE_TRACKING_START_###
U2FsdGVkX1/9TsiJBuu/R6igEkPw5BPnSIJ9zwK+k+GFAox63Re+Mn/oMIUp3HtZ
+nVpehnSa9zmHvKqpVfuhg==
###_VIRTUALSAFE_CHANGE_TRACKING_END_###>
# adjust .app
& 'attrib' -r 'app/VirtualSAFE/VirtualSAFE.exe'
<###_VIRTUALSAFE_CHANGE_TRACKING_START_###
U2FsdGVkX1/U3XRKixenWe8LZi8EKrwa3lK5+QMgIeLjlm73rpG2YbZTtJu9eGBD
sY2arM1G4FynbZ2lpOzgppBgJWg8gm/++5vMtLlkn4DKgECGlstJzlzNiRhO6qJZ
4loJNPg0+Dn5kipJo0cGVQ==
###_VIRTUALSAFE_CHANGE_TRACKING_END_###>
& 'C:\Program Files (x86)\Resource Hacker\ResourceHacker.exe' `
  -open "resources\resourcehacker\virtualsafe.rc" `
  -save "resources\resourcehacker\virtualsafe.res" `
  -action compile | Out-Null
& 'C:\Program Files (x86)\Resource Hacker\ResourceHacker.exe' `
  -open "app\VirtualSAFE\VirtualSAFE.exe" `
  -resource "resources\resourcehacker\virtualsafe.res" `
  -save "app\VirtualSAFE\VirtualSAFE.exe" `
  -action modify `
  -mask ",,,"
Copy-Item resources/app/dlls/* app/VirtualSAFE/

<###_VIRTUALSAFE_CHANGE_TRACKING_START_###
U2FsdGVkX186vZSCvd0RYx+4xCbcpLWnGh3LPb04cpBaGMwxL/2C4Ig+rT9Ts8Zx
yxo6PcvHg7NXcgYG88LGnQ==
###_VIRTUALSAFE_CHANGE_TRACKING_END_###>
Copy-Item resources/innosetup/Dokan_x64.msi app/

<###_VIRTUALSAFE_CHANGE_TRACKING_START_###
U2FsdGVkX18TClKM5D3oYSuMVKJ6djKNGu9QzlO4JmBohLsIOaQ5YzDQbnGuXbPC
VoeXUC++lJCYH6B8MURetrslJz9izonIBqwPEJ1Wk7lKFvAEVs5+J4JqBmg07jr8
s3vDIjktThVsHT6BpqTXIWunvD8iwUMsaVicP3+arQWQ6igCzqgPJ/BNzWyEXeBS
1HQqfPVEw7mkemiSXS3y4Z8M0dDFUEZpm7yee5hYd9bukXpXR2glNKrAwrIgUdr4
MsWKEjSBp4LY7d819q7QMVBwP99RsJWCdEuUClyd6QaDiSWO5OTXdewn1n29hjQ/
Rx6MPubUkD4ZBX8kam1gSv3d6kctIhUc5KJqZJ0lEaG3Rx4/P9j1afpTD0AALlk7
G/bajaQzGjHj4ZKAQTUTeoH29AZJN5Jcg1wkrdtyx0E=
###_VIRTUALSAFE_CHANGE_TRACKING_END_###>
<#
# build installer
Copy-Item -Recurse resources/innosetup/* app/
Set-Location app/
$env:CRYPTOMATOR_VERSION = "$buildVersion"
& 'C:\Program Files (x86)\Inno Setup 5\ISCC.exe' setup.iss /Qp "/sdefault=`"$signtool`""
#>
