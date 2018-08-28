package com.creatu_developer.pdsmart.innerpage;

import android.content.Context;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.HorizontalScrollView;
import android.widget.TabHost;
import android.widget.TabWidget;
import android.widget.TextView;

import com.creatu_developer.pdsmart.FragmentPageAdapter;

import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.academic.BachelorFragment;
import com.creatu_developer.pdsmart.academic.MastersFragment;
import com.creatu_developer.pdsmart.academic.PlusTwoFragment;
import com.creatu_developer.pdsmart.dark_statusbar.DarkStatusBar;
import com.creatu_developer.pdsmart.innerpage.innerpage_fragments.Notes;
import com.creatu_developer.pdsmart.innerpage.innerpage_fragments.QandA;
import com.creatu_developer.pdsmart.innerpage.innerpage_fragments.VideosFragment;
import com.creatu_developer.pdsmart.side_menu.Academic;

import java.util.ArrayList;
import java.util.List;

public class InnerActivity extends AppCompatActivity implements ViewPager.OnPageChangeListener,TabHost.OnTabChangeListener{

    ViewPager viewPager;
    TabHost tabhost;
    Toolbar toolbar;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_inner);

        toolbar = findViewById(R.id.tool_bar);

        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        String title = getIntent().getExtras().getString("title");


        getSupportActionBar().setTitle(title);

        // Dark Status Bar for Marshmallow

        Window window = getWindow();
        View view = window.getDecorView();
        DarkStatusBar.setLightStatusBar(view,this);

        initViewPager();
        initTabHost();
    }

    private void initTabHost() {
        tabhost=(TabHost)findViewById(R.id.tabHost);
        tabhost.setup();
        String[] tabnames={
                "Notes","Q & A","Videos"
        };

        for(int i=0;i<tabnames.length;i++){
            TabHost.TabSpec tabspec;
            tabspec=tabhost.newTabSpec(tabnames[i]);
            tabspec.setIndicator(tabnames[i]);
            tabspec.setContent(new FakeContent(getApplicationContext()));
            tabhost.addTab(tabspec);
        }

        TabWidget tw = (TabWidget)tabhost.findViewById(android.R.id.tabs);
        View tabView = tw.getChildTabViewAt(0);
        View tabView1 = tw.getChildTabViewAt(1);
        View tabView2 = tw.getChildTabViewAt(2);

        TextView tv = (TextView)tabView.findViewById(android.R.id.title);
        tv.setTextSize(15);
        TextView tv1 = (TextView)tabView1.findViewById(android.R.id.title);
        tv1.setTextSize(15);
        TextView tv2 = (TextView)tabView2.findViewById(android.R.id.title);
        tv2.setTextSize(15);
        tv.setAllCaps(false);
        tv1.setAllCaps(false);
        tv2.setAllCaps(false);

        for (int i = 0; i < tabhost.getTabWidget().getChildCount(); i++) {
            tabhost.getTabWidget().getChildAt(i).getLayoutParams().height /=1.2;

        }

        tabhost.setOnTabChangedListener(this);
    }

    @Override
    public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

    }

    @Override
    public void onPageSelected(int SelectedItem) {
        tabhost.setCurrentTab(SelectedItem);
    }

    @Override
    public void onPageScrollStateChanged(int state) {

    }

    @Override
    public void onTabChanged(String tabId) {
        int SelectedItem=tabhost.getCurrentTab();
        viewPager.setCurrentItem(SelectedItem);
        HorizontalScrollView scrollView=(HorizontalScrollView)findViewById(R.id.h_scrollview);
        View tabView=tabhost.getCurrentTabView();
        int scrollPos=tabView.getLeft()-(scrollView.getWidth()-tabView.getWidth())/2;
        scrollView.smoothScrollTo(scrollPos,0);
    }

    public class FakeContent implements TabHost.TabContentFactory{
        Context context;
        public FakeContent(Context mcontext){
            context=mcontext;
        }

        @Override
        public View createTabContent(String tag) {
            View fakeview=new View(context);
            fakeview.setMinimumHeight(0);
            fakeview.setMinimumWidth(0);
            return fakeview;
        }
    }

    private void initViewPager() {
        viewPager=(ViewPager) findViewById(R.id.view_pager);
        List<Fragment> fragmentList=new ArrayList<Fragment>();

        fragmentList.add(new Notes());
        fragmentList.add(new QandA());
        fragmentList.add(new VideosFragment());


        FragmentPagerAdapter pagerAdapter=new FragmentPageAdapter(getSupportFragmentManager(),fragmentList);
        viewPager.setAdapter(pagerAdapter);
        viewPager.setOnPageChangeListener(this);
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
