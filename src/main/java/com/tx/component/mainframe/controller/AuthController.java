/*
 * 描          述:  <描述>
 * 修  改   人:  PengQingyang
 * 修改时间:  2013-8-26
 * <修改描述:>
 */
package com.tx.component.mainframe.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tx.component.auth.model.AuthItem;
import com.tx.component.mainframe.service.AuthManageService;

/**
 * 权限显示层
 * <功能详细描述>
 * 
 * @author  PengQingyang
 * @version  [版本号, 2013-8-26]
 * @see  [相关类/方法]
 * @since  [产品/模块版本]
 */
@Controller("authControllerNew")
@RequestMapping("/auth")
public class AuthController {
    
    @Resource(name = "authManageService")
    private AuthManageService authManageService;
    
    /**
      * 跳转到查询权限视图<br/>
      *<功能详细描述>
      * @return [参数说明]
      * 
      * @return String [返回类型说明]
      * @exception throws [异常类型] [异常说明]
      * @see [类、类#方法、类#成员]
     */
    @RequestMapping("/toQueryAuthView")
    public String toQueryAuthView(ModelMap modelMap) {
        modelMap.put("authTypeList",
                this.authManageService.queryAuthTypeItem(true));
        return "/mainframe/queryAuthView";
    }
    
    /**
      * 根据当前人员权限类型与权限列表<br/> 
      *<功能详细描述>
      * @return [参数说明]
      * 
      * @return List<AuthItem> [返回类型说明]
      * @exception throws [异常类型] [异常说明]
      * @see [类、类#方法、类#成员]
      */
    @ResponseBody
    @RequestMapping("/queryAuthItemListMap")
    public List<AuthItem> queryAuthType2AuthItemListMap(
            @RequestParam("authType") String authType) {
        MultiValueMap<String, AuthItem> authType2AuthItemListMap = this.authManageService.queryCurrentPerpetualType2AuthMultiValueMap(true);
        
        List<AuthItem> resList = new ArrayList<AuthItem>();
        if (!authType2AuthItemListMap.containsKey(authType)) {
            return resList;
        } else {
            return authType2AuthItemListMap.get(authType);
        }
        
    }
    
}