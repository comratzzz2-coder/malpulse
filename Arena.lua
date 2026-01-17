-- ====================================
-- 🎮 ЗАМОРОЗКА ПЕРСОНАЖЕЙ
-- ====================================

local SCRIPT_VERSION = 1

gg.setVisible(false)
gg.clearResults()

local monsters = {
    -- 🌪️ ВЕТЕР
    {id = 7813, search = "7813;1540", name = "🌪️ Лео"},
    {id = 9713, search = "9713;1028", name = "🌪️ Тиана"},
    {id = 10513, search = "10513;1025", name = "🌪️ Тритон"},
    
    -- 🌊 ВОДА
    {id = 15711, search = "15711;1285", name = "🌊 Минато"},
    {id = 6011, search = "6011;515", name = "🌊 Камилла"},
    {id = 7811, search = "7811;1538", name = "🌊 Чоу"},
    {id = 10012, search = "10012;1795", name = "🌊 Теомарс"},
    {id = 12311, search = "12311;515", name = "🌊 Амелия"},
    {id = 11911, search = "11911;1794", name = "🌊 Псамафа"},
    {id = 12511, search = "12511;8", name = "🌊 Джозефина"},
    {id = 12936, search = "12936;1283", name = "🌊 Абелио"},
    {id = 21006, search = "21006;2053", name = "🌊 Ламелия"},
    {id = 21011, search = "21011;774", name = "🌊 Ламелия"},
    {id = 18216, search = "18216;773", name = "🌊 Парджанья"},
    {id = 18211, search = "18211;2052", name = "🌊 Парджанья"},
    {id = 17006, search = "17006;2053", name = "🌊 Зибала"},
    {id = 17011, search = "17011;774", name = "🌊 Зибала"},
    
    -- 🔥 ОГОНЬ
    {id = 6012, search = "6012;517", name = "🔥 Ванесса"}
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
