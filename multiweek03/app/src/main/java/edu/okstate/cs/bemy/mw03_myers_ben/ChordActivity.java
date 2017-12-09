package edu.okstate.cs.bemy.mw03_myers_ben;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Toolbar;

public class ChordActivity extends AppCompatActivity {

    private int a, c, e, g;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chord);
        Intent intent = getIntent();
        setTitle(intent.getStringExtra("name"));
        a = intent.getIntExtra("a", 0);
        c = intent.getIntExtra("c", 0);
        e = intent.getIntExtra("e", 0);
        g = intent.getIntExtra("g", 0);
        Log.d("Frets", "" + g + e + c + a);

        switch(a) {
            case 1:
                findViewById(R.id.a1).setVisibility(View.VISIBLE);
                break;
            case 2:
                findViewById(R.id.a2).setVisibility(View.VISIBLE);
                break;
            case 3:
                findViewById(R.id.a3).setVisibility(View.VISIBLE);
                break;
            case 4:
                findViewById(R.id.a4).setVisibility(View.VISIBLE);
                break;
        }

        switch(c) {
            case 1:
                findViewById(R.id.c1).setVisibility(View.VISIBLE);
                break;
            case 2:
                findViewById(R.id.c2).setVisibility(View.VISIBLE);
                break;
            case 3:
                findViewById(R.id.c3).setVisibility(View.VISIBLE);
                break;
            case 4:
                findViewById(R.id.c4).setVisibility(View.VISIBLE);
                break;
        }

        switch(e) {
            case 1:
                findViewById(R.id.e1).setVisibility(View.VISIBLE);
                break;
            case 2:
                findViewById(R.id.e2).setVisibility(View.VISIBLE);
                break;
            case 3:
                findViewById(R.id.e3).setVisibility(View.VISIBLE);
                break;
            case 4:
                findViewById(R.id.e4).setVisibility(View.VISIBLE);
                break;
        }

        switch(g) {
            case 1:
                findViewById(R.id.g1).setVisibility(View.VISIBLE);
                break;
            case 2:
                findViewById(R.id.g2).setVisibility(View.VISIBLE);
                break;
            case 3:
                findViewById(R.id.g3).setVisibility(View.VISIBLE);
                break;
            case 4:
                findViewById(R.id.g4).setVisibility(View.VISIBLE);
                break;
        }
    }

    @Override
    public void onBackPressed() {
        finish();
    }
}
