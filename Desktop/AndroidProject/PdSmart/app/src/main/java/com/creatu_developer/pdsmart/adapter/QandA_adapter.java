package com.creatu_developer.pdsmart.adapter;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;


import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.model.QANDAModel;

import java.util.List;

public class QandA_adapter extends RecyclerView.Adapter<QandA_adapter.MyViewHolder> {

    Context context;
    List<QANDAModel> qandaModelList;

    public QandA_adapter(Context context, List<QANDAModel> qandaModelList) {
        this.context = context;
        this.qandaModelList = qandaModelList;
    }

    @NonNull
    @Override
    public QandA_adapter.MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.fragment_qand,parent,false);

        return new MyViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull QandA_adapter.MyViewHolder holder, int position) {

        QANDAModel qandaModel = qandaModelList.get(position);
        holder.ans.setText("Answer : "+qandaModel.getAnswers());
        holder.ques.setText(qandaModel.getQuestions());

    }

    @Override
    public int getItemCount() {
        return qandaModelList.size();
    }

    class MyViewHolder extends RecyclerView.ViewHolder{
        TextView ques,ans;
        public MyViewHolder(View itemView) {
            super(itemView);
            ques = itemView.findViewById(R.id.txt_question);
            ans = itemView.findViewById(R.id.txt_answers);
        }
    }
}
