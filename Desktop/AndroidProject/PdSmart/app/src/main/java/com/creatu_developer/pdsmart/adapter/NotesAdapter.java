package com.creatu_developer.pdsmart.adapter;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.text.Html;
import android.util.AndroidRuntimeException;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.creatu_developer.pdsmart.DetailActivity;

import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.innerpage.innerpage_fragments.Notes;
import com.creatu_developer.pdsmart.model.CompetitiveCourseModelClass;
import com.creatu_developer.pdsmart.model.notes_videos_model.NotesModelClass;

import java.util.List;

public class NotesAdapter
        extends RecyclerView.Adapter<NotesAdapter.MyViewHolder> {

    Context context;
    List<NotesModelClass> notesModelClassList;

    public NotesAdapter(Context context, List<NotesModelClass> notesModelClassList) {
        this.context = context;
        this.notesModelClassList = notesModelClassList;
    }

    @NonNull
    @Override
    public NotesAdapter.MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.fragment_notes, parent, false);
        return new MyViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull NotesAdapter.MyViewHolder holder, int position) {
        final NotesModelClass modelClass = notesModelClassList.get(position);


        holder.txt_Category.setText(Html.fromHtml(modelClass.getNotetitle()).toString().trim());
        holder.txt_read.setText("READ CHAPTER");

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                try{
                    Intent intent = new Intent(context, DetailActivity.class);
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

                    intent.putExtra("title",modelClass.getNotetitle());
                    intent.putExtra("desc",modelClass.getNotedescription());

                    context.startActivity(intent);
                }catch (AndroidRuntimeException e){
                    e.printStackTrace();
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return notesModelClassList.size();
    }

    class MyViewHolder extends RecyclerView.ViewHolder {

        TextView  txt_Category,txt_read;


        public MyViewHolder(View itemView) {
            super(itemView);


            txt_Category = itemView.findViewById(R.id.txt_category);
            txt_read = itemView.findViewById(R.id.txt_read_chapter);

        }
    }
}
