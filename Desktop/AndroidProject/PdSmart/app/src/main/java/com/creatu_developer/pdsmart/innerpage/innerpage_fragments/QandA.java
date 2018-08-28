package com.creatu_developer.pdsmart.innerpage.innerpage_fragments;


import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ProgressBar;


import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.adapter.PlusTwoCommerceAdapter;
import com.creatu_developer.pdsmart.adapter.QandA_adapter;
import com.creatu_developer.pdsmart.model.QANDAModel;

import java.util.ArrayList;
import java.util.List;

/**
 * A simple {@link Fragment} subclass.
 */
public class QandA extends Fragment {


   View view;
   List<QANDAModel> qandaModels;
   RecyclerView recyclerView;
   ProgressBar progressBar;


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        view = inflater.inflate(R.layout.recycler_view, container, false);
        recyclerView = view.findViewById(R.id.recycler_view);
        progressBar = view.findViewById(R.id.progress_bar);
        qandaModels = new ArrayList<>();

        qandaModels.add(new QANDAModel("1. Radiocarbon is produced in the atmosphere as a result of","collision between fast neutrons and nitrogen nuclei present in the atmosphere"));
        qandaModels.add(new QANDAModel("2. It is easier to roll a stone up a sloping road than to lift it vertical upwards because","work done in rolling a stone is less than in lifting it"));
        qandaModels.add(new QANDAModel("3. The nucleus of an atom consists of","protons and neutrons"));
        qandaModels.add(new QANDAModel("4. The number of moles of solute present in 1 kg of a solvent is called its","molality"));

        QandA_adapter adapter = new QandA_adapter(getActivity(),qandaModels);
        RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(getActivity());
        recyclerView.setLayoutManager(layoutManager);
        recyclerView.setAdapter(adapter);
        adapter.notifyDataSetChanged();
        progressBar.setVisibility(View.GONE);
        return view;
    }

}
