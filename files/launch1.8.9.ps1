$host.UI.RawUI.WindowTitle = "Lc Cracked+"

$ConfigFilePath = "$env:userprofile\.lunarclient\config.txt"
$RamAllocationFilePath = "$env:userprofile\.lunarclient\ramallocation.txt"

Write-Host ""
Write-Host ".____            _________                       __              .___            "
Write-Host "|    |    ____   \_   ___ \____________    ____ |  | __ ____   __| _/    .__     "
Write-Host "|    |  _/ ___\  /    \  \/\_  __ \__  \ _/ ___\|  |/ // __ \ / __ |   __|  |___ "
Write-Host "|    |__\  \___  \     \____|  | \// __ \\  \___|    <\  ___// /_/ |  /__    __/ "
Write-Host "|_______ \___  >  \______  /|__|  (____  /\___  >__|_ \\___  >____ |     |__|    "
Write-Host "        \/   \/          \/            \/     \/     \/    \/     \/             "

Write-Host ""

Write-Host -ForegroundColor Red "Lunar Client Cracked - Agent by Nilsen84" -NoNewline
Write-Host -ForegroundColor Green " - 1.8.9" -NoNewline
Write-Host -ForegroundColor Cyan " - Modified by Mrn1"

$playerName = Get-Content $ConfigFilePath

$weaveModsFolderPath = "$env:userprofile\.weave\mods"
$jarFiles = Get-ChildItem -Path $weaveModsFolderPath -Filter "*.jar"
$modCount = $jarFiles.Count

if ($modCount -eq 1) {
    Write-Host "$modCount mod found - Version Supported by Weave" -ForegroundColor Green
} else {
    Write-Host "$modCount mods found - Version Supported by Weave" -ForegroundColor Green
}

$weaveLoaderReleaseUrl = "https://api.github.com/repos/Weave-MC/Weave-Loader/releases/latest"
$weaveLoaderReleaseInfo = Invoke-RestMethod -Uri $weaveLoaderReleaseUrl
$weaveLoaderDownloadUrl = $weaveLoaderReleaseInfo.assets[0].browser_download_url

$weaveLoaderPath = "C:\Users\$($env:UserName)\.lunarclient\" + $weaveLoaderReleaseInfo.tag_name + ".jar"

$weaveModsFolderPath = "$env:userprofile\.weave\mods"
$jarFiles = Get-ChildItem -Path $weaveModsFolderPath -Filter "*.jar"

if (-not (Test-Path "$env:userprofile\.lunarclient\CrackedAccount.jar")) {
    Write-Host "Downloading Agent"
    Invoke-WebRequest -Uri "https://github.com/Nilsen84/lunar-client-agents/releases/download/v1.2.0/CrackedAccount.jar" -OutFile "$env:userprofile\.lunarclient\CrackedAccount.jar"
}

if (-not (Test-Path $weaveLoaderPath)) {
    Write-Host "Downloading Weave Loader Agent"
    Invoke-WebRequest -Uri $weaveLoaderDownloadUrl -OutFile $weaveLoaderPath
}

# Read memory allocation values from the ramallocation.txt file
if (Test-Path $RamAllocationFilePath) {
    $ramAllocationValues = Get-Content $RamAllocationFilePath
    $Xms = "-Xms$ramAllocationValues`m"
    $Xmx = "-Xmx$ramAllocationValues`m"
    $Xmn = "-Xmn$ramAllocationValues`m"
} else {
    $Xms = "-Xms1G"
    $Xmx = "-Xmx4000m"
    $Xmn = "-Xmn768m"
}

$javaJre = (Resolve-Path "$env:userprofile\.lunarclient\jre\*\zulu17*\bin")[0]
cd "$env:userprofile\.lunarclient\offline\multiver"

# Arguments
$launchArgs = "--add-modules", "jdk.naming.dns", "--add-exports", "jdk.naming.dns/com.sun.jndi.dns=java.naming",
              "-Djna.boot.library.path=$env:userprofile\.lunarclient\offline\multiver\natives", "-Dlog4j2.formatMsgNoLookups=true",
              "--add-opens", "java.base/java.io=ALL-UNNAMED", "-javaagent:$env:userprofile\.lunarclient\CrackedAccount.jar=$playerName",
              "-javaagent:$weaveLoaderPath", $Xms, $Xmx, $Xmn,
              "-XX:+DisableAttachMechanism", "-Djava.library.path=$env:userprofile\.lunarclient\offline\multiver\natives",
              "-cp", "lunar-lang.jar;lunar-emote.jar;lunar.jar;optifine-0.1.0-SNAPSHOT-all.jar;v1_8-0.1.0-SNAPSHOT-all.jar;common-0.1.0-SNAPSHOT-all.jar;genesis-0.1.0-SNAPSHOT-all.jar;$weaveLoaderPath",
              "com.moonsworth.lunar.genesis.Genesis", "--version", "1.8.9", "--accessToken", "0", "--assetIndex", "1.8"

if ($args[1]) {
    $launchArgs += '--gameDir', $args[1]
}

$launchArgs += "--userProperties", "{}", "--texturesDir", "$env:userprofile\.lunarclient\textures", "--width", "854", "--height", "480",
               "--ichorClassPath", "lunar-lang.jar,lunar-emote.jar;lunar.jar;optifine-0.1.0-SNAPSHOT-all.jar;v1_8-0.1.0-SNAPSHOT-all.jar;common-0.1.0-SNAPSHOT-all.jar;genesis-0.1.0-SNAPSHOT-all.jar",
               "--ichorExternalFiles", "OptiFine_v1_8.jar", "--workingDirectory", ".", "--classpathDir",
               "$env:userprofile\.lunarclient\offline\multiver"

& "$javaJre\java.exe" $launchArgs
