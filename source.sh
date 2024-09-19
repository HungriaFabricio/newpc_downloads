#! /usr/bin/env bash

printf "script para automação de downloads de pc novos - KCL Tecnologia\n"

script_diretorio=$(dirname "$0")
pc_serialnumber=$(wmic bios get serialnumber | grep -v "SerialNumber" | xargs)
echo "O número de série dessa máquina é $pc_serialnumber"
echo "Esse script está sendo rodado na pasta: $script_diretorio"

adobe_reader () {
    echo "esse sistema operacional é qual? 10/11, responder apenas com numero"
    read sistemaoperacional

    if [ "$sistemaoperacional" = "10" ]; then
        echo "fazendo download do Adobe Reader para windows 10"
        curl -L "https://admdownload.adobe.com/rdcm/installers/live/readerdc64_ha_cra_install.exe" -o "Reader_br_install.exe"
    elif [ "$sistemaoperacional" = "11" ]; then
        echo "fazendo download do Adobe Reader para windows 11"
        curl -L "https://admdownload.adobe.com/rdcm/installers/live/readerdc64_ha_cra_install.exe" -o "Reader_br_install.exe"
    else
        echo "valor inválido, tente novamente."
        adobe_reader
    fi

    echo "deseja instalar o Adobe Reader? Y/N"
    read install_adobe
    
    if [ "$install_adobe" = "Y" ]; then
        echo "Começando a instalação do Adobe Reader..."
        $script_diretorio/Reader_br_install.exe -S
    fi

    echo "saindo da instalação?"
}

office_365 () {
    echo "inicializando o download do Office 365"
    curl -L "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365BusinessRetail&platform=x64&language=pt-br&source=O15O365&version=O16GA" -o "OfficeSetup.exe"
    echo "começando a instalação do Office 365"
    $script_diretorio/OfficeSetup.exe

    echo "saindo da instalação"
}

hamachi_install() {
    echo "Inicializando o download do Hamachi"
    curl  -L "https://secure.logmein.com/hamachi.msi" -o "hamachi.msi"
    echo "Inicializando a instalação do Hamachi"
    msiexec -i "$script_diretorio\\hamachi.msi" -passive
}

chrome_install() {
    echo "Inicializando o download do Chrome"
    curl -L "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BA18FABEB-F788-9E79-D025-AE96D96CD1B2%7D%26lang%3Dpt-BR%26browser%3D4%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-statsdef_1%26installdataindex%3Dempty/update2/installers/ChromeSetup.exe" -o "ChromeSetup.exe"
    echo "Inicializando a instalação do Chrome"
    "$script_diretorio\\ChromeSetup.exe" -S
}

firefox_install() {
    echo "Inicializando o download do Firefox"
    curl -L "https://cdn.stubdownloader.services.mozilla.com/builds/firefox-stub/pt-BR/win/38eee40eb7400ae6c7ea1b9b610ca51b127c7b5653e0467d148439f2144e1d72/Firefox%20Installer.exe" -o "Firefox_Installer.exe"
    echo "Inicializando a instalação do Firefox"
    "$script_diretorio\\Firefox_Installer.exe" -S
}

anydesk_install() {
    echo "Inicializando o download do Anydesk"
    curl -L "https://download.anydesk.com/AnyDesk.exe" -o "AnyDesk.exe"
    echo "Inicializando a instalação do Anydesk"
    "$script_diretorio\\AnyDesk.exe" -S
}

dell_install() {
    echo "Inicializando o download do Kit de Suporte da Dell"
    curl -L "https://dl.dell.com/serviceability/eSupport/SupportAssistLauncher.exe?dl_uid=ea085462-5b0c-4911-9359-b689be5b27d8&dc=4014DFD1D3B874D7D65578B88FBB34BC&appname=ODE" -o "SupportAssistLauncher.exe"
    echo "Inicializando a instalação do SupportAssist da Dell"
    "$script_diretorio\\SupportAssistLauncher.exe" -S
}

change_hostname() {
    echo "Deseja efetuar a troca de hostname? (Y/N)"
    read hostnamechange

    if [ $hostnamechange = "Y" ] || [ $hostnamechange = "y" ] || [ $hostnamechange = "yes" ]; then
        echo "Efetuando a troca do hostname"
        powershell.exe Rename-Computer -NewName "$pc_serianumber" -Force
        echo "Deseja reiniciar seu computador agora? (Y/N)"
        read restartpc
        if [ $restartpc = "Y" ] || [ $restartpc = "y" ] || [ $restartpc = "yes" ]; then
            shutdown -r 1
            echo "Reinicinado em um minuto"
        elif [ $restartpc = "N" ] || [ $restartpc = "n" ] || [ $restartpc = "no" ]; then
            echo "Reinicialização pulada"
        else 
            echo "Valor inválido"
        fi
    elif [ $hostnamechange = "N" ] || [ $hostnamechange = "n" ] || [ $hostnamechange = "no" ]; then
        echo "Pulando mudança do hostname"
    else
        echo "Valor inválido"
    fi
    
}

user_choice() {
    local app_name=$1
    local install_function=$2
    echo "Deseja instalar $app_name? (Y/N)"
    read resposta

    if [ $resposta = "Y" ] || [ $resposta = "y" ] || [ $resposta = "yes" ]; then
        $install_function
    elif [ $resposta = "N" ] || [ $resposta = "n" ] || [ $resposta = "no" ]; then
        printf "Pulando a instalação..."
    else 
        printf "Valor inválido"
    fi
}

user_choice "Adobe Reader" adobe_reader
user_choice "Office 365" office_365
user_choice "Hamachi" hamachi_install
user_choice "Chrome" chrome_install
user_choice "Firefox" firefox_install
user_choice "Anydesk" anydesk_install
user_choice "Dell Support" dell_install
change_hostname 

read

