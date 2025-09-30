class Meme {
  final String asset;// chemin de l'image dans le dossier img/
  final String top;//Texte en haut 
  final String bottom;//Texte en bas
  Meme(this.asset, this.top, this.bottom);
}

// Liste globale pour stocker les mèmes créés
final List<Meme> savedMemes = [];
