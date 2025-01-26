package taxe.util;

public class DateUtil {
    private static final String[] MOIS = {
        "Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", 
        "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"
    };
    
    public static String getMoisTexte(int mois) {
        return MOIS[mois - 1];
    }
    
    public static String getOptionsSelectMois(int moisSelectionne) {
        StringBuilder options = new StringBuilder();
        for (int i = 0; i < MOIS.length; i++) {
            options.append(String.format(
                "<option value=\"%d\"%s>%s</option>",
                i + 1,
                (i + 1 == moisSelectionne) ? " selected" : "",
                MOIS[i]
            ));
        }
        return options.toString();
    }
} 