#! /usr/bin/env bash

printf "script para automação de downloads de pc novos - KCL Tecnologia\n"

script_diretorio=$(dirname "$0")
echo "Esse script está sendo rodado na pasta: $script_diretorio"
read


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
        $script_diretorio/Reader_br_install.exe
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


office_365




read