/*
 * 描          述:  <描述>
 * 修  改   人:  Administrator
 * 修改时间:  2014年2月19日
 * <修改描述:>
 */
package com.tx.component.mainframe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tx.component.configuration.context.ConfigContext;
import com.tx.component.configuration.model.ConfigProperty;
import com.tx.component.configuration.model.ConfigPropertyGroup;

/**
 * 配置属性控制器 <br/>
 * <功能详细描述>
 * 
 * @author  Administrator
 * @version  [版本号, 2014年2月19日]
 * @see  [相关类/方法]
 * @since  [产品/模块版本]
 */
@Controller("configurationController")
@RequestMapping("/configuration")
public class ConfigurationController {
    
    @Resource(name = "configContext")
    private ConfigContext configContext;
    
    /**
      * 查询配置属性页<br/>
      *<功能详细描述>
      * @return [参数说明]
      * 
      * @return String [返回类型说明]
      * @exception throws [异常类型] [异常说明]
      * @see [类、类#方法、类#成员]
     */
    @RequestMapping("toQueryConfigProperty")
    public String toQueryConfigProperty(ModelMap responseMap) {
        List<ConfigProperty> configPropertyList = configContext.getAllConfigProperty();
        MultiValueMap<String, ConfigProperty> configGroup2PropertyMap = new LinkedMultiValueMap<String, ConfigProperty>();
        if(!CollectionUtils.isEmpty(configPropertyList)){
            for(ConfigProperty configPropertyTemp : configPropertyList){
                configGroup2PropertyMap.add(configPropertyTemp.getConfigPropertyGroupName(), configPropertyTemp);
            }
        }
        
        //过滤掉配置组下不存在配置属性的配置组
        Map<String, List<ConfigProperty>> resMap = new HashMap<String, List<ConfigProperty>>();
        for(Entry<String, List<ConfigProperty>> entryTemp : configGroup2PropertyMap.entrySet()){
            if(CollectionUtils.isEmpty(entryTemp.getValue())){
                continue;
            }
            resMap.put(entryTemp.getKey(), entryTemp.getValue());
        }
        
        responseMap.put("configGroup2PropertyMap", resMap);
        return "/mainframe/queryConfigProperty";
    }
    
    /**
      * 查询所有的配置属性组
      *<功能详细描述>
      * @return [参数说明]
      * 
      * @return List<ConfigPropertyGroup> [返回类型说明]
      * @exception throws [异常类型] [异常说明]
      * @see [类、类#方法、类#成员]
     */
    @ResponseBody
    @RequestMapping("getAllConfigPropertyGroup")
    public List<ConfigPropertyGroup> getAllConfigPropertyGroup() {
        List<ConfigPropertyGroup> configPropertyGroupList = configContext.getAllConfigPropertyGroup();
        return configPropertyGroupList;
    }
    
}