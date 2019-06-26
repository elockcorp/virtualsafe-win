@echo off
set JAVA_HOME=C:\Program Files\Java\jdk-11.0.2
rem echo BEFORE WE START: You need to manually update resources/resourcehacker/cryptomator.rc!
rem set /p GIT_TAG="Ready? Enter the Cryptomator version (as in the git tag): " || Set GIT_TAG=snapshot
Set GIT_TAG=1.4.10

set comment=goto endcomment
%comment%
###_VIRTUALSAFE_CHANGE_TRACKING_START_###
U2FsdGVkX18Phsg0WiFd6q384IuTTiuAxbVzVVjw52iOEezkmNkWY7v8vik2FjdE
zxvPlW6jx8E2I3EPuTzlQWz7FAPwNVvrhH2tJpa4zrW+tTfrpCIxu3tIdOeontrY
Dp3AY58F0cnkj3TjBVmf8e+pauQXgq2vIloyXj7hOx1cIWNqfQgmTZdfL9qcfvLu
7ve7OPaVa3IXaYvII2YBnegWi8gwPINcbxgZO+SP3pJIztZLCoEP6JcXTVkRjoYi
npr1uSccrMPBSDLyivC1UbKZFy3zZ/kwKrkSdgxMoNacw2QfzYiCuVH5LyOQ4m9f
tM3dA22CR+PflZxJM6H2eO+m94ld9g0vcyyj2a0jlm6kBXLJFoib+vKqecxrw4J9
MHY8OkOyp+8c8jALR6Ez8qnpZAFqrx+O+afUhuZIZynIWzC8I9VinVQSuiEE8+rN
iwdM6k2F1cJoji7qmd6v/OJ4T0V2QdEULFXi9veyqluqT625uKB+hJViNRcxfju9
###_VIRTUALSAFE_CHANGE_TRACKING_END_###
:endcomment

Set VSAFEVERSION=2.5.5

powershell -ExecutionPolicy Unrestricted -Command .\build.ps1 -buildVersion %GIT_TAG% -vsVersion %VSAFEVERSION% -signtool 'signtool sign /sha1 6FDEC9DFCFE59E6BAEE64B7ED97F00E120E70D97 $p'
