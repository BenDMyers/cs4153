package edu.okstate.cs.bemy.mw03_myers_ben;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ListView;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity implements ChordViewAdapter.ItemClickListener {

    public ChordViewAdapter adapter;
    private ArrayList<Chord> chords = new ArrayList<Chord>();
    public Toolbar toolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        toolbar.setTitle("Ukulele Chords");
        setSupportActionBar(toolbar);

        initializeChords();

        // set up the RecyclerView
        RecyclerView recyclerView = (RecyclerView) findViewById(R.id.list);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        adapter = new ChordViewAdapter(this, chords);
        adapter.setClickListener(this);
        recyclerView.setAdapter(adapter);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    /**
     * Populates the 'chords' list
     */
    public void initializeChords() {
        chords.add(new Chord("A", 0, 0, 1, 2));
        chords.add(new Chord("B", 2, 2, 3, 4));
        chords.add(new Chord("C", 3, 0, 0, 0));
        chords.add(new Chord("D", 0, 2, 2, 2));
        chords.add(new Chord("E", 2, 0, 4, 1));
        chords.add(new Chord("F", 0, 1, 0, 2));
        chords.add(new Chord("G", 2, 3, 2, 0));
        chords.add(new Chord("Am", 0, 0, 0, 2));
        chords.add(new Chord("Bm", 2, 2, 2, 4));
        chords.add(new Chord("Cm", 3, 3, 3, 0));
        chords.add(new Chord("Dm", 0, 1, 2, 2));
        chords.add(new Chord("Em", 2, 3, 4, 0));
        chords.add(new Chord("Fm", 3, 1, 0, 1));
        chords.add(new Chord("Gm", 1, 3, 2, 0));
        chords.add(new Chord("A7", 0, 0, 1, 0));
        chords.add(new Chord("B7", 2, 2, 3, 2));
        chords.add(new Chord("C7", 1, 0, 0, 0));
        chords.add(new Chord("D7", 3, 2, 2, 2));
        chords.add(new Chord("E7", 2, 0, 2, 1));
        chords.add(new Chord("F7", 3, 1, 3, 2));
        chords.add(new Chord("G7", 2, 1, 2, 0));

    }

    @Override
    public void onItemClick(View view, int position) {
        Chord selected = chords.get(position);
        Intent intent = new Intent(getApplicationContext(), ChordActivity.class);
        intent.putExtra("name", selected.name);
        intent.putExtra("a", selected.aFret);
        intent.putExtra("c", selected.cFret);
        intent.putExtra("e", selected.eFret);
        intent.putExtra("g", selected.gFret);
        startActivity(intent);
    }
}

