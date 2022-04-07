/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package srcPackage;

/**
 *
 * @author dhruv
 */

public class Exams {
    
    private int examId,tMarks,obtMarks;
    private String username,eName,date,examTime;

    public Exams(int examId, String username,String eName, int tMarks, int obtMarks, String examTime, String date) {
        this.examId = examId;
        this.username = username;
        this.eName=eName;
        this.tMarks = tMarks;
        this.obtMarks = obtMarks;
        this.date = date;
        this.examTime = examTime;
    }

    public int getExamId() {
        return this.examId;
    }

    public String getUsername() {
        return this.username;
    }

    public String getEName() {
        return this.eName;
    }

    public int getTMarks() {
        return this.tMarks;
    }

    public int getObtMarks() {
        return this.obtMarks;
    }

    public String getDate() {
        return this.date;
    }

    public String getExamTime() {
        return this.examTime;
    }

}