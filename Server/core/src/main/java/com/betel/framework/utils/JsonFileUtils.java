package com.betel.framework.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.betel.consts.ServerConsts;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.io.IOException;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/30
 */
public class JsonFileUtils
{
    final static Logger logger = LogManager.getLogger(JsonFileUtils.class);

    public static JSONObject getJsonObject(String filePath)
    {
        String content = null;
        try
        {
            String path = JsonFileUtils.class.getResource(filePath).getPath();
            logger.info("load json file:" + path);
            content = FileUtils.readFileToString(new File(path), ServerConsts.CHARSET_UTF_8);
        } catch (IOException e)
        {
            e.printStackTrace();
        }
        return JSON.parseObject(content);
    }
}
