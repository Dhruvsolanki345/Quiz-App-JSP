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

public class Questions {

    private int questionId;
    private String question,opt1,opt2,opt3,opt4,correct,eName;

    public Questions(int questionId, String question, String eName, String opt1, String opt2, String opt3, String opt4, String correct) {
        this.questionId = questionId;
        this.question = question;
        this.opt1 = opt1;
        this.opt2 = opt2;
        this.opt3 = opt3;
        this.opt4 = opt4;
        this.correct = correct;
        this.eName = eName;
    }

    public int getQuestionId() {
        return this.questionId;
    }

    public String getQuestion() {
        return this.question;
    }

    public String getOpt1() {
        return this.opt1;
    }

    public String getOpt2() {
        return this.opt2;
    }

    public String getOpt3() {
        return this.opt3;
    }

    public String getOpt4() {
        return this.opt4;
    }

    public String getCorrect() {
        return this.correct;
    }

    public String getEName() {
        return this.eName;
    }

}
