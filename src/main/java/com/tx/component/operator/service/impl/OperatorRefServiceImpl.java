/*
 * 描          述:  <描述>
 * 修  改   人:  
 * 修改时间:  
 * <修改描述:>
 */
package com.tx.component.operator.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.ListUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.tx.component.operator.dao.OperatorRefDao;
import com.tx.component.operator.model.OperatorRef;
import com.tx.component.operator.service.OperatorRefService;
import com.tx.core.exceptions.util.AssertUtils;

/**
 * OperatorRef的业务层
 * <功能详细描述>
 * 
 * @author  
 * @version  [版本号, ]
 * @see  [相关类/方法]
 * @since  [产品/模块版本]
 */
@Component("operatorRefService")
public class OperatorRefServiceImpl implements OperatorRefService {
    
    @SuppressWarnings("unused")
    private Logger logger = LoggerFactory.getLogger(OperatorRefServiceImpl.class);
    
    @Resource(name = "operatorRefDao")
    private OperatorRefDao operatorRefDao;
    
    /**
      * 批量删除操作员引用id集合<br/>
      *<功能详细描述>
      * @param refType
      * @param operatorId
      * @param refIdList [参数说明]
      * 
      * @return void [返回类型说明]
      * @exception throws [异常类型] [异常说明]
      * @see [类、类#方法、类#成员]
     */
    private void batchDeleteRefIdList(String refType,
            String operatorId,List<String> refIdList){
        if(CollectionUtils.isEmpty(refIdList)){
            return ;
        }
        
        List<OperatorRef> operatorRefList = new ArrayList<OperatorRef>();
        for(String refIdTemp : refIdList){
            operatorRefList.add(new OperatorRef(operatorId, refIdTemp, refType));
        }
        
        batchDeleteOperatorRef(operatorRefList);
    }
    
    /**
      * 批量插入引用id集合<br/>
      *<功能详细描述>
      * @param refType
      * @param operatorId
      * @param refIdList [参数说明]
      * 
      * @return void [返回类型说明]
      * @exception throws [异常类型] [异常说明]
      * @see [类、类#方法、类#成员]
     */
    private void batchInsertRefIdList(String refType,
            String operatorId,List<String> refIdList){
        if(CollectionUtils.isEmpty(refIdList)){
            return ;
        }
        
        List<OperatorRef> operatorRefList = new ArrayList<OperatorRef>();
        for(String refIdTemp : refIdList){
            operatorRefList.add(new OperatorRef(operatorId, refIdTemp, refType));
        }
        
        batchInsertOperatorRef(operatorRefList);
    }
    
    /**
     * @param refType
     * @param operatorId
     * @param refIdList
     */
    @Transactional
    @Override
    public void saveOperator2RefIdList(String refType,
            String operatorId, List<String> refIdList) {
        //查询对应操作员原来对应的引用类型中引用id列表
        List<OperatorRef> operatorRefList = queryOperatorRefListByOperatorId(refType, operatorId);
        Map<String, OperatorRef> refId2RefMapping = new HashMap<String, OperatorRef>();
        List<String> srcRefIdList = new ArrayList<String>();
        if(!CollectionUtils.isEmpty(operatorRefList)){
            for(OperatorRef operatorRefTemp : operatorRefList){
                srcRefIdList.add(operatorRefTemp.getRefId());
                refId2RefMapping.put(operatorRefTemp.getRefId(), operatorRefTemp);
            }
        }
        
        //查询需要减少的
        @SuppressWarnings("unchecked")
        List<String> needDeleteRefIds = ListUtils.subtract(srcRefIdList,
                refIdList);
        @SuppressWarnings("unchecked")
        List<String> needInsertRefIds = ListUtils.subtract(refIdList,
                srcRefIdList);
        
        //批量删除引用id集合
        batchDeleteRefIdList(refType, operatorId, needDeleteRefIds);
        //将批量删除的引用插入引用历史表中
        if(!CollectionUtils.isEmpty(needDeleteRefIds)){
            List<OperatorRef> deleteOperatorRef = new ArrayList<OperatorRef>();
            for(String refIdTemp : needDeleteRefIds){
                deleteOperatorRef.add(refId2RefMapping.get(refIdTemp));
            }
            batchInsertOperatorRefHis(deleteOperatorRef);
        }
        //批量插入
        batchInsertRefIdList(refType, operatorId, needInsertRefIds);
    }
    
   /**
     * 批量删除操作员引用id集合<br/>
     *<功能简述>
     *<功能详细描述>
     * @param refType
     * @param refId
     * @param OperatorIdList [参数说明]
     * 
     * @return void [返回类型说明]
     * @exception throws [异常类型] [异常说明]
     * @see [类、类#方法、类#成员]
    */
   private void batchDeleteOperatorIdList(String refType,
           String refId,List<String> OperatorIdList){
       if(CollectionUtils.isEmpty(OperatorIdList)){
           return ;
       }
       
       List<OperatorRef> operatorRefList = new ArrayList<OperatorRef>();
       for(String operatorIdTemp : OperatorIdList){
           operatorRefList.add(new OperatorRef(operatorIdTemp, refId, refType));
       }
       
       batchDeleteOperatorRef(operatorRefList);
   }
   
