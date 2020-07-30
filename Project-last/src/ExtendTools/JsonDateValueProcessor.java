package ExtendTools;

import java.text.SimpleDateFormat;

import java.text.SimpleDateFormat;
import java.util.Date;

import java.util.Locale;



import net.sf.json.JsonConfig;

import net.sf.json.processors.JsonValueProcessor;



public class JsonDateValueProcessor implements JsonValueProcessor {

        private String pattern = "yyyy-MM-dd HH:mm:ss";



        //定义两个构造函数，通过第二个构造函数可以自定义时间格式化字符串

        public JsonDateValueProcessor() {

        super();

        }
        public JsonDateValueProcessor(String format) {
        this.pattern= format;

        }



        public Object processArrayValue(Object arg0, JsonConfig arg1) {


        return process(arg0);

        }



        public Object processObjectValue(String arg0, Object arg1, JsonConfig arg2) {

        //TODO Auto-generated method stub

        return process(arg1);

        }

        private Object process(Object val){

        if(val instanceof Date&& val!=null){

        SimpleDateFormat sdf=new SimpleDateFormat(this.pattern,Locale.CHINESE);

        return sdf.format(val);

        }else

        return val==null?"":val.toString();



        }



        }