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
import android.widget.TextView;

import com.creatu_developer.pdsmart.DetailActivity;

import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.innerpage.VideoActivity;
import com.creatu_developer.pdsmart.model.notes_videos_model.NotesModelClass;
import com.creatu_developer.pdsmart.model.notes_videos_model.VideosModelClass;

import java.util.List;

public class VideosAdapter extends RecyclerView.Adapter<VideosAdapter.MyViewHolder> {

    Context context;
    List<VideosModelClass> videosModelClassList;

    public VideosAdapter(Context context, List<VideosModelClass> videosModelClassList) {
        this.context = context;
        this.videosModelClassList = videosModelClassList;
    }

    @NonNull
    @Override
    public MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.fragment_notes, parent, false);
        return new MyViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull VideosAdapter.MyViewHolder holder, int position) {
        final VideosModelClass modelClass = videosModelClassList.get(position);


        holder.txt_Category.setText(Html.fromHtml(modelClass.getVideodescription()).toString().trim());
        holder.txt_read.setText("Watch Video");

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                try{
                    Intent intent = new Intent(context, VideoActivity.class);
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

                    intent.putExtra("title",modelClass.getVideodescription());
                    intent.putExtra("video",modelClass.getVideo());

                    context.startActivity(intent);
                }catch (AndroidRuntimeException e){
                    e.printStackTrace();
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return videosModelClassList.size();
    }

    class MyViewHolder extends RecyclerView.ViewHolder {

        TextView txt_Category,txt_read;


        public MyViewHolder(View itemView) {
            super(itemView);


            txt_Category = itemView.findViewById(R.id.txt_category);
            txt_read = itemView.findViewById(R.id.txt_read_chapter);

        }
    }
}