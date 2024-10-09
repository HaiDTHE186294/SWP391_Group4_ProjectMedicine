/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.User;

/**
 *
 * @author DELL
 */
public class validateUser {
    public boolean validateUsers(User user) {
    // Kiểm tra email
    String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
    if (!user.getEmail().matches(emailPattern)) {
        System.out.println("Email không hợp lệ!");
        return false;
    }

    // Kiểm tra số điện thoại
    String phonePattern = "^0[0-9]{9,10}$";
    if (!user.getPhone().matches(phonePattern)) {
        System.out.println("Số điện thoại không hợp lệ!");
        return false;
    }

    // Nếu tất cả đều hợp lệ
    return true;
}
}
