package edu.ahpu.service.impl;

import edu.ahpu.dao.AdminMapper;
import edu.ahpu.pojo.Admin;
import edu.ahpu.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper adminMapper;


	/**
	 * 根据账号和密码查询admin
	 */
	@Override
	public Admin findAdminByPhoneAndPassword(Admin admin) {
		return adminMapper.findAdminByPhoneAndPassword(admin);
	}

	/**
	 * 条件更新admin
	 */
	@Override
	public void updateAdminSelective(Admin admin) {
		adminMapper.updateAdminSelective(admin);
	}


	@Override
	public Admin findAdmin(Long phone, String password) {
		// TODO Auto-generated method stub
		return adminMapper.findAdmin(phone,password);
	}

	@Override
	public Admin findAdminById(Integer id) {
		// TODO Auto-generated method stub
		return adminMapper.findAdminById(id);
	}

	@Override
	public void updateAdmin(Admin admins) {
		adminMapper.updateAdmin(admins);
	}


	

}
