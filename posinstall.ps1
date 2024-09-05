#instala os packagemannegers, se já não estiverem instalados
function instalarPm {
    param (
        [string]$comando
    )

    if (!(Get-Command $comando -ErrorAction SilentlyContinue)) {
        if ($comando -eq "choco"){
            Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
            Write-Output "chocolatery foi instalado!"
        }
        
        elseif ($comando -eq "scoop") {
            Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
            Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
            Write-Output "scoop foi instalado!"
        }
    }

    else {
        Write-Output "$comando ja esta instalado"
    }
}

#instala pacotes do winget

$wingetPacotes = @(
    "operagx",
    "bytedance.capcut",
    "whatsapp",
    "microsoft.powertoys",
    "Microsoft.VisualStudioCode",
    "discord.discord",
    "valve.steam",
    "EpicGames.EpicGamesLauncher",
    "ntop",
    "golang.go",
    "roblox.roblox",
    "driverbooster",
    "afterburner",
    "cmake"
)

$wingetList = winget list

function instalarWinget {
    foreach($pacote in $wingetPacotes){
        if ($wingetList -match $pacote) {
            Write-Output "$pacote ja esta instalado"
        }
        else{
            winget install $pacote --accept-source-agreements --accept-package-agreements
        }
    }
}

#instala pacotes do chocolatery

$chocoPacotes = @(
    "python",
    "winfetch",
    "git",
    "mingw",
    "libreoffice",
    "gimp",
    "photogimp",
    "cpu-z"
)

$chocolist = choco list

function instalarChoco {
    foreach($pacote in $chocoPacotes){
        if ($chocolist -match $pacote) {
            Write-Output "$pacote ja esta instalado"
        }
        else{
            choco install $pacote -y
        }
    }
}

#instala pacotes do scoop

$scoopPacotes = @(
    "https://raw.githubusercontent.com/aandrew-me/tgpt/main/tgpt.json"
)

$scoopList = scoop list

function instalarScoop {
    foreach($pacote in $scoopPacotes){
        if ($scoopList -match $pacote){
            Write-Output "$pacote ja esta instalado"
        }else{
            scoop install $pacote
        }
    }
}

instalarPm("choco")
instalarPm("scoop")
instalarWinget
instalarChoco
instalarScoop