<!-- PROJECT LOGO -->
<h1 align="center">Marc, payez et partez !</h1>
<div align="center">
  <img src="assets/MAARC.svg" alt="Logo" width="80" height="80">
</div>


<!-- Présentation du projet -->
# Présentation du projet

I - Problématique 

Côté distributeur : suite à la crise sanitaire, les grandes surfaces peinent à retrouver l’entièreté des consommateurs à l’intérieur des magasins. Des dispositifs tels que le drive, l’échange de services ont été mis en place pour diminuer la venue des consommateurs. Cependant, les consommateurs ne sont pas toujours satisfaits de ce qu’ils reçoivent. Allié l’indépendance et la rapidité satisferaient donc les consommateurs 

Côté consommateur : adepte des drives, vous aimez la rapidité. Or, vous avez des invités ce soir et vous avez besoin de cuisiner un bon repas ou bien d'acheter des produits de dernière minute. Cependant, vous n’avez pas beaucoup de temps et vous voulez être efficace. 
Marc est là pour vous aider ! Choisissez un plat ou préparez votre liste de course, scannez puis payez ! Tout ça grâce à votre ami Marc !

Présentation 
l’application Marc, payez et partez ! 

II - Cibles 

La cible marketing : les grandes surfaces, supermarché 
La cible communication : les consommateurs

Cibles principales : les grandes surfaces et les consommateurs 
Coeur de cible : les consommateurs
Cibles secondaires : les passionné(e)s de cuisine, restaurateurs …
 
III - Objectifs de l’application
Magasins : 
objectifs de fidéliser leurs clientèles, ramener leurs clients utilisant le drive à l'intérieur du magasin, obtenir de nous
Clients : 
gagner du temps, trouver des repas, pallier à la colère de leurs enfants durant les courses

# Fonctionnalités :

* Proposer des recettes “simples et rapides” avec des produits à récupérer dans le magasin par la suite.
  - L’utilisateur en se connectant dans l’application se retrouvera sur la page principale pour consulter les recettes qu’il veut réaliser.
  
* Suppression des produits déjà en possession
  - L’utilisateur pourra supprimer les produits qu’il a déjà en possession chez lui par exemple.
  
* Liste de courses : barre de recherche produits + intégration des catégories dans une liste
  - L’utilisateur pourra consulter les différentes catégories de produits et/ou choisir les produits en fonction de la catégorie (ex : Viandes, laitier, etc.).
  - Ou tout simplement taper dans la barre de recherche pour retrouver le produit directement sans passer par les catégories.

* Trouver mon magasin via la géolocalisation dans la ville où se situe l’utilisateur
  - L’utilisateur pourra retrouver l’adresse de son magasin de sa ville pour effectuer ses courses via une carte géolocalisée.
  
* Scanner produits avec le téléphone + paiement
  - L’utilisateur pourra scanner ses produits via le code barre pour les ajouter dans son panier au sein de son application et ainsi procéder directement au paiement avec l’application au lieu de passer par les caisses traditionnels ou les caisses rapides.
  
* Création et suppression de compte
  - L’utilisateur aura la possibilité de créer et de supprimer son compte de l’application.

<!-- Réalisé -->
# Réalisé avec ( + Version) :

* Flutter (docs, dev, widget, etc.) => 3.3.4
* Dart: 2.18.2
* DevTools: 2.15.0
* Supabase
* Stripe

# Packages (+ Version) :
* cupertino_icons: ^1.0.2
* http: ^0.13.5
* intl: ^0.17.0
* modal_bottom_sheet: ^2.0.1
* google_fonts: ^3.0.1
* flutter_bloc: ^8.1.1
* flutter_map: any
* flutter_map_marker_cluster: any
* flutter_map_radius_cluster: any
* kdbush: ^0.0.4
* latlong2: ^0.8.1
* flutter_spinkit: ^4.1.2
* loading_animation_widget: any
* flutter_svg: any
* flutter_barcode_scanner: ^2.0.0
* supabase_flutter: ^0.3.0
* crypto: ^3.0.1
* provider: ^6.0.1
* flutter_stripe: ^9.1.1

# Polices (+ Version) :
family: Hubballi / NiceSugar / RedHatDisplay

<!-- API utilisées -->
# API utilisées

Pour la réalisation de l'application "Marc, payez et partez !", j'ai utilisé l'API "spoonacular" permettant de récupérer les données JSON d'une ou plusieurs recettes de cuisines ainsi que des produits alimentaires.

Exemple de requêtes :

- Obtenir la liste des recettes : https://api.spoonacular.com/recipes/random?number=50&apiKey=
- Obtenir la liste des produits alimentaires : https://api.spoonacular.com/food/products/search?apiKey=&query=

Lien : [Spoonacular](https://spoonacular.com/)

# Prototype :
Lien : [Prototype]([https://spoonacular.com/](https://www.figma.com/proto/g351qI1BC3Mz60ERITvEZt/MARC-APPLICATION?type=design&node-id=88-599&scaling=scale-down&page-id=0%3A1&starting-point-node-id=39%3A132))

# Astuce :
* Pour une meilleure expérience utilisateur, afficher l'application directement sur votre mobile pour avoir un premier aperçu :)

# Présentation visuelle :
<div align="center">
  <img src="Capture écran - marc_projet/Capture_ecran_marc_1.png" width="400" height="600">
  <img src="Capture écran - marc_projet/Capture_ecran_marc_2.png" width="400" height="600">
</div>

