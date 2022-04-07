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

public class User {

    private String name, userName, password, type, email;

    public User() {

    }

    public User(String userName, String name, String password, String email, String type) {
        this.name = name;
        this.userName = userName;
        this.password = password;
        this.type = type;
        this.email = email;
    }

    public String getName() {
        return this.name;
    }

    public String getUserName() {
        return this.userName;
    }

    public String getPassword() {
        return this.password;
    }

    public String getType() {
        return this.type;
    }

    public String getEmail() {
        return this.email;
    }

}
