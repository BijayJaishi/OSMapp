package com.crystalinfosys.restroapp;

import android.app.FragmentManager;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Handler;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.crystalinfosys.restroapp.adapter.SlidingMenuAdapter;
import com.crystalinfosys.restroapp.modal.ItemSlideMenu;
import com.crystalinfosys.restroapp.side_menu.HomeFragment;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    boolean doubleBackToExitPressedOnce = false;
    private List<ItemSlideMenu> listSliding;
    RelativeLayout mainView, drawerView;
    private SlidingMenuAdapter adapter;
    private ListView listViewSliding;
    private DrawerLayout drawerLayout;
    private ActionBarDrawerToggle toggle;
    Toolbar toolbar;
    TextView toolbar_title;
    ImageView drawer_image;
    String phone,password;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        listViewSliding = (ListView) findViewById(R.id.lv_sliding_menu);
        drawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawerView = (RelativeLayout) findViewById(R.id.Drawer_View);
        mainView = (RelativeLayout) findViewById(R.id.mainView);
        toolbar_title = toolbar.findViewById(R.id.toolbar_title);
        drawer_image = toolbar.findViewById(R.id.toolbar_image);

        try{
            SharedPreferences sharedPreferences = getSharedPreferences("UserDetail", Context.MODE_PRIVATE);
            phone = sharedPreferences.getString("phone",null);
            password = sharedPreferences.getString("password","");

            if (!phone.equals("") && !password.equals("")){
                System.out.println("Phone : "+phone);
                Toast.makeText(this, "Phone : "+phone, Toast.LENGTH_SHORT).show();
            }

        }catch (NullPointerException e){

            e.printStackTrace();
        }

        listSliding = new ArrayList<>();

        listSliding.add(new ItemSlideMenu(R.drawable.ic_drawer, "Home"));
        listSliding.add(new ItemSlideMenu(R.drawable.ic_drawer, "Attendance"));
        listSliding.add(new ItemSlideMenu(R.drawable.ic_drawer, "Homework"));
        listSliding.add(new ItemSlideMenu(R.drawable.ic_drawer, "MarkSheet"));
        listSliding.add(new ItemSlideMenu(R.drawable.ic_drawer, "Notices"));
        listSliding.add(new ItemSlideMenu(R.drawable.ic_drawer, "Request Leave"));
        listSliding.add(new ItemSlideMenu(R.drawable.ic_drawer, "Post Complain"));
        listSliding.add(new ItemSlideMenu(R.drawable.ic_drawer, "LogOut"));

        adapter = new SlidingMenuAdapter(this, listSliding);
        listViewSliding.setAdapter(adapter);



        //Set title
        setTitle(listSliding.get(0).getTitle().replaceAll("Home", ""));
        //item selected
        listViewSliding.setItemChecked(0, true);
        //Close menu
        drawerLayout.closeDrawer(drawerView);

        //remove shadow from drawer

        drawerLayout.setScrimColor(getResources().getColor(android.R.color.transparent));

        //Display fragment 1 when start
        replaceFragment(0);
        //Hanlde on item click

        listViewSliding.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                //Set title
                setTitle(listSliding.get(position).getTitle());
                //item selected
                listViewSliding.setItemChecked(position, true);
                //Replace fragment
                replaceFragment(position);
                //Close menu
                drawerLayout.closeDrawer(drawerView);
                try {
                    InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
                    imm.hideSoftInputFromWindow(getCurrentFocus().getWindowToken(), 0);
                } catch (Exception e) {
                    // TODO: handle exception
                }
            }
        });

        toggle = new ActionBarDrawerToggle(
                this, drawerLayout, toolbar, R.string.drawer_opened, R.string.drawer_closed) {
            @Override
            public void onDrawerOpened(View drawerView) {
                super.onDrawerOpened(drawerView);


                invalidateOptionsMenu();
            }

            @Override
            public void onDrawerClosed(View drawerView) {
                super.onDrawerClosed(drawerView);


                invalidateOptionsMenu();
            }

            @Override
            public void onDrawerSlide(View drawerView, float slideOffset) {
                super.onDrawerSlide(drawerView, slideOffset);
                mainView.setTranslationX(slideOffset * drawerView.getWidth());
                drawerLayout.bringChildToFront(drawerView);


                drawerLayout.requestLayout();
            }

        };

        drawerLayout.setDrawerListener(toggle);
        toggle.setDrawerIndicatorEnabled(false);
       // toggle.setHomeAsUpIndicator(R.drawable.ic_drawer);
        drawer_image.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (drawerLayout.isDrawerVisible(GravityCompat.START)) {

                    drawerLayout.closeDrawer(GravityCompat.START);
                } else {
                    drawerLayout.openDrawer(GravityCompat.START);

                }
            }
        });

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (toggle.onOptionsItemSelected(item)) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
        toggle.syncState();
    }

    //Create method replace fragment

    private void replaceFragment(int pos) {
        getSupportActionBar().setTitle("");
        // Fragment fragment = null;
        android.support.v4.app.FragmentManager fragmentManager = getSupportFragmentManager();
        switch (pos) {

            case 0:
                toolbar_title.setText("Menu");

                fragmentManager.beginTransaction().replace(R.id.main_content,new HomeFragment()).commit();
                break;

            case 4:
                toolbar_title.setText("Menu");

                fragmentManager.beginTransaction().replace(R.id.main_content,new HomeFragment()).commit();
                break;


            default:

                break;

        }

    }

    @Override
    public void onBackPressed() {

        if (getSupportFragmentManager().getBackStackEntryCount() > 0) {
            getSupportFragmentManager().popBackStack();
        } else if (!doubleBackToExitPressedOnce) {
            this.doubleBackToExitPressedOnce = true;
            Toast.makeText(this, "Touch again to exit", Toast.LENGTH_SHORT).show();

            new Handler().postDelayed(new Runnable() {

                @Override
                public void run() {

                    doubleBackToExitPressedOnce = false;

                }
            }, 2000);
        } else {
            super.onBackPressed();
            return;
        }
    }

    @Override
    protected void onResume() {
        super.onResume();

    }
}
