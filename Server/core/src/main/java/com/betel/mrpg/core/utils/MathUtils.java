package com.betel.mrpg.core.utils;

import java.util.Random;

/**
 * @ClassName: MathUtils
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/2/1 0:53
 */
public class MathUtils
{
    public static int[] getRandom(int min, int max)
    {
        int[] randoms = new int[max];
        Random random = new Random();
        for (int i = min; i < max; i++)
        {
            randoms[i] = random.nextInt(max);
        }
        return randoms;
    }

    public static int getRandom(int bound)
    {
        return (int)(1+Math.random()*(bound-1+1));
    }

    public static int randomInt(int min, int max)
    {
        int num = min + (int) (Math.random() * (max - min));        //返回大于等于min小于max（不包括max）之间的随机数
        return num;
    }
}