   /**
     * 批量插入引用id集合<br/>
     *<功能详细描述>
     * @param refType
     * @param refId
     * @param operatorId [参数说明]
     * 
     * @return void [返回类型说明]
     * @exception throws [异常类型] [异常说明]
     * @see [类、类#方法、类#成员]
    */
   private void batchInsertOperatorIdList(String refType,
           String refId,List<String> operatorId){
       if(CollectionUtils.isEmpty(operatorId)){
           return ;
       }
       
       List<OperatorRef> operatorRefList = new ArrayList<OperatorRef>();
       for(String operatorIdTemp : operatorId){
           operatorRefList.add(new OperatorRef(operatorIdTemp, refId, refType));
       }
       
       batchInsertOperatorRef(operatorRefList);
   }
    
    /**
     * @param refType
     * @param refId
     * @param operatorIdList
     */
    @Transactional
    @Override
    public void saveRefId2OperatorIdList(String refType,
            String refId, List<String> operatorIdList) {
        //查询对应引用id原来对应的引用类型中操作员id列表
        List<OperatorRef> operatorRefList = queryOperatorRefListByRefId(refType, refId);
        Map<String, OperatorRef> operatorId2RefMapping = new HashMap<String, OperatorRef>();
        List<String> srcOperatorIdList = new ArrayList<String>();
        if(!CollectionUtils.isEmpty(operatorRefList)){
            for(OperatorRef operatorRefTemp : operatorRefList){
                srcOperatorIdList.add(operatorRefTemp.getRefId());
                operatorId2RefMapping.put(operatorRefTemp.getOperatorId(), operatorRefTemp);
            }
        }
        
        //查询需要减少的
        @SuppressWarnings("unchecked")
        List<String> needDeleteOperatorIds = ListUtils.subtract(srcOperatorIdList,
                operatorIdList);
        @SuppressWarnings("unchecked")
        List<String> needInsertOperatorIds = ListUtils.subtract(operatorIdList,
                srcOperatorIdList);
        
        //删除需要删除的
        batchDeleteOperatorIdList(refType, refId, needDeleteOperatorIds);
        //将批量删除的引用插入引用历史表中
        if(!CollectionUtils.isEmpty(needDeleteOperatorIds)){
            List<OperatorRef> deleteOperatorRef = new ArrayList<OperatorRef>();
            for(String operatorIdTemp : needDeleteOperatorIds){
                deleteOperatorRef.add(operatorId2RefMapping.get(operatorIdTemp));
            }
            batchInsertOperatorRefHis(deleteOperatorRef);
        }
        //插入新增的
        batchInsertOperatorIdList(refType, refId, needInsertOperatorIds);
    }
    
    /**
      * 将operatorRef实例插入数据库中保存
      * 1、如果operatorRef为空时抛出参数为空异常
      * 2、如果operatorRef中部分必要参数为非法值时抛出参数不合法异常
     * <功能详细描述>
     * @param district [参数说明]
     * 
     * @return void [返回类型说明]
     * @exception throws
     * @see [类、类#方法、类#成员]
    */
    public void insertOperatorRef(OperatorRef operatorRef) {
        AssertUtils.notNull(operatorRef, "operatorRef is null.");
        AssertUtils.notEmpty(operatorRef.getOperatorId(),
                "operatorRef.operatorId is empty.");
        AssertUtils.notEmpty(operatorRef.getRefId(), "operatorRef.i is empty.");
        AssertUtils.notNull(operatorRef.getRefType(),
                "operatorRef.refType is null.");
        
        if (operatorRef.getCreateDate() == null) {
            operatorRef.setCreateDate(new Date());
        }
        this.operatorRefDao.insertOperatorRef(operatorRef);
    }
    
    /**
    * @param operatorRefs
    */
    private void batchInsertOperatorRef(List<OperatorRef> operatorRefs) {
        if (CollectionUtils.isEmpty(operatorRefs)) {
            return;
        }
        
        for (OperatorRef operatorRefTemp : operatorRefs) {
            AssertUtils.notNull(operatorRefTemp, "operatorRef is null.");
            AssertUtils.notEmpty(operatorRefTemp.getOperatorId(),
                    "operatorRef.operatorId is empty.");
            AssertUtils.notEmpty(operatorRefTemp.getRefId(),
                    "operatorRef.i is empty.");
            AssertUtils.notNull(operatorRefTemp.getRefType(),
                    "operatorRef.refType is null.");
            
            if (operatorRefTemp.getCreateDate() == null) {
                operatorRefTemp.setCreateDate(new Date());
            }
        }
        this.operatorRefDao.batchInsertOperatorRef(operatorRefs);
    }
    
