# Build Script
# This script requires 7-zip (7z.exe) to be on your path

# Directory containing the mod source
$input = '.\src'
# Directory to output built files to
$build = '.\build'
# Factorio mods folder to install to
$install = "$($env:APPDATA)\Factorio\mods"

# Need name, version, and factorio_version from info.json
$info = Get-Content "$input\info.json" | Out-String | ConvertFrom-Json
# Mod must go in a folder named with this specific format
$folder = "$($info.name)_$($info.version)"
# Need an intermediate folder to arrange files before zipping to the output
$intermediate = "$build\$folder"
# Output zip file location
$output = "$build\$($info.factorio_version)\$folder.zip"

Write-Output $info $folder "$input -> $output -> $install"

# Copy input to intermediate, zip to output, then clear up after
Copy-Item $input -Destination $intermediate -Recurse
7z a $output $intermediate\
Remove-Item -Path $intermediate -Recurse

# Install output zip to mods folder
Copy-Item $output -Destination $install
