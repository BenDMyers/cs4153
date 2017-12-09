package edu.okstate.cs.bemy.mw03_myers_ben;

public class Chord {
    public String name;
    public int aFret;
    public int eFret;
    public int cFret;
    public int gFret;

    public Chord(String n, int a, int e, int c, int g) {
        name = n;
        aFret = a;
        eFret = e;
        cFret = c;
        gFret = g;
    }

    @Override
    public String toString() {
        return name;
    }

    public String fretsToString() {
        return "" + gFret + "" + eFret + "" + cFret + "" + aFret;
    }
}
