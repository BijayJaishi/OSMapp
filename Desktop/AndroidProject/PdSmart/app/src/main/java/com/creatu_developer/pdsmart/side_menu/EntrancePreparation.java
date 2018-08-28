package com.creatu_developer.pdsmart.side_menu;


import android.content.Context;
import android.os.Bundle;
import android.support.design.widget.TabLayout;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.HorizontalScrollView;
import android.widget.TabHost;
import android.widget.TabWidget;
import android.widget.TextView;

import com.creatu_developer.pdsmart.FragmentPageAdapter;

import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.academic.BachelorFragment;
import com.creatu_developer.pdsmart.academic.MastersFragment;
import com.creatu_developer.pdsmart.academic.PlusTwoFragment;
import com.creatu_developer.pdsmart.entrance_preparation.BITFragment;
import com.creatu_developer.pdsmart.entrance_preparation.CSITFragment;
import com.creatu_developer.pdsmart.entrance_preparation.IeltsFragment;
import com.creatu_developer.pdsmart.required_class.TabLayoutWidth;

import java.util.ArrayList;
import java.util.List;

/**
 * A simple {@link Fragment} subclass.
 */
public class EntrancePreparation extends Fragment implements ViewPager.OnPageChangeListener,TabHost.OnTabChangeListener{

    View view;
    ViewPager viewPager;
    TabHost tabhost;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        view = inflater.inflate(R.layout.tab, container, false);

        initViewPager();
        initTabHost();
        return view;
    }

    private void initTabHost() {

        tabhost=(TabHost)view.findViewById(R.id.tabHost);
        tabhost.setup();

        String[] tabnames={
                "Ielts","CSIT","BIT"
        };

        for(int i=0;i<tabnames.length;i++){
            TabHost.TabSpec tabspec;
            tabspec=tabhost.newTabSpec(tabnames[i]);
            tabspec.setIndicator(tabnames[i]);
            tabspec.setContent(new FakeContent(getActivity()));
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
        HorizontalScrollView scrollView=(HorizontalScrollView)view.findViewById(R.id.h_scrollview);
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
        viewPager=(ViewPager) view.findViewById(R.id.view_pager);
        List<Fragment> fragmentList=new ArrayList<Fragment>();

        fragmentList.add(new CompetitiveCourse());
        fragmentList.add(new CompetitiveCourse());
        fragmentList.add(new CompetitiveCourse());


        FragmentPagerAdapter pagerAdapter=new FragmentPageAdapter(getChildFragmentManager(),fragmentList);
        viewPager.setAdapter(pagerAdapter);
        viewPager.setOnPageChangeListener(this);
    }


    @Override
    public void onResume() {
        super.onResume();
//        ((MainActivity) getActivity())
//                .setActionBarTitle("MarkSheet");

    }

}
