package com.xc.rule;

import com.xc.config.WebResponse;
import com.xc.mapper.RuleCollectionMapper;
import com.xc.po.Rule;
import com.xc.po.RuleCollection;
import com.xc.vo.RuleCollectionResultVo;
import com.xc.vo.RuleResultVo;
import com.xc.vo.RuleVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Api(description = "规则")
@RestController
@Slf4j
@RequestMapping(value = "/xiaochao/ruleCollection")
public class RuleCollectionController {

    @Autowired
    private RuleCollectionMapper ruleCollectionMapper;
    @Autowired
    private RuleCollectionService ruleCollectionService;

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation("插入规则集合")
    public WebResponse insertSelective(@RequestBody RuleCollection rule) {
        int i = ruleCollectionMapper.insertSelective(rule);
        return WebResponse.succeed(i);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation("修改规则集合")
    public WebResponse updateDataSource(@RequestBody RuleCollection rule) {
        int i = ruleCollectionMapper.updateByPrimaryKeySelective(rule);
        return WebResponse.succeed(i);
    }

    @RequestMapping(value = "/selectById", method = RequestMethod.POST)
    @ApiOperation("查询规则集合")
    public WebResponse selectByIds(Integer id) {

        RuleCollection rules = ruleCollectionMapper.selectById(id);
        return WebResponse.succeed(rules);
    }

    @RequestMapping(value = "/execute", method = RequestMethod.POST)
    @ApiOperation("执行规则集合")
    public WebResponse execute(@RequestBody RuleVo ruleVo) throws Exception {
        RuleCollection rule = ruleCollectionMapper.selectById(ruleVo.getId());

        RuleCollectionResultVo execute = ruleCollectionService.execute(rule, ruleVo.getParam(), true);
        return WebResponse.succeed(execute);
    }

}
