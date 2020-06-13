package com.betel.cardwar.game.modules.item.service;

import com.alibaba.fastjson.JSONObject;
import com.betel.asd.BaseService;
import com.betel.asd.RedisDao;
import com.betel.cardwar.game.consts.Field;
import com.betel.cardwar.game.modules.card.model.Card;
import com.betel.cardwar.game.modules.item.ModuleConfig;
import com.betel.cardwar.game.modules.item.model.Item;
import com.betel.cardwar.game.modules.item.model.ItemDao;
import com.betel.cardwar.game.modules.item.model.ItemInfo;
import com.betel.cardwar.game.modules.role.events.RoleEvent;
import com.betel.event.EventDelegate;
import com.betel.event.EventObject;
import com.betel.session.Session;
import com.betel.spring.IRedisService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/21
 */
public class ItemService extends BaseService<Item>
{
    @Autowired
    protected ItemDao dao;
    @Override
    public RedisDao<Item> getDao()
    {
        return dao;
    }

    private HashMap<String, List<Item>> roleItemsMap = new HashMap<>();
    private HashMap<String, HashMap<Integer, Item>> roleItemHashMap = new HashMap<>();

    @Override
    public void OnLoaded()
    {
        eventDispatcher.addEventListener(RoleEvent.ROLE_ENTER_GAME, new EventDelegate()
        {
            @Autowired
            protected ItemService itemService;

            @Override
            public void invoke(EventObject event)
            {
                itemService.initRoleItemList(((RoleEvent)event).getRoleId());
            }
        });
    }

    //获取玩家的所有物品列表
    private void itemList(Session session)
    {
        String roleId = session.getRecvJson().getString(Field.ROLE_ID);
        List<Item> itemList = roleItemsMap.get(roleId);
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.ITEM_LIST, itemList);
        rspdClient(session, sendJson);
    }

    //添加物品
    public void addItem(String roleId, int itemId)
    {
        List<Item> itemList = roleItemsMap.get(roleId);
    }

    public void initRoleItemList(String roleId)
    {
        List<Item> itemList = dao.getViceEntities(roleId);
        HashMap<Integer, Item> hashMap = new HashMap<>();
        for (int i = 0; i < itemList.size(); i++)
        {
            Item item = itemList.get(i);
            //ItemInfo itemInfo = ModuleConfig.getItemInfo(item.getItemId());
            hashMap.put(item.getItemId(), item);
        }
        roleItemsMap.put(roleId, itemList);
        roleItemHashMap.put(roleId, hashMap);
    }
}