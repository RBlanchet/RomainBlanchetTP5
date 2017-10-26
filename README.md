# VMVagrant

## Avant de commencer

Afin que le script marche dans des conditions optimales, il est recommandé d'avoir déjà le fichier 'xenial.box' au même endroit que le script

## Description

Le script VMVagrant permet d'installer sur votre poste toutes les dépendances de Virtual Box ainsi que Vagrant.
Vous pourrez à l'issue de cette installation configurer votre Vagrant pour créer, lancer, arrêter ou supprimer vos VMVagrant

## Utilisation

Une fois le script télécharger vous devrez le mettre au même emplacement que votre <strong>xenial.box</strong>
Une fois cela effectué vous devrez le lancer via le terminal, un menu se présente alors :

<strong>1 - Installer VMBox et Vagrant :</strong>

En utilisant cette option, votre terminal va télécharger les dernières instances de Vagrant ainsi que de Virtual Box pour pouvoir continuer

<strong>2 - Créer une Vagrant :</strong>

Cette option permettra de créer une nouvelle Vagrant, il vous demandera le nom de votre Vagrant, le nom du dossier ainsi que le chemin du Synced Folder, une fois cela fait, il vous créera votre machine oppérationnelle

<strong>3 - Action sur le Vagrant :</strong>

A l'execution de ce menu, il vous mettra automatiquement la liste des Vagrant créer il vous mettra ensuite 4 sous menu<br/>  
     - Lister les Vagrant : Liste toutes les Vagrant disponible<br/> 
     - Lancer une Vagrant : Lance la vagrant que vous avez désigné par un 'id' présent dans la liste précedemment appelée<br/> 
     - Supprimer une Vagrant : Supprime la vagrant que vous avez désigné par un 'id' présent dans la liste précedemment appelée<br/> 
     - Arrêter une Vagrant : Arrête la vagrant que vous avez désigné par un 'id' présent dans la liste précedemment appelée<br/> 

