-- ====================================
-- 🎮 ЗАМОРОЗКА ПЕРСОНАЖЕЙ
-- ====================================

local SCRIPT_VERSION = 1

gg.setVisible(false)
gg.clearResults()

local monsters = {
    -- 🌪 ВЕТЕР
    {id = 18613, search = "18608;773", name = "🌪 Пеньчоль"},
    {id = 13713, search = "13713;1024", name = "🌪 Художник ветра"},
    {id = 13716, search = "13716;264", name = "🌪 Художник ветра"},
    {id = 10513, search = "10508;774", name = "🌪 Тритон"},
    {id = 13113, search = "13113;2304", name = "🌪 Один"},
    {id = 12923, search = "12923;773", name = "🌪 Таранис"},
    {id = 12938, search = "12938;1285", name = "🌪 Таранис"},
    
    -- 🌊 ВОДА
    {id = 18131, search = "18131;771", name = "🌊 Парджанья"},
    {id = 18136, search = "18136;773", name = "🌊 Парджанья"},
    
    -- 🔥 ОГОНЬ
    {id = 22412, search = "22412;772", name = "🔥 Джин Кадзима"},
    {id = 22912, search = "22912;2052", name = "🔥 Кай"},
    {id = 7912, search = "7912;1", name = "🔥 Мей Ху Ванг"},
    {id = 7112, search = "7112;2052", name = "🔥 Джуно"},
    {id = 3212, search = "3212;262", name = "🔥 Перна"},
    
    -- ☀️ СВЕТ
    {id = 13414, search = "13414;516", name = "☀️ Люцифер"},
    {id = 3214, search = "3214;263", name = "☀️ Элюд"},
    {id = 12414, search = "12414;1030", name = "☀️ Элеонора"},
    {id = 12419, search = "12419;1281", name = "☀️ Элеонора"},
    
    -- 🌑 ТЬМА
    {id = 11315, search = "11315;2305", name = "🌑 Нептис"},
    {id = 7115, search = "7115;2055", name = "🌑 Киана"},
    {id = 9716, search = "9716;1030", name = "🌑 Лидия"},
    {id = 12145, search = "12145;1031", name = "🌑 Александра"},
    {id = 12420, search = "12420;1282", name = "🌑 Александра"}
}

local selected = {}
for i = 1, #monsters do
    selected[i] = true
end

function showMonsterMenu()
    while true do
        local menuItems = {}
        
        table.insert(menuItems, "✅ ВЫБРАТЬ ВСЕХ")
        table.insert(menuItems, "❌ СНЯТЬ ВСЕХ")
        table.insert(menuItems, "🎮 ЗАМОРОЗИТЬ")
        table.insert(menuItems, "")
        
        for i = 1, #monsters do
            if monsters[i] then
                local prefix = selected[i] and "✅ " or "❌ "
                local number = string.format("%02d", i)
                table.insert(menuItems, number .. ". " .. prefix .. monsters[i].name)
            end
        end
        
        table.insert(menuItems, "")
        table.insert(menuItems, "🚪 ВЫЙТИ")
        
        local choice = gg.choice(menuItems, nil, "ВЫБЕРИТЕ ПЕРСОНАЖЕЙ")
        
        if choice == nil or choice == #menuItems then
            return
        end
        
        if choice == 1 then
            for i = 1, #monsters do
                selected[i] = true
            end
            
        elseif choice == 2 then
            for i = 1, #monsters do
                selected[i] = false
            end
            
        elseif choice == 3 then
            local hasSelected = false
            for i = 1, #monsters do
                if selected[i] then
                    hasSelected = true
                    break
                end
            end
            
            if not hasSelected then
                gg.alert("Не выбрано ни одного персонажа!")
            else
                freezeSelectedMonsters()
                return
            end
            
        elseif choice > 4 and choice < #menuItems - 1 then
            local monsterIndex = choice - 4
            if monsterIndex >= 1 and monsterIndex <= #monsters and monsters[monsterIndex] then
                selected[monsterIndex] = not selected[monsterIndex]
            end
        end
    end
end

function freezeSelectedMonsters()
    local targets = {}
    for i = 1, #monsters do
        if selected[i] then
            table.insert(targets, monsters[i])
        end
    end
    
    local totalFound = 0
    local foundAddresses = {}
    
    for idx, monster in ipairs(targets) do
        gg.clearResults()
        gg.searchNumber(monster.search, gg.TYPE_DWORD)
        
        local results = gg.getResults(2000)
        local foundForThisMonster = 0
        
        for _, v in ipairs(results) do
            if v.value == monster.id then
                foundForThisMonster = foundForThisMonster + 1
                
                local addressInfo = {
                    address = v.address,
                    flags = gg.TYPE_DWORD,
                    value = 0,
                    freeze = true,
                    name = monster.name
                }
                
                table.insert(foundAddresses, addressInfo)
                totalFound = totalFound + 1
            end
        end
    end
    
    if totalFound == 0 then
        gg.alert("Персонажи не найдены!")
        return
    end
    
    local confirmMsg = "БУДУТ ЗАМОРОЖЕНЫ:\n\n"
    for _, monster in ipairs(targets) do
        local count = 0
        for _, item in ipairs(foundAddresses) do
            if item.name == monster.name then
                count = count + 1
            end
        end
        if count > 0 then
            confirmMsg = confirmMsg .. "• " .. monster.name .. ": " .. count .. " адр.\n"
        end
    end
    
    confirmMsg = confirmMsg .. "\nВсего: " .. totalFound .. " адресов"
    
    local confirm = gg.alert(confirmMsg, "ЗАМОРОЗИТЬ", "ОТМЕНА")
    
    if confirm ~= 1 then
        return
    end
    
    gg.setValues(foundAddresses)
    
    gg.clearList()
    for _, item in ipairs(foundAddresses) do
        gg.addListItems({item})
    end
    
    local listItems = gg.getListItems()
    for _, item in ipairs(listItems) do
        item.freeze = true
        item.value = 0
        gg.setValues({item})
    end
    
    local report = "ЗАМОРОЗКА ВЫПОЛНЕНА!\n\n"
    for _, monster in ipairs(targets) do
        local count = 0
        for _, item in ipairs(foundAddresses) do
            if item.name == monster.name then
                count = count + 1
            end
        end
        if count > 0 then
            report = report .. monster.name .. ": " .. count .. "\n"
        end
    end
    
    report = report .. "\nИТОГО: " .. totalFound .. " адресов"
    
    gg.alert(report)
end

showMonsterMenu()
