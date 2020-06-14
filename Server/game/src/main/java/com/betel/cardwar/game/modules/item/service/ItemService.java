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
import com.betel.session.SessionState;
import com.betel.spring.IRedisService;
import com.betel.utils.IdGenerator;
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

    }

    //获取玩家的所有物品列表
    private void itemList(Session session)
    {
        String roleId = session.getRecvJson().getString(Field.ROLE_ID);
        if(!roleItemsMap.containsKey(roleId))
            initRoleItemList(roleId);
        List<Item> itemList = roleItemsMap.get(roleId);
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.ITEM_LIST, itemList);
        rspdClient(session, sendJson);
    }

    private void initRoleItemList(String roleId)
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

    //装备
    public void putEquip(String roleId, int itemId, boolean equipped)
    {
        HashMap<Integer, Item> hashMap = roleItemHashMap.get(roleId);
        if(hashMap.containsKey(itemId))
        {
            Item item = hashMap.get(itemId);
            item.setEquipped(equipped);
            dao.updateEntity(item);
        }
    }

    //添加物品
    public void addItem(String roleId, int itemId, int num)
    {
        HashMap<Integer, Item> hashMap = roleItemHashMap.get(roleId);
        if(hashMap.containsKey(itemId))
        {
            Item item = hashMap.get(itemId);
            int newNum = item.getNum() + num;
            item.setNum(newNum);
            dao.updateEntity(item);
        }else{
            Item item = new Item();
            item.setId(Long.toString(IdGenerator.getInstance().nextId()));
            item.setVid(roleId);
            item.setNum(num);
            item.setEquipped(false);
            item.setLevel(1);
            item.setItemId(itemId);
            dao.addEntity(item);
        }
    }
}