    echo "deseja instalar o Adobe Reader? Y/N"
    read install_adobe
    
    if [ "$install_adobe" = "Y" ]; then
        echo "Começando a instalação do Adobe Reader..."
        $script_diretorio/Reader_br_install.exe
    fi