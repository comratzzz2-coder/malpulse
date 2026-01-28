-- ====================================
-- 🎮 ЗАМОРОЗКА ПЕРСОНАЖЕЙ
-- ====================================

gg.setVisible(false)
gg.clearResults()

local monsters = {
    -- 🌪 ВЕТЕР
    {id = 18613, name = "🌪 Пеньчоль", element = "Ветер"},
    {id = 18608, name = "🌪 Пеньчоль", element = "Ветер"},
    {id = 13713, name = "🌪 Художник ветра", element = "Ветер"},
    {id = 13716, name = "🌪 Художник ветра", element = "Ветер"},
    {id = 10513, name = "🌪 Тритон", element = "Ветер"},
    {id = 10508, name = "🌪 Тритон", element = "Ветер"},
    {id = 13113, name = "🌪 Один", element = "Ветер"},
    {id = 12923, name = "🌪 Таранис", element = "Ветер"},
    {id = 12938, name = "🌪 Таранис", element = "Ветер"},
    {id = 12213, name = "🌪 Триана", element = "Ветер"},
    {id = 7813, name = "🌪 Лео", element = "Ветер"},
    {id = 9713, name = "🌪 Тиана", element = "Ветер"},
    {id = 15713, name = "🌪 Зен", element = "Ветер"},
    {id = 12013, name = "🌪 Фэн Янь", element = "Ветер"},
    {id = 2563, name = "🌪 Бернард", element = "Ветер"},
    {id = 20208, name = "🌪 Мегуми Фушигуро", element = "Ветер"},
    {id = 20213, name = "🌪 Мегуми Фушигуро", element = "Ветер"},
    {id = 13608, name = "🌪 Саванна", element = "Ветер"},
    {id = 13613, name = "🌪 Саванна", element = "Ветер"},
    {id = 13618, name = "🌪 Саванна", element = "Ветер"},
    {id = 21013, name = "🌪 Орфина", element = "Ветер"},
    
    -- 🌊 ВОДА
    {id = 15431, name = "🌊 Алия", element = "Вода"},
    {id = 16611, name = "🌊 Адриана", element = "Вода"},
    {id = 15111, name = "🌊 Нана", element = "Вода"},
    {id = 11311, name = "🌊 Бастет", element = "Вода"},
    {id = 14406, name = "🌊 Мур", element = "Вода"},
    {id = 14411, name = "🌊 Мур", element = "Вода"},
    {id = 13906, name = "🌊 Рю", element = "Вода"},
    {id = 13911, name = "🌊 Рю", element = "Вода"},
    {id = 18131, name = "🌊 Парджанья", element = "Вода"},
    {id = 18136, name = "🌊 Парджанья", element = "Вода"},
    {id = 15711, name = "🌊 Минато", element = "Вода"},
    {id = 6011, name = "🌊 Камилла", element = "Вода"},
    {id = 7811, name = "🌊 Чоу", element = "Вода"},
    {id = 10012, name = "🌊 Теомарс", element = "Вода"},
    {id = 12311, name = "🌊 Амелия", element = "Вода"},
    {id = 11911, name = "🌊 Псамафа", element = "Вода"},
    {id = 12511, name = "🌊 Джозефина", element = "Вода"},
    {id = 12936, name = "🌊 Абелио", element = "Вода"},
    {id = 21006, name = "🌊 Ламелия", element = "Вода"},
    {id = 21011, name = "🌊 Ламелия", element = "Вода"},
    {id = 17006, name = "🌊 Зибала", element = "Вода"},
    {id = 17011, name = "🌊 Зибала", element = "Вода"},
    {id = 16706, name = "🌊 Манон", element = "Вода"},
    {id = 16711, name = "🌊 Манон", element = "Вода"},
    {id = 10216, name = "🌊 Галеон", element = "Вода"},
    {id = 10221, name = "🌊 Галеон", element = "Вода"},
    {id = 11511, name = "🌊 Чилинг", element = "Вода"},
    
    -- 🔥 ОГОНЬ
    {id = 22412, name = "🔥 Джин Кадзима", element = "Огонь"},
    {id = 22912, name = "🔥 Кай", element = "Огонь"},
    {id = 7912, name = "🔥 Мей Ху Ванг", element = "Огонь"},
    {id = 7112, name = "🔥 Джуно", element = "Огонь"},
    {id = 3212, name = "🔥 Перна", element = "Огонь"},
    {id = 6012, name = "🔥 Ванесса", element = "Огонь"},
    {id = 15712, name = "🔥 Рен", element = "Огонь"},
    {id = 15707, name = "🔥 Рен", element = "Огонь"},
    {id = 20812, name = "🔥 Тэцуя", element = "Огонь"},
    {id = 4207, name = "🔥 Ракан", element = "Огонь"},
    {id = 14412, name = "🔥 Дуглас", element = "Огонь"},
    
    -- ☀️ СВЕТ
    {id = 13414, name = "☀️ Люцифер", element = "Свет"},
    {id = 3214, name = "☀️ Элюд", element = "Свет"},
    {id = 12414, name = "☀️ Элеонора", element = "Свет"},
    {id = 12419, name = "☀️ Элеонора", element = "Свет"},
    {id = 6514, name = "☀️ Джулиан", element = "Свет"},
    {id = 9414, name = "☀️ Нвегонг", element = "Свет"},
    {id = 7214, name = "☀️ Лора", element = "Свет"},
    {id = 7209, name = "☀️ Лора", element = "Свет"},
    {id = 15014, name = "☀️ Кинки", element = "Свет"},
    {id = 10414, name = "☀️ Молли", element = "Свет"},
    {id = 10409, name = "☀️ Молли", element = "Свет"},
    {id = 9114, name = "☀️ Енхонг", element = "Свет"},
    {id = 12014, name = "☀️ Тиан Ланг", element = "Свет"},
    {id = 7509, name = "☀️ Хальпас", element = "Свет"},
    {id = 7514, name = "☀️ Хальпас", element = "Свет"},
    {id = 6014, name = "☀️ Акрома", element = "Свет"},
    {id = 14609, name = "☀️ Крэйг", element = "Свет"},
    {id = 14614, name = "☀️ Крэйг", element = "Свет"},
    {id = 18614, name = "☀️ Ыльдонг", element = "Свет"},
        
    -- 🌑 ТЬМА
    {id = 11315, name = "🌑 Нептис", element = "Тьма"},
    {id = 7115, name = "🌑 Киана", element = "Тьма"},
    {id = 9716, name = "🌑 Лидия", element = "Тьма"},
    {id = 12415, name = "🌑 Александра", element = "Тьма"},
    {id = 12420, name = "🌑 Александра", element = "Тьма"},
    {id = 11410, name = "🌑 Амдуат", element = "Тьма"},
    {id = 11415, name = "🌑 Амдуат", element = "Тьма"},
    {id = 7815, name = "🌑 Рэгдолл", element = "Тьма"},
    {id = 10015, name = "🌑 Веромосс", element = "Тьма"},
    {id = 11910, name = "🌑 Никс", element = "Тьма"},
    {id = 12015, name = "🌑 Ми Инь", element = "Тьма"},
    {id = 12010, name = "🌑 Ми Инь", element = "Тьма"},
    {id = 12510, name = "🌑 Леона", element = "Тьма"},
    {id = 12515, name = "🌑 Леона", element = "Тьма"},
    {id = 16715, name = "🌑 Жизель", element = "Тьма"},
    {id = 15110, name = "🌑 Кики", element = "Тьма"},
    {id = 15115, name = "🌑 Кики", element = "Тьма"},
    {id = 4215, name = "🌑 Зерату", element = "Тьма"},
    {id = 22015, name = "🌑 Vermilion Bird Dancer", element = "Тьма"},
    {id = 18010, name = "🌑 Сигрид", element = "Тьма"},
    {id = 18015, name = "🌑 Сигрид", element = "Тьма"},
    {id = 7915, name = "🌑 Son Zhang Lao", element = "Тьма"},
    {id = 13620, name = "🌑 Сиана", element = "Тьма"},
    {id = 7215, name = "🌑 Ники", element = "Тьма"},
    {id = 12215, name = "🌑 Vivachel", element = "Тьма"},
    {id = 6315, name = "🌑 Фермион", element = "Тьма"}
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

function findPatternForSkillID(skillID)
    local foundAddresses = {}
    
    gg.searchNumber(skillID, gg.TYPE_DWORD)
    local total = gg.getResultCount()
    
    if total == 0 then
        return foundAddresses
    end
    
    local results = gg.getResults(total)
    
    for i, res in ipairs(results) do
        local checks = gg.getValues({
            {address = res.address, flags = gg.TYPE_DWORD},
            {address = res.address + 4, flags = gg.TYPE_DWORD},
            {address = res.address + 8, flags = gg.TYPE_DWORD},
            {address = res.address + 12, flags = gg.TYPE_DWORD}
        })
        
        local v1, v2, v3, v4 = checks[1].value, checks[2].value, checks[3].value, checks[4].value
        
        if v1 == skillID 
           and v2 == 0 
           and v3 >= 10000000 and v3 <= 999999999
           and v4 >= 1 and v4 <= 9999
        then
            table.insert(foundAddresses, {
                address = res.address,
                flags = gg.TYPE_DWORD,
                value = 0,
                freeze = true,
                name = "ID" .. skillID .. "_PATTERN"
            })
        end
    end
    
    gg.clearResults()
    return foundAddresses
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
    local monsterStats = {}
    
    -- Собираем статистику по стихиям и монстрам
    for idx, monster in ipairs(targets) do
        local skillID = monster.id
        local patternAddresses = findPatternForSkillID(skillID)
        
        if #patternAddresses > 0 then
            -- Инициализируем таблицы для стихии и монстра
            if not monsterStats[monster.element] then
                monsterStats[monster.element] = {}
            end
            if not monsterStats[monster.element][monster.name] then
                monsterStats[monster.element][monster.name] = 0
            end
            monsterStats[monster.element][monster.name] = monsterStats[monster.element][monster.name] + #patternAddresses
        end
        
        for _, addr in ipairs(patternAddresses) do
            addr.name = monster.name
            table.insert(foundAddresses, addr)
            totalFound = totalFound + 1
        end
    end
    
    if totalFound == 0 then
        gg.alert("Персонажи не найдены!")
        return
    end
    
    -- Порядок стихий для сортировки
    local elementOrder = {
        "Ветер",
        "Вода", 
        "Огонь",
        "Свет",
        "Тьма"
    }
    
    -- Создаем сообщение с группировкой по стихиям
    local confirmMsg = "БУДУТ ЗАМОРОЖЕНЫ:\n\n"
    local hasElements = false
    
    for _, element in ipairs(elementOrder) do
        if monsterStats[element] then
            hasElements = true
            confirmMsg = confirmMsg .. element .. ":\n"
            for name, count in pairs(monsterStats[element]) do
                confirmMsg = confirmMsg .. "  • " .. name .. ": " .. count .. " адр.\n"
            end
            confirmMsg = confirmMsg .. "\n"
        end
    end
    
    confirmMsg = confirmMsg .. "Всего: " .. totalFound .. " адресов"
    
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
    
    -- Создаем отчет с группировкой по стихиям
    local report = "ЗАМОРОЗКА ВЫПОЛНЕНА!\n\n"
    
    for _, element in ipairs(elementOrder) do
        if monsterStats[element] then
            report = report .. element .. ":\n"
            for name, count in pairs(monsterStats[element]) do
                report = report .. "  " .. name .. ": " .. count .. "\n"
            end
            report = report .. "\n"
        end
    end
    
    report = report .. "ИТОГО: " .. totalFound .. " адресов"
    
    gg.alert(report)
end

showMonsterMenu()

















