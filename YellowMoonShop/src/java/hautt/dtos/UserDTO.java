/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.dtos;

import com.google.gson.annotations.SerializedName;
import java.io.Serializable;

/**
 *
 * @author SE130205
 */
public class UserDTO implements Serializable {

    @SerializedName(value = "userId")
    private String userID;
    @SerializedName(value = "id")
    private String facebookID;
    private String username, name, phone, address, roleID, roleName, status;

    public UserDTO() {
    }

    public UserDTO(String userID, String facebookID, String username, String name, String phone, String address, String roleName, String status) {
        this.userID = userID;
        this.facebookID = facebookID;
        this.username = username;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.roleName = roleName;
        this.status = status;
    }

    public UserDTO(String userID, String name, String phone, String address, String roleID) {
        this.userID = userID;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.roleID = roleID;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFacebookID() {
        return facebookID;
    }

    public void setFacebookID(String facebookID) {
        this.facebookID = facebookID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

}
