package com.creatu_developer.pdsmart.model;

public class CompetitiveCourseModelClass {
    private String paid;
    private String price;
    private String category;
    private String bank;

    public CompetitiveCourseModelClass(String bank) {
        this.bank = bank;
    }

    public String getPaid() {
        return paid;
    }

    public void setPaid(String paid) {
        this.paid = paid;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getBank() {
        return bank;
    }

    public void setBank(String bank) {
        this.bank = bank;
    }

    public CompetitiveCourseModelClass(String paid, String price, String category, String bank) {
        this.paid = paid;
        this.price = price;
        this.category = category;
        this.bank = bank;
    }
}
