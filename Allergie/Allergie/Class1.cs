using System;
using System.Collections.Generic;

namespace Allergie
{
    public class Allergie
    {

        private List<string> aliments;
        private List<string> reactions;
        public Allergie()
        {
            aliments = new List<string>(new string[] { "crustace" , "oeuf" , "arachide" , "fruit a coques" , "fruits rouges" });

            reactions = new List<string>(new string[] { "rhinite", "urticaire", "oedeme de quincke", "choc anaphylactique" });
        }

        public void addReaction(String newReaction)
        {
            reactions.Add(newReaction);
        }
        public void addAliment(String newAliment)
        {
            aliments.Add(newAliment);
        }

        /// <summary>
        /// Donne la liste des reactions pour un aliment donné
        /// </summary>
        /// <param name="aliment">Aliment provoque quelle réaction</param>
        /// <returns>Liste des réactions</returns>
        public List<string> getReactions(String aliment)
        {
          return getContainsList(aliment,aliments,"reaction");
        }

        /// <summary>
        /// Donne la liste des aliments pour une reaction donnée
        /// </summary>
        /// <param name="reaction">Reaction provoqué par un aliment</param>
        /// <returns>Liste des aliments</returns>
        public List<string> getAliments(String reaction)
        {
            return getContainsList(reaction, reactions, "aliment");
        }

        /// <summary>
        /// Methode de recherche
        /// </summary>
        /// <param name="contains">mot à rechercher dans la liste</param>
        /// <param name="list">liste de recherche</param>
        /// <param name="type">type de liste de recherche</param>
        /// <returns>inverse de la liste de recherche si mot trouvé, sinon liste vide</returns>
        public List<string> getContainsList(String contains, List<string> list, string type)
        {
            List<string> tListReturn = new List<string>();

            foreach (string element in list)
            {
                if (element.Contains(contains))
                {
                    if (type == "aliment")
                    {
                        tListReturn = aliments;
                    }
                    else
                    {
                        tListReturn = reactions;
                    }
                }
            }

            return tListReturn;
        }
        public void Main(String[] args)
        {

        }

    }
}
