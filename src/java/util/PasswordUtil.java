/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author trant
 */
public class PasswordUtil {
     // Hash mật khẩu
    public static String hashPasswordBCrypt(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    // So sánh mật khẩu đã nhập với mật khẩu đã mã hóa
    public static boolean checkPassword(String plaintextPassword, String hashedPassword) {
        return BCrypt.checkpw(plaintextPassword, hashedPassword);
    }
}