    /**
     * @param operatorRef
     */
    public void insertOperatorRefHis(OperatorRef operatorRef) {
        AssertUtils.notNull(operatorRef, "operatorRef is null.");
        AssertUtils.notEmpty(operatorRef.getOperatorId(),
                "operatorRef.operatorId is empty.");
        AssertUtils.notEmpty(operatorRef.getRefId(), "operatorRef.i is empty.");
        AssertUtils.notNull(operatorRef.getRefType(),
                "operatorRef.refType is null.");
        
        this.operatorRefDao.insertOperatorRefHis(operatorRef);
    }
    
    /**
     * @param operatorRefs
     */
    private void batchInsertOperatorRefHis(List<OperatorRef> operatorRefs) {
        if (CollectionUtils.isEmpty(operatorRefs)) {
            return;
        }
        
        for (OperatorRef operatorRefTemp : operatorRefs) {
            AssertUtils.notNull(operatorRefTemp, "operatorRef is null.");
            AssertUtils.notEmpty(operatorRefTemp.getOperatorId(),
                    "operatorRef.operatorId is empty.");
            AssertUtils.notEmpty(operatorRefTemp.getRefId(),
                    "operatorRef.i is empty.");
            AssertUtils.notNull(operatorRefTemp.getRefType(),
                    "operatorRef.refType is null.");
        }
        this.operatorRefDao.batchInsertOperatorRefHis(operatorRefs);
    }
    
    /**
      * 根据operatorId删除operatorRef实例
      * 1、如果入参数为空，则抛出异常
      * 2、执行删除后，将返回数据库中被影响的条数
      * @param operatorId
      * @return 返回删除的数据条数，<br/>
      * 有些业务场景，如果已经被别人删除同样也可以认为是成功的
      * 这里讲通用生成的业务层代码定义为返回影响的条数
      * @return int [返回类型说明]
      * @exception throws 
      * @see [类、类#方法、类#成员]
     */
    @Transactional
    @Override
    public void deleteByOperatorId(String operatorId) {
        AssertUtils.notEmpty(operatorId, "operatorId is empty.");
        
        OperatorRef condition = new OperatorRef();
        condition.setOperatorId(operatorId);
        this.operatorRefDao.deleteOperatorRef(condition);
    }
    
    /**
     * @param refId
     */
    @Transactional
    @Override
    public void deleteByRefId(String refId) {
        AssertUtils.notEmpty(refId, "refId is empty.");
        
        OperatorRef condition = new OperatorRef();
        condition.setRefId(refId);
        this.operatorRefDao.deleteOperatorRef(condition);
    }
    
    /**
     * @param operatorRefs
     */
    private void batchDeleteOperatorRef(List<OperatorRef> operatorRefList) {
        if (CollectionUtils.isEmpty(operatorRefList)) {
            return;
        }
        
        this.operatorRefDao.batchDeleteOperatorRef(operatorRefList);
    }
    
    /**
      * 根据OperatorRef实体列表
      *     根据引用类型以及引用id 查询操作员引用列表
      *     一般用于根据职位分组等id,查询其关联的操作员列表<br/>
      * 
      * <功能详细描述>
      * @return [参数说明]
      * 
      * @return List<OperatorRef> [返回类型说明]
      * @exception throws [异常类型] [异常说明]
      * @see [类、类#方法、类#成员]
     */
    public List<OperatorRef> queryOperatorRefListByRefId(
            String refType, String refId) {
        AssertUtils.notEmpty(refId, "refId is empty.");
        AssertUtils.notNull(refType, "refType is null.");
        
        //生成查询条件
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("refType", refType);
        params.put("refId", refId);
        
        //根据实际情况，填入排序字段等条件，根据是否需要排序，选择调用dao内方法
        List<OperatorRef> resList = this.operatorRefDao.queryOperatorRefList(params);
        
        return resList;
    }
    
    /**
      * 根据人员引用类型以及人员id,查询操作员引用集合<br/>
      *     一般用于查询操作员对应的职位列表、分组列表等功能<br/>
      *<功能详细描述>
      * @param refType
      * @param operatorId
      * @return [参数说明]
      * 
      * @return List<OperatorRef> [返回类型说明]
      * @exception throws [异常类型] [异常说明]
      * @see [类、类#方法、类#成员]
     */
    public List<OperatorRef> queryOperatorRefListByOperatorId(
            String refType, String operatorId) {
        AssertUtils.notEmpty(operatorId, "refId is empty.");
        AssertUtils.notNull(refType, "refType is null.");
        
        //生成查询条件
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("refType", refType);
        params.put("operatorId", operatorId);
        
        //根据实际情况，填入排序字段等条件，根据是否需要排序，选择调用dao内方法
        List<OperatorRef> resList = this.operatorRefDao.queryOperatorRefList(params);
        
        return resList;
    }
}
