$dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

. $(Join-Path $dest "functions.ps1")

$packageName = 'Atom' # arbitrary name for the package, used in messages
$url = 'https://github.com/bradgearon/atom/releases/download/v0.106.0/Atom.zip' # download url
$url64 = $url # 64bit URL here or just use the same as $url
Install-ChocolateyZipPackage "$packageName" "$url" "$dest" "$url64"

$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
$desktopLink = Join-Path $desktop "$packageName.lnk"
Install-ChocolateyShortcut -shortcutFilePath $desktopLink -targetPath "$dest\Atom.exe"

$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Programs))
$githubStartMenuGroup = Join-Path $desktop "GitHub, Inc"
New-Item $githubStartMenuGroup -type directory -force
$startMenuLink = Join-Path $githubStartMenuGroup "$packageName.lnk"
Install-ChocolateyShortcut -shortcutFilePath $startMenuLink -targetPath "$dest\Atom.exe"

Install-BinFile "apm" "$dest\resources\app\apm\node_modules\atom-package-manager\bin\apm.cmd"
