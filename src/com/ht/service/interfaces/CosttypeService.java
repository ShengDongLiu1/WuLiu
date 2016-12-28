package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Costtype;

public interface CosttypeService {
	int deleteByPrimaryKey(Integer cid);

    int insert(Costtype record);

    int insertSelective(Costtype record);

    Costtype selectByPrimaryKey(Integer cid);

    int updateByPrimaryKeySelective(Costtype record);

    int updateByPrimaryKey(Costtype record);
    
    /**
     * 查询所有费用类型
     * @param map
     * @return
     */
    List<Costtype> queryAll(Map<String ,Object> map);
    
    /**
     * 费用类型条数
     * @param map
     * @return
     */
    Long queryAllCount(Map<String ,Object> map);
}
