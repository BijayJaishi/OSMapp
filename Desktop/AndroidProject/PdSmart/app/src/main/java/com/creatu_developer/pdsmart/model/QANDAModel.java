package com.creatu_developer.pdsmart.model;

public class QANDAModel {
    private String questions;
    private String answers;

    public QANDAModel(String questions, String answers) {
        this.questions = questions;
        this.answers = answers;
    }

    public String getQuestions() {
        return questions;
    }

    public void setQuestions(String questions) {
        this.questions = questions;
    }

    public String getAnswers() {
        return answers;
    }

    public void setAnswers(String answers) {
        this.answers = answers;
    }
}
