package com.tca.entities;

public class Student {
    private Integer rno;
    private String name;
    private Double per;

    private String username;
    private String password;


    public Integer getRno() {
        return rno;
    }

    public void setRno(Integer rno) {
        this.rno = rno;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPer() {
        return per;
    }

    public void setPer(Double per) {
        this.per = per;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


    @Override
    public String toString() {
        return "Student [rno=" + rno + ", name=" + name + ", per=" + per +
                ", username=" + username + ", password=" + password + "]";
    }


}