package com.xc.rule;

import com.ql.util.express.DefaultContext;
import com.ql.util.express.ExpressRunner;
import org.springframework.stereotype.Service;

@Service
public class RuleService {
//https://segmentfault.com/a/1190000039415013
ExpressRunner runner = new ExpressRunner(false,false);

public void xc(){
    DefaultContext<String, Object> context = new DefaultContext<>();
    runner.execute(exp,context,null,false,false,null);
}
}
