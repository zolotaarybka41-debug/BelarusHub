-- BELARUS HUB v1.0 (Murder Mystery 2)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 240, 0, 220)
Frame.Position = UDim2.new(0.5, -120, 0.4, -110)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(0, 150, 50) -- Зеленая рамка
Frame.Active = true
Frame.Draggable = true

-- Кастомный Красно-Зеленый Дизайн (Belarus Style)
local TopHeader = Instance.new("Frame", Frame)
TopHeader.Size = UDim2.new(1, 0, 0, 30)
TopHeader.BackgroundColor3 = Color3.fromRGB(200, 0, 0) -- Красный верх

local Title = Instance.new("TextLabel", TopHeader)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "BELARUS HUB MM2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

-- Функция 1: Авто-фарм монет
local Btn1 = Instance.new("TextButton", Frame)
Btn1.Size = UDim2.new(0, 220, 0, 35)
Btn1.Position = UDim2.new(0, 10, 0, 40)
Btn1.BackgroundColor3 = Color3.fromRGB(0, 120, 40) -- Зеленые кнопки
Btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn1.Text = "Auto-Farm Coins"
Btn1.MouseButton1Click:Connect(function()
    _G.CoinFarm = not _G.CoinFarm
    Btn1.Text = _G.CoinFarm and "Farm: ON" or "Auto-Farm Coins"
    while _G.CoinFarm do
        task.wait(0.4)
        local coin = workspace:FindFirstChild("CoinContainer", true) or workspace:FindFirstChild("GoldCoin", true)
        if coin and game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = coin.CFrame
        end
    end
end)

-- Функция 2: ESP (Подсветка ролей)
local Btn2 = Instance.new("TextButton", Frame)
Btn2.Size = UDim2.new(0, 220, 0, 35)
Btn2.Position = UDim2.new(0, 10, 0, 80)
Btn2.BackgroundColor3 = Color3.fromRGB(0, 120, 40)
Btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn2.Text = "Player ESP"
Btn2.MouseButton1Click:Connect(function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character and not p.Character:FindFirstChild("Highlight") then
            local hl = Instance.new("Highlight", p.Character)
            hl.FillSize = 0.5
            if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                hl.FillColor = Color3.fromRGB(255, 0, 0) -- Убийца (Красный)
            elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then
                hl.FillColor = Color3.fromRGB(0, 0, 255) -- Шериф (Синий)
            else
                hl.FillColor = Color3.fromRGB(0, 255, 0) -- Мирный (Зеленый)
            end
        end
    end
end)

-- Функция 3: Shoot Murderer (Аимбот/Авто-выстрел в убийцу, если ты Шериф)
local Btn3 = Instance.new("TextButton", Frame)
Btn3.Size = UDim2.new(0, 220, 0, 35)
Btn3.Position = UDim2.new(0, 10, 0, 120)
Btn3.BackgroundColor3 = Color3.fromRGB(0, 120, 40)
Btn3.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn3.Text = "Auto-Shoot Murderer"
Btn3.MouseButton1Click:Connect(function()
    _G.AutoShoot = not _G.AutoShoot
    Btn3.Text = _G.AutoShoot and "Aim: ACTIVE" or "Auto-Shoot Murderer"
    while _G.AutoShoot do
        task.wait(0.2)
        local character = game.Players.LocalPlayer.Character
        local gun = character and (character:FindFirstChild("Gun") or game.Players.LocalPlayer.Backpack:FindFirstChild("Gun"))
        if gun then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p.Character and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then
                    local mRoot = p.Character:FindFirstChild("HumanoidRootPart")
                    if mRoot and character:FindFirstChild("HumanoidRootPart") then
                        -- Авто-наведение и выстрел
                        character.HumanoidRootPart.CFrame = CFrame.lookAt(character.HumanoidRootPart.Position, mRoot.Position)
                        gun:Activate()
                    end
                end
            end
        end
    end
end)

-- Главная защита от кика (Анти-АФК)
local Btn4 = Instance.new("TextButton", Frame)
Btn4.Size = UDim2.new(0, 220, 0, 35)
Btn4.Position = UDim2.new(0, 10, 0, 160)
Btn4.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- Красная кнопка закрытия
Btn4.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn4.Text = "Close Hub"
Btn4.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Скрытый встроенный Анти-АФК, чтобы сервер не кикал за простой
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
