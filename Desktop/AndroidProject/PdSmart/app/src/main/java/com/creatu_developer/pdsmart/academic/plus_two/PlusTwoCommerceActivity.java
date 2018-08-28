package com.creatu_developer.pdsmart.academic.plus_two;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.TextView;


import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.adapter.PlusTwoCommerceAdapter;
import com.creatu_developer.pdsmart.adapter.PlusTwoScienceAdapter;
import com.creatu_developer.pdsmart.dark_statusbar.DarkStatusBar;
import com.creatu_developer.pdsmart.model.CompetitiveCourseModelClass;

import java.util.ArrayList;
import java.util.List;

public class PlusTwoCommerceActivity extends AppCompatActivity {
    RecyclerView recyclerView;
    List<CompetitiveCourseModelClass> competitiveCourseList;
    Toolbar toolbar;
    TextView txt_toolbar_title;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_plus_two);

        toolbar = findViewById(R.id.tool_bar);
        txt_toolbar_title = toolbar.findViewById(R.id.toolbar_title);
        recyclerView = findViewById(R.id.recyclerView);

        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        txt_toolbar_title.setText("Management");

        // Dark Status Bar for Marshmallow

        Window window = getWindow();
        View view = window.getDecorView();
        DarkStatusBar.setLightStatusBar(view,this);

        competitiveCourseList = new ArrayList<>();

        competitiveCourseList.add(new CompetitiveCourseModelClass("Free","Free","Management (Class 11)","Nepali(Class 11)"));
        competitiveCourseList.add(new CompetitiveCourseModelClass("Paid","Rs. 5000","Management (Class 11)","Account(Class 11)"));
        competitiveCourseList.add(new CompetitiveCourseModelClass("Paid","Rs. 2000","Management (Class 11)","Economics(Class 11)"));
        competitiveCourseList.add(new CompetitiveCourseModelClass("Paid","Rs. 3000","Management (Class 11)","Mathematics(Class 11)"));
        competitiveCourseList.add(new CompetitiveCourseModelClass("Free","Free","Management (Class 11)","English(Class 11)"));
        competitiveCourseList.add(new CompetitiveCourseModelClass("Paid","Rs. 1000","Management (Class 11)","Computer(Class 11)"));


        PlusTwoScienceAdapter adapter = new PlusTwoScienceAdapter(getApplicationContext(),competitiveCourseList);
        RecyclerView.LayoutManager layoutManager = new GridLayoutManager(getApplicationContext(),2);
        recyclerView.setLayoutManager(layoutManager);
        recyclerView.setAdapter(adapter);
        adapter.notifyDataSetChanged();

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        switch (item.getItemId()){
            case android.R.id.home:
                finish();
                break;
        }
        return super.onOptionsItemSelected(item);
    }
}
