package com.xc.rule;

import com.xc.config.WebResponse;
import com.xc.datasouce.service.DataSourceService;
import com.xc.mapper.DataSourceMapper;
import com.xc.mapper.RuleMapper;
import com.xc.po.DataSource;
import com.xc.po.Rule;
import com.xc.vo.DataSourceVo;
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
import java.util.Map;
import java.util.Set;

@Api(description = "规则")
@RestController
@Slf4j
@RequestMapping(value = "/xiaochao/rule")
public class RuleController {

    @Autowired
    private RuleMapper ruleMapper;
    @Autowired
    private RuleService ruleService;

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation("插入规则")
    public WebResponse insertSelective(@RequestBody Rule rule) {
        int i = ruleMapper.insertSelective(rule);
        return WebResponse.succeed(i);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation("修改规则")
    public WebResponse updateDataSource(@RequestBody Rule rule) {
        int i = ruleMapper.updateByPrimaryKeySelective(rule);
        return WebResponse.succeed(i);
    }

    @RequestMapping(value = "/selectByRuleCollIds", method = RequestMethod.POST)
    @ApiOperation("查询规则")
    public WebResponse selectByIds(Integer id) {

        List<Rule> rules = ruleMapper.selectByRuleCollId(id);
        return WebResponse.succeed(rules);
    }

    @RequestMapping(value = "/execute", method = RequestMethod.POST)
    @ApiOperation("执行规则")
    public WebResponse execute(@RequestBody RuleVo ruleVo) throws Exception {
        Rule rule = ruleMapper.selectById(ruleVo.getId());

        RuleResultVo execute = ruleService.execute(rule, ruleVo.getParam(), true);
        return WebResponse.succeed(execute);
    }

}
