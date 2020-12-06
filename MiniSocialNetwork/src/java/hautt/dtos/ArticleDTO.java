/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.dtos;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *
 * @author SE130205
 */
public class ArticleDTO implements Serializable {

    private String id, email, title, description, image;
    private Timestamp date;
    private String status;
    private int numLike, numDislike;

    public ArticleDTO(String id, String email, String title, String description, String image, Timestamp date, String status, int numLike, int numDislike) {
        this.id = id;
        this.email = email;
        this.title = title;
        this.description = description;
        this.image = image;
        this.date = date;
        this.status = status;
        this.numLike = numLike;
        this.numDislike = numDislike;
    }

    public ArticleDTO(String id, String email, String title, String description, String image, Timestamp date, String status) {
        this.id = id;
        this.email = email;
        this.title = title;
        this.description = description;
        this.image = image;
        this.date = date;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getNumLike() {
        return numLike;
    }

    public void setNumLike(int numLike) {
        this.numLike = numLike;
    }

    public int getNumDislike() {
        return numDislike;
    }

    public void setNumDislike(int numDislike) {
        this.numDislike = numDislike;
    }

}
