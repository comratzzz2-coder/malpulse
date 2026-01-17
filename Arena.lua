-- ====================================
-- 🎮 ЗАМОРОЗКА ПЕРСОНАЖЕЙ
-- Версия: 1.0
-- ====================================

local SCRIPT_VERSION = 1  -- Увеличивай это число при обновлениях

gg.setVisible(false)
gg.clearResults()

-- Список персонажей с их ID и вспомогательными значениями
local monsters = {
    -- 🌪️ ВЕТЕР
    {id = 7813, search = "7813;1540", name = "🌪️ Лео"},
    {id = 9713, search = "9713;1028", name = "🌪️ Тиана"},
    {id = 10513, search = "10513;1025", name = "🌪️ Тритон"},
    
    -- 🌊 ВОДА
    {id = 15711, search = "15711;1285", name = "🌊 Минато"},
    {id = 6011, search = "6011;515", name = "🌊 Камилла"},
    {id = 7811, search = "7811;1538", name = "🌊 Чоу"}, -- Не проверить
    {id = 10012, search = "10012;1795", name = "🌊 Теомарс"}, -- Не проверить
    {id = 12311, search = "12311;515", name = "🌊 Амелия"},
    {id = 11911, search = "11911;1794", name = "🌊 Псамафа"},
    {id = 12511, search = "12511;8", name = "🌊 Джозефина"}, -- Находит три. Не проверить
    {id = 12936, search = "12936;1283", name = "🌊 Абелио"}, -- Не проверить
    
    -- 🔥 ОГОНЬ
    {id = 6012, search = "6012;517", name = "🔥 Ванесса"}
}

-- Меню выбора
local menu = {}
for i, monster in ipairs(monsters) do
    table.insert(menu, monster.name .. " (" .. monster.id .. ")")
end
table.insert(menu, "🎮 Заморозить всех")
table.insert(menu, "❌ Выйти")

-- Показываем меню
local choice = gg.choice(menu, nil, "👥 ВЫБЕРИТЕ ПЕРСОНАЖА ДЛЯ ЗАМОРОЗКИ")

if choice == nil or choice == #menu then
    gg.toast("👋 Скрипт завершен")
    return
end

-- Определяем кого замораживать
local targets = {}
if choice == #menu - 1 then
    -- Заморозить всех
    targets = monsters
elseif choice >= 1 and choice <= #monsters then
    -- Только одного выбранного
    table.insert(targets, monsters[choice])
else
    gg.alert("❌ Неверный выбор!")
    return
end

gg.toast("🔍 Начинаю поиск...")

local totalFound = 0
local foundAddresses = {}
local searchDetails = ""

-- Поиск для каждого выбранного персонажа
for _, monster in ipairs(targets) do
    gg.clearResults()
    gg.searchNumber(monster.search, gg.TYPE_DWORD)
    
    local results = gg.getResults(2000) -- Увеличил лимит для большего количества персонажей
    local foundForThisMonster = 0
    
    searchDetails = searchDetails .. monster.name .. ":\n"
    searchDetails = searchDetails .. "  Найдено результатов: " .. #results .. "\n"
    
    -- Считаем сколько каждого значения
    local primaryCount = 0
    local secondaryCount = 0
    for _, v in ipairs(results) do
        if v.value == monster.id then
            primaryCount = primaryCount + 1
        elseif monster.search:find(tostring(v.value)) then
            secondaryCount = secondaryCount + 1
        end
    end
    
    searchDetails = searchDetails .. "  С " .. monster.id .. ": " .. primaryCount .. "\n"
    
    -- Фильтруем: оставляем только адреса с основным ID
    for _, v in ipairs(results) do
        if v.value == monster.id then  -- ТОЛЬКО основной ID!
            foundForThisMonster = foundForThisMonster + 1
            
            local addressInfo = {
                address = v.address,
                flags = gg.TYPE_DWORD,
                value = 0,
                freeze = true,
                name = monster.name .. " (" .. monster.id .. ")"
            }
            
            table.insert(foundAddresses, addressInfo)
            totalFound = totalFound + 1
            
            -- Показываем прогресс
            if foundForThisMonster <= 3 then -- Показываем только первые 3 для краткости
                -- Определяем эмоджи для типа персонажа
                local emoji = "🎮"
                if monster.name:find("🌪️") then
                    emoji = "🌪️"
                elseif monster.name:find("🌊") then
                    emoji = "🌊"
                elseif monster.name:find("🔥") then
                    emoji = "🔥"
                end
                
                gg.toast(emoji .. " " .. monster.name:gsub("[🌪️🌊🔥]", ""):gsub("^%s*(.-)%s*$", "%1") .. 
                        " #" .. foundForThisMonster .. 
                        "\nАдрес: " .. string.format("%X", v.address))
            end
        end
    end
    
    searchDetails = searchDetails .. "  Заморожено: " .. foundForThisMonster .. " адресов\n\n"
    
    -- Если не найдено ни одного адреса с основным ID
    if foundForThisMonster == 0 then
        -- Определяем эмоджи для типа персонажа
        local emoji = "🎮"
        if monster.name:find("🌪️") then
            emoji = "🌪️"
        elseif monster.name:find("🌊") then
            emoji = "🌊"
        elseif monster.name:find("🔥") then
            emoji = "🔥"
        end
        
        gg.toast(emoji .. " Для " .. monster.name:gsub("[🌪️🌊🔥]", ""):gsub("^%s*(.-)%s*$", "%1") .. 
                " не найдено адресов с ID " .. monster.id)
    else
        -- Определяем эмоджи для типа персонажа
        local emoji = "🎮"
        if monster.name:find("🌪️") then
            emoji = "🌪️"
        elseif monster.name:find("🌊") then
            emoji = "🌊"
        elseif monster.name:find("🔥") then
            emoji = "🔥"
        end
        
        gg.toast(emoji .. " Для " .. monster.name:gsub("[🌪️🌊🔥]", ""):gsub("^%s*(.-)%s*$", "%1") .. 
                " найдено: " .. foundForThisMonster .. " адресов")
    end
    
    gg.sleep(300) -- Уменьшил паузу между поисками
