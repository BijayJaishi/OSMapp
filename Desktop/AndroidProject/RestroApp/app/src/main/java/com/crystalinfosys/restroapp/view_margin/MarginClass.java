package com.crystalinfosys.restroapp.view_margin;

import android.view.View;
import android.view.ViewGroup;

/**
 * Created by lokesh on 5/11/18.
 */

public class MarginClass {

    public void setMargins (View view, int left, int top, int right, int bottom) {
        if (view.getLayoutParams() instanceof ViewGroup.MarginLayoutParams) {
            ViewGroup.MarginLayoutParams p = (ViewGroup.MarginLayoutParams) view.getLayoutParams();
            p.setMargins(left, top, right, bottom);
            view.requestLayout();
        }
    }
}
