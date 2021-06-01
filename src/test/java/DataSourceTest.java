import com.xc.constant.ConstantType;
import com.xc.po.DataSource;
import com.xc.datasouce.service.DataSourceService;
import com.xc.until.JsonUtil;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author xiaochao18
 * @Description TODO
 * @Date $ $
 * @Param $
 * @return $
 **/
@Slf4j
public class DataSourceTest {

    @Test
    public void T1() throws IOException, TemplateException {
        DataSource httpDataSource = new DataSource();
        httpDataSource.setDataType(ConstantType.DataType.PARAM);
        httpDataSource.setRequestType(ConstantType.RequestType.GET);
        httpDataSource.setUrl("https://h5.youzan.com/v2/common/jsApi/weixinjsticket.jsonp");
        httpDataSource.setType(1);
        Map<String, String> paramTemplateMap = new HashMap<>();
        paramTemplateMap.put("kdt_id", "${kdt_id}");
        paramTemplateMap.put("redirect_url", "${redirect_url}");
        paramTemplateMap.put("callback", "${callback}");
        paramTemplateMap.put("_", "${_}");
        String paramTemplate = JsonUtil.write2JsonStr(paramTemplateMap);
        System.out.println(paramTemplate);
        httpDataSource.setParamTemplate(paramTemplate);

        Map<String, String> resultExtract = new HashMap<>();
        resultExtract.put("data.appId", "xc");
        String resultExtract1 = JsonUtil.write2JsonStr(resultExtract);
        System.out.println(resultExtract1);
        httpDataSource.setResultExtract(resultExtract1);
        DataSourceService httpService = new DataSourceService();


        Map<String, Object> param = new HashMap<>();
        param.put("kdt_id", "13387617");
        param.put("redirect_url", "https://tech.youzan.com/rule-config-platform/");
        param.put("callback", "jQuery33102952066645850704_1621998345778");
        param.put("_", "1621996728157");
        Map<String, Object> execute = httpService.requestService(httpDataSource, param);
        System.out.println(JsonUtil.write2JsonStr(param));
        System.out.println(execute);
    }
}
