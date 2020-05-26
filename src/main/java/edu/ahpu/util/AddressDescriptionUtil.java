package edu.ahpu.util;

/**
 * 地址详细信息工具类
 * @author jinfei
 * @create 2020-04-10 19:44
 */
public class AddressDescriptionUtil {

    private String campusName;
    private String dormitoryBuilding;
    private String dormitoryNum;

    public String getCampusName() {
        return campusName;
    }

    public void setCampusName(String campusName) {
        this.campusName = campusName;
    }

    public String getDormitoryBuilding() {
        return dormitoryBuilding;
    }

    public void setDormitoryBuilding(String dormitoryBuilding) {
        this.dormitoryBuilding = dormitoryBuilding;
    }

    public String getDormitoryNum() {
        return dormitoryNum;
    }

    public void setDormitoryNum(String dormitoryNum) {
        this.dormitoryNum = dormitoryNum;
    }

    /**
     * 地址详细信息拼串
     */
    public String getDescription(){
        return this.campusName + "&" + this.dormitoryBuilding + "&" + this.dormitoryNum;
    }

    /**
     * 地址详细信息解串
     */
    public static AddressDescriptionUtil getAddressDescriptionUtil(String description){
        AddressDescriptionUtil addressDescriptionUtil = new AddressDescriptionUtil();
        String[] strings = description.split("&");
        addressDescriptionUtil.setCampusName(strings[0]);
        addressDescriptionUtil.setDormitoryBuilding(strings[1]);
        addressDescriptionUtil.setDormitoryNum(strings[2]);

        return addressDescriptionUtil;
    }
}
