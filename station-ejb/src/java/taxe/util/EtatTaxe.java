package taxe.util;

public class EtatTaxe {
    private double montantPaye;
    private double montantRestant;
    private int moisPayes;
    private int moisRestants;

    public EtatTaxe(double montantPaye, double montantRestant, int moisPayes, int moisRestants) {
        this.montantPaye = montantPaye;
        this.montantRestant = montantRestant;
        this.moisPayes = moisPayes;
        this.moisRestants = moisRestants;
    }

    public double getMontantPaye() { return montantPaye; }
    public double getMontantRestant() { return montantRestant; }
    public int getMoisPayes() { return moisPayes; }
    public int getMoisRestants() { return moisRestants; }
}
