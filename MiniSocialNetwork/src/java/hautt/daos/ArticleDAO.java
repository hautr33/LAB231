/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.daos;

import hautt.dtos.ArticleDTO;
import hautt.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author SE130205
 */
public class ArticleDAO {

    public boolean postArticle(ArticleDTO dto) throws ClassNotFoundException, NamingException, SQLException {
        boolean isPost = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblArticles(articleID, email, title, description, image, date, status) VALUES(?,?,?,?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getId());
                stm.setString(2, dto.getEmail());
                stm.setString(3, dto.getTitle());
                stm.setString(4, dto.getDescription());
                stm.setString(5, dto.getImage());
                stm.setTimestamp(6, dto.getDate());
                stm.setString(7, dto.getStatus());
                if (stm.executeUpdate() > 0) {
                    isPost = true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return isPost;
    }

    public List<ArticleDTO> getAllArticle(int curPage) throws ClassNotFoundException, NamingException, SQLException {
        List<ArticleDTO> result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT articleID, email, title, description, image, date, numLike, numDislike "
                        + "FROM tblArticles "
                        + "WHERE status = 'Active' "
                        + "ORDER BY date DESC "
                        + "OFFSET (? - 1) * 20 ROWS "
                        + "FETCH NEXT 20 ROWS ONLY";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, curPage);
                rs = stm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    String id = rs.getString("articleID");
                    String email = rs.getString("email");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String image = rs.getString("image");
                    Timestamp date = rs.getTimestamp("date");
                    int numLike = rs.getInt("numLike");
                    int numDislike = rs.getInt("numDislike");
                    result.add(new ArticleDTO(id, email, title, description, image, date, "Active", numLike, numDislike));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public List<ArticleDTO> searchArticle(String search, int curPage) throws ClassNotFoundException, NamingException, SQLException {
        List<ArticleDTO> result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT articleID, email, title, description, image, date, numLike, numDislike "
                        + "FROM tblArticles "
                        + "WHERE description LIKE ? AND status = 'Active' "
                        + "ORDER BY date DESC "
                        + "OFFSET (? - 1) * 20 ROWS "
                        + "FETCH NEXT 20 ROWS ONLY";
                stm = conn.prepareStatement(sql);
                stm.setString(1, "%" + search + "%");
                stm.setInt(2, curPage);
                rs = stm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    String id = rs.getString("articleID");
                    String email = rs.getString("email");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String image = rs.getString("image");
                    Timestamp date = rs.getTimestamp("date");
                    int numLike = rs.getInt("numLike");
                    int numDislike = rs.getInt("numDislike");
                    result.add(new ArticleDTO(id, email, title, description, image, date, "Active", numLike, numDislike));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public ArticleDTO getAnArticle(String id) throws ClassNotFoundException, NamingException, SQLException {
        ArticleDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT email, title, description, image, date, numLike, numDislike FROM tblArticles WHERE articleID = ? AND status = 'Active'";
                stm = conn.prepareStatement(sql);
                stm.setString(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String email = rs.getString("email");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String image = rs.getString("image");
                    Timestamp date = rs.getTimestamp("date");
                    int numLike = rs.getInt("numLike");
                    int numDislike = rs.getInt("numDislike");
                    result = new ArticleDTO(id, email, title, description, image, date, "Active", numLike, numDislike);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public boolean deleleArticle(String id) throws SQLException, ClassNotFoundException, NamingException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE tblArticles SET status = 'Deleted' WHERE articleID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, id);
                if (stm.executeUpdate() > 0) {
                    result = true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public boolean updateArticleEmotion(ArticleDTO dto, String status) throws SQLException, ClassNotFoundException, NamingException {
        boolean isUpdate = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (status.equals("Like")) {
                dto.setNumLike(dto.getNumLike() + 1);
            } else if (status.equals("Dislike")) {
                dto.setNumDislike(dto.getNumDislike() + 1);
            } else if (status.equals("UnLike")) {
                dto.setNumLike(dto.getNumLike() - 1);
            } else if (status.equals("UnDislike")) {
                dto.setNumDislike(dto.getNumDislike() - 1);
            } else if (status.equals("LikeToDislike")) {
                dto.setNumLike(dto.getNumLike() - 1);
                dto.setNumDislike(dto.getNumDislike() + 1);
            } else if (status.equals("DislikeToLike")) {
                dto.setNumDislike(dto.getNumDislike() - 1);
                dto.setNumLike(dto.getNumLike() + 1);
            }
            if (conn != null) {
                String sql = "UPDATE tblArticles SET numLike = ?, numDislike = ? WHERE articleID = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, dto.getNumLike());
                stm.setInt(2, dto.getNumDislike());
                stm.setString(3, dto.getId());
                if (stm.executeUpdate() > 0) {
                    isUpdate = true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return isUpdate;
    }
}
