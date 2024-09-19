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

change_hostname