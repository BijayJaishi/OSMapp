package com.creatu_developer.pdsmart.adapter;

import android.content.Context;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.text.Html;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.model.Carousels;

import java.util.List;

public class ImageSliderAdapter extends PagerAdapter {


    private LayoutInflater layoutInflater;
    private Integer [] images = {R.drawable.roshan, R.drawable.roshan,R.drawable.roshan,R.drawable.pastaveg,R.drawable.roshan};
    private Context context;
    List<Carousels> carouselsList;

    public ImageSliderAdapter(Context context, List<Carousels> carouselsList) {
        this.context = context;
        this.carouselsList = carouselsList;
    }

    @Override
    public int getCount() {
        return carouselsList.size();
    }

    @Override
    public boolean isViewFromObject(View view, Object object) {
        return view == object;
    }

    @Override
    public Object instantiateItem(ViewGroup container, final int position) {

        Carousels carousels = carouselsList.get(position);

        layoutInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View view = layoutInflater.inflate(R.layout.viewpager_image, null);
        ImageView imageView = (ImageView) view.findViewById(R.id.imageView);
        TextView textView = view.findViewById(R.id.textView);
        imageView.setImageResource(images[position]);

        Glide.with(context).load(carousels.getImage()).placeholder(R.drawable.ic_camera_alt_black_24dp).error(R.drawable.ic_camera_alt_black_24dp).into(imageView);
        textView.setText(Html.fromHtml(carousels.getTitle()));

        ViewPager vp = (ViewPager) container;
        vp.addView(view, 0);
        return view;

    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {

        ViewPager vp = (ViewPager) container;
        View view = (View) object;
        vp.removeView(view);

    }
}

