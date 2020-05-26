package edu.ahpu.service;

import edu.ahpu.pojo.Admin;

public interface AdminService {


    /**
     * 根据账号和密码查询admin
     */
    Admin findAdminByPhoneAndPassword(Admin admin);

    /**
     * 条件更新admin
     */
    void updateAdminSelective(Admin admin);


    Admin findAdmin(Long phone, String password);

    Admin findAdminById(Integer id);

    void updateAdmin(Admin admins);

}
