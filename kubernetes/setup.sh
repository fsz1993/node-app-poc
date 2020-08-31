func_deploy(){
    read -p "Environment: " ENV
    kubectl apply -k overlay/$ENV
}

func_destroy(){
    kubectl delete ns node-web-app
}

menu(){
    clear
    echo "#################################################"
    echo "#                  Menu                         #"
    echo "#################################################"
    PS3='Please enter your choice: '
    tput sgr0
    options=("Deploy" "Destroy" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
             "Deploy")
                 echo -e "you chose choice $REPLY which is $opt"
                    func_deploy
                 echo
                 ;;
              "Destroy")
                echo -e "you chose choice $REPLY which is $opt"
                    func_destroy
                echo
                ;;                
            "Quit")
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
        REPLY=
    done
}

menu