end

-- Проверяем результаты
if totalFound == 0 then
    local message = "❌ Персонажи не найдены!\n\n"
    
    message = message .. "Детали поиска:\n" .. searchDetails .. "\n"
    
    message = message .. "Возможные причины:\n"
    message = message .. "1. Персонажи не в битве\n"
    message = message .. "2. Неправильные ID\n"
    message = message .. "3. Игра обновилась\n\n"
    message = message .. "Попробуйте:\n"
    message = message .. "1. Войти в битву с персонажами\n"
    message = message .. "2. Перезапустить игру\n"
    message = message .. "3. Проверить актуальность ID"
    
    gg.alert(message)
    return
end

-- Подтверждение перед заморозкой
local confirmMsg = "📋 БУДУТ ЗАМОРОЖЕНЫ:\n\n"
for _, monster in ipairs(targets) do
    local count = 0
    for _, item in ipairs(foundAddresses) do
        if string.find(item.name, monster.name) then
            count = count + 1
        end
    end
    if count > 0 then
        confirmMsg = confirmMsg .. "• " .. monster.name .. ": " .. count .. " адресов\n"
    end
end

confirmMsg = confirmMsg .. "\nВсего адресов: " .. totalFound .. "\n"
confirmMsg = confirmMsg .. "\nПродолжить заморозку?"

local confirm = gg.alert(confirmMsg, "✅ ЗАМОРОЗИТЬ", "❌ ОТМЕНА")

if confirm ~= 1 then
    gg.toast("❌ Отменено пользователем")
    return
end

-- Меняем значения на 0
gg.setValues(foundAddresses)
gg.toast("❄️ Изменяю значения на 0...")

-- Добавляем в список GG
gg.clearList()
for _, item in ipairs(foundAddresses) do
    gg.addListItems({item})
end

-- Включаем заморозку
gg.toast("🔒 Включаю заморозку...")
local listItems = gg.getListItems()
for _, item in ipairs(listItems) do
    item.freeze = true
    item.value = 0
    gg.setValues({item}) -- Обновляем каждый отдельно для надежности
end

-- Формируем финальный отчет
local report = "✅ ЗАМОРОЗКА ВЫПОЛНЕНА!\n\n"
local summary = {}

-- Группируем по элементам
local elements = {
    {"🌪️ Ветер:", {}},
    {"🌊 Вода:", {}},
    {"🔥 Огонь:", {}}
}

for _, monster in ipairs(targets) do
    local count = 0
    for _, item in ipairs(foundAddresses) do
        if string.find(item.name, monster.name) then
            count = count + 1
        end
    end
    if count > 0 then
        -- Определяем к какому элементу принадлежит
        if monster.name:find("🌪️") then
            table.insert(elements[1][2], monster.name .. ": " .. count .. " адресов")
        elseif monster.name:find("🌊") then
            table.insert(elements[2][2], monster.name .. ": " .. count .. " адресов")
        elseif monster.name:find("🔥") then
            table.insert(elements[3][2], monster.name .. ": " .. count .. " адресов")
        end
    end
end

-- Добавляем в отчет
for _, elem in ipairs(elements) do
    if #elem[2] > 0 then
        report = report .. elem[1] .. "\n"
        for _, item in ipairs(elem[2]) do
            report = report .. "  " .. item .. "\n"
        end
        report = report .. "\n"
    end
end

report = report .. "📊 ИТОГО:\n"
report = report .. "• Всего заморожено: " .. totalFound .. " адресов\n"
report = report .. "• Значения изменены на 0\n"
report = report .. "• Заморозка включена\n"
report = report .. "\n🎮 Готово к игре!"

-- Показываем детали поиска в отдельном окне
gg.alert(report)

-- Дополнительная проверка
gg.sleep(300)
local frozenItems = gg.getListItems()
local activeFreeze = 0
for _, item in ipairs(frozenItems) do
    if item.freeze then
        activeFreeze = activeFreeze + 1
    end
end

if activeFreeze > 0 then
    gg.toast("🎮 Заморожено " .. activeFreeze .. " адресов!")
else
    gg.toast("⚠️ Заморозка не активирована!")
end

-- Инструкция для пользователя
gg.sleep(500)
gg.alert("💡 ИНСТРУКЦИЯ:\n\n" ..
         "1. Откройте GameGuardian\n" ..
         "2. Нажмите на значок списка (📋)\n" ..
         "3. Убедитесь что все адреса:\n" ..
         "   • Имеют значение 0\n" ..
         "   • Иконка снежинки ❄️ активна\n" ..
         "4. Вернитесь в игру")
