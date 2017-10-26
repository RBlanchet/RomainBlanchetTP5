
# On initliase une variable qui permet de commencer la boucle while
while_var=true

# On initialise une boucle while qui continuera de boucler tant que
# la varibla $while_var sera vraie

while [ "$while_var" = true ]
  do
    echo '=================================================================================='
    echo "= Bonjour et bienvenue dans l'installation, pour commencer saisissez votre choix ="
    echo '=================================================================================='
    echo '1. Installer Vm Box et Vagrant'
    echo '2. Créer une Vagrant'
    echo '3. Action sur les Vagrant'
    echo 'Q. Quitter'
    echo ''

    # On initialise une variable pour le switch case
    read var_choice
    # On initialise un switch case pour les choix
    case "$var_choice" in
      # INSTALLATION
      "1")
        echo ''
        # On installe Vmbox // J'utilise la version 5.1 pour qu'il n'y ai pas d'incompatibilité avec la dernière Màj
        sudo apt-get install virtualbox-5.1 2> errors.sh || echo "\e[31mDésolé une version de virtualbox est déjà présente sur votre ordinateur\e[0m"
        # On installe Vagrant
        sudo apt-get install vagrant 2> errors.sh || echo "Désolé une versione de Vagrant est déjà présente sur votre ordinateur"
        # On dit que tout est ok
        echo ''
        echo -e '\e[92mFelicitations, vous pouvez commencez à créer une Vagrant \e[0m'
        echo ''
        ;;
      # CONFIGURATION
      "2")
        echo ''
        # On initialise une boucle
        choice_2_while=true
        while [ "$choice_2_while" = true ]
          do
            echo ''
            echo "Votre Vagrant s'installera à l'endroit ou vous avez executer le script, voulez-vous continuer ? [Oui = O / Non = N]"
            echo ''
            read var_continue
            # On effectue une condition pour check si le 'o' est en majuscule ou en minuscule
            if [ "$var_continue" = 'o' ] || [ "$var_continue" = 'O' ]
              then
                # On initialise les variables de dossier, data et synced folder
                echo ''
                echo 'Comment souhaitez-vous appelez votre Vagrant ?'
                echo ''
                read var_name_vagrant
                # On initialise une variable pour voir si il a projeté une erreur
                error_directory=false
                # On execute la commande
                mkdir "$var_name_vagrant" 2> errors.sh || error_directory=true
                if [ "$error_directory" = true ]
                then
                  echo -e "\n\e[31mDossier déjà existant, annulation du processus ...\e[0m\n"
                  break;
                fi
                cd "$var_name_vagrant"

                echo ''
                echo 'Comment souhaitez-vous appelez votre dossier data ?'
                echo ''
                read var_data_vagrant
                # On initialise une variable pour voir si il a projeté une erreur
                error_data_directory=false
                # On execute la commande
                mkdir "$var_data_vagrant" 2> errors.sh || error_data_directory=true
                # Il y'a peu de chance que sa arrive mais vaut mieux prévenir que guerrir
                if [ "$error_data_directory" = true ]
                then
                  echo -e "\n\e[31mLe nom que vous avez donnez au dossier existe déjà, annulation du processus ...\e[0m\n"
                  break;
                fi

                echo ''
                echo "Dans quel chemin voulez-vous que votre Sync Folder s'initliase. Nous vous conseillons '/var/www/'"
                echo ''
                read var_sync_folder

                # On initliase Vagrant
                vagrant init

                # On donne le choix à l'utilisateur entre plusieurs distributions (dans ce cas, on aura la même distribution pour les deux)
                echo ''
                echo 'Quel distribution voulez-vous installer ?'
                echo ''

                OPTIONSBIS="Xenial XenialBis"
          			select optBis in $OPTIONSBIS; do
            			if [ "$optBis" = "Xenial" ]
            			then
                    sed -i -e "s/config.vm.box = \"base\"/config.vm.box =\"xenial.box\"/g" Vagrantfile
                    sed -i -e "s/# config.vm.network \"private_network\", ip: \"192.168.33.10\"/config.vm.network \"private_network\", ip: \"192.168.33.10\"/g" Vagrantfile
                    # On modifie le delimiteur par un '=' pour pouvoir inclure les '/' dans notre action
                    sed -i -e "s=# config.vm.synced_folder \"../data\", \"/vagrant_data\"=config.vm.synced_folder \"$var_data_vagrant\", \"$var_sync_folder\"=g" Vagrantfile
                    # On up la vagrant pour qu'elle puisse apparaitre dans le status
                    echo ''
                    echo -e "\e[92mGeneration en cours ... \e[0m"
                    echo ''
                    vagrant up
                    # On arrete la boucle
                    choice_2_while=false
                    break;
            			elif [ "$optBis" = "XenialBis" ]
            			then
            				sed -i -e "s/config.vm.box =\"base\"/config.vm.box =\"xenial.box\"/g" Vagrantfile
                    sed -i -e "s/# config.vm.network \"private_network\", ip: \"192.168.33.10\"/ config.vm.network \"private_network\", ip: \"192.168.33.10\"/g" Vagrantfile
                    # On modifie le delimiteur par un '=' pour pouvoir inclure les '/' dans notre action
                    sed -i -e "s=# config.vm.synced_folder \"../data\", \"/vagrant_data\"=config.vm.synced_folder \"$var_data_vagrant\", \"$var_sync_folder\"=g" Vagrantfile
                    # On up la vagrant pour qu'elle puisse apparaitre dans le status
                    echo ''
                    echo -e "\e[92mGeneration en cours ...\e[0m"
                    echo ''
                    vagrant up
                    # On arrete la boucle
                    choice_2_while=false
                    break;
            			fi
          			done
            elif [ "$var_continue" = 'n' ] || [ "$var_continue" = 'N' ]
              then
                # On quitte la boucle
                choice_2_while=false
            else
              echo ''
              echo '============================================================'
              echo "= Hop Hop petit malin, on ne saisit QUE ce qui est demandé ="
              echo '============================================================'
              echo ''
            fi
          done
        ;;
      # ACTION SUR LES VAGRANT
      "3")
        echo ''
        echo "Voici les vagrant installer"
        echo ''
        # On execute la commande qui affiche les Vagrant
        vagrant global-status --prune
        echo ''
        echo "Que voulez-vous faire ?"
        echo "1. Lister les Vagrant"
        echo "2. Lancer une vagrant"
        echo "3. Supprimer une vagrant"
        echo "4. Arrêter une vagrant"
        echo ''
        choice_3_while=true
        while [ "$choice_3_while" = true ]
        do
          read var_choice_vagrant
          case "$var_choice_vagrant" in
            "1")
              # On execute la commande qui affiche les Vagrant
              vagrant global-status --prune
              ;;
            "2")
              echo ''
              echo "VOUS DEVEZ VOUS SAISIR DE L'ID DE LA VAGRANT A LANCER"
              echo "Quelle Vagrant voulez-vous lancer ?"
              echo ''
              read var_launch_vagrant
              echo ''
              # On initialise une variable pour l'erreur
              vagrant_up_ssh_error=false
              vagrant up "$var_launch_vagrant" 2> errors.sh || vagrant_up_ssh_error=true
              vagrant ssh "$var_launch_vagrant" 2> errors.sh || vagrant_up_ssh_error=true
              if [ "$vagrant_up_ssh_error" = true ]
              then
                echo -e "\n\e[31mVous tentez de démarrer une box inexistante, annulation du processus ...\e[0m\n"
                break;
              fi
              break;
              ;;
            "3")
              destroy_while=true
              while [ "$destroy_while" = true ]
              do
                echo ''
                echo -e "\e[91m! VOUS VOUS APPRETEZ A SUPPRIMER UNE VAGRANT VOULEZ-VOUS CONTINUER ? [O = Oui / N = Non]\e[0m"
                echo ''
                # On demande a l'utilisateur si il est sur
                read var_continue_destroy
                echo ''
                # On effectue une condition pour check si le 'o' est en majuscule ou en minuscule
                if [ "$var_continue_destroy" = 'o' ] || [ "$var_continue_destroy" = 'O' ]
                then
                  echo ''
                  echo "VOUS DEVEZ VOUS SAISIR DE L'ID DE LA VAGRANT A LANCER"
                  echo "Quelle Vagrant voulez-vous lancer ?"
                  echo ''
                  # On demande a l'utilisateur l'id de la vagrant a supprimer
                  read var_destroy_vagrant
                  echo ''
                  # On execute la commande
                  vagrant destroy "$var_destroy_vagrant" 2> errors.sh || echo -e "\n\e[91mAucune Vagrant correspond à ce que vous avez saisis\e[0m\n"
                  # On arrete la boucle
                  choice_3_while=false
                  break;
                elif [ "$var_continue_destroy" = 'n' ] || [ "$var_continue_destroy" = 'N' ]
                then
                  # On arrete la boucle
                  choice_3_while=false
                  break;
                else
                  echo ''
                  echo '============================================================'
                  echo "= Hop Hop petit malin, on ne saisit QUE ce qui est demandé ="
                  echo '============================================================'
                  echo ''
                fi
              done
              ;;
            "4")
              echo ''
              echo "VOUS DEVEZ VOUS SAISIR DE L'ID DE LA VAGRANT A ARRETER"
              echo "Quelle Vagrant voulez-vous arrêter ?"
              echo ''
              read var_halt_vagrant
              echo ''
              # On initialise une variable pour l'erreur
              vagrant_halt_error=false
              vagrant halt "$var_halt_vagrant" 2> errors.sh || vagrant_halt_error=true
              if [ "$vagrant_halt_error" = true ]
              then
                echo -e "\n\e[31mVous tentez d'arrêter une box inexistante, annulation du processus ...\e[0m\n"
                break;
              fi
              break;
              ;;
            esac
        done
        ;;
      # QUITTER
      "q")
        echo ''
        echo '==================='
        echo '= Bonne journée ! ='
        echo '==================='
        echo ''
        #  On arrete la boucle
        while_var=false
        ;;
      # QUITTER
      "Q")
        echo ''
        echo '==================='
        echo '= Bonne journée ! ='
        echo '==================='
        echo ''
        # On arrete la boucle
        while_var=false
        ;;
      # SI L'UTILISATEUR MET UN AUTRE CARACTERE
      *)
        echo ''
        echo '============================================================'
        echo "= Hop Hop petit malin, on ne saisit QUE ce qui est demandé ="
        echo '============================================================'
        echo ''
        ;;
    esac
  done
