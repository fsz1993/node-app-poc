func_build(){
    docker build -t poc/node-web-app:1.0.0 .
    echo "Remember to retag to the desired docker repo in use! Ex.: git tag poc/node-web-app:1.0.0 my-repo/node-web-app:1.0.0"
}

menu(){
    clear
    echo "#################################################"
    echo "#                  Menu                         #"
    echo "#################################################"
    PS3='Please enter your choice: '
    tput sgr0
    options=("Build" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "Build")
                echo -e "you chose choice $REPLY which is $opt"
                    func_build
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