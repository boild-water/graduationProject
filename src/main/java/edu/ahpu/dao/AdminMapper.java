package edu.ahpu.dao;

import edu.ahpu.pojo.Admin;

public interface AdminMapper {

	/**
	 * 根据phone和password查询admin
	 */
	Admin findAdminByPhoneAndPassword(Admin admin);

	/**
	 * 条件更新admin
	 */
	void updateAdminSelective(Admin admin);
	
	
	public Admin findAdmin(Long phone, String password);

	public Admin findAdminById(Integer id);

	public void updateAdmin(Admin admins);



}
