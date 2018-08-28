package com.creatu_developer.pdsmart.adapter;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.util.AndroidRuntimeException;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.creatu_developer.pdsmart.DetailActivity;
import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.innerpage.InnerActivity;
import com.creatu_developer.pdsmart.innerpage.innerpage_fragments.Notes;
import com.creatu_developer.pdsmart.model.CompetitiveCourseModelClass;

import java.util.List;

public class CompetitiveCourseAdapter extends RecyclerView.Adapter<CompetitiveCourseAdapter.MyViewHolder> {

    Context context;
    List<CompetitiveCourseModelClass> competitiveCourseModelClassList;

    public CompetitiveCourseAdapter(Context context, List<CompetitiveCourseModelClass> competitiveCourseModelClassList) {
        this.context = context;
        this.competitiveCourseModelClassList = competitiveCourseModelClassList;
    }

    @NonNull
    @Override
    public CompetitiveCourseAdapter.MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.fragment_competitive_course,parent,false);
        return new MyViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull CompetitiveCourseAdapter.MyViewHolder holder, int position) {
        final CompetitiveCourseModelClass modelClass = competitiveCourseModelClassList.get(position);

        holder.btn_paid.setText(modelClass.getPaid());
        holder.txt_price.setText(modelClass.getPrice());
        holder.txt_Category.setText("Category : "+modelClass.getCategory());
        holder.txt_bank.setText(modelClass.getBank());

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                try{
                    Intent intent = new Intent(context, InnerActivity.class);
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

                    intent.putExtra("title",modelClass.getBank());

                    context.startActivity(intent);
                }catch (AndroidRuntimeException e){
                    e.printStackTrace();
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return competitiveCourseModelClassList.size();
    }

    class MyViewHolder extends RecyclerView.ViewHolder{

        TextView txt_bank,txt_Category,txt_price;
        Button btn_paid;
        public MyViewHolder(View itemView) {
            super(itemView);

            txt_bank = itemView.findViewById(R.id.txt_bank);
            txt_Category = itemView.findViewById(R.id.txt_category);
            txt_price = itemView.findViewById(R.id.txt_price);
            btn_paid = itemView.findViewById(R.id.btn_paid);
        }
    }
}
