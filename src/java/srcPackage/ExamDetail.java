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

public class ExamDetail {
    
   private String eName, time;
   private int id,tMarks;

    public ExamDetail(int id, String eName, int tMarks, String time) {
        this.id = id;
        this.eName = eName;
        this.tMarks = tMarks;        
        this.time = time;
    }

    public ExamDetail(String eName, int tMarks) {
        this.eName = eName;
        this.tMarks = tMarks;
    }


    public String getEName() {
        return this.eName;
    }

    public String getTime() {
        return this.time;
    }

    public int getId() {
        return this.id;
    }

    public int getTMarks() {
        return this.tMarks;
    }

}
