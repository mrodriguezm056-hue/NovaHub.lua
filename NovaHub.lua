-- NovaHub Demo | Interfaz visual Lua
-- Solo demostrativo: no incluye trampas ni modifica partidas.
-- Uso: aloja este archivo en un servicio que ofrezca una URL RAW.
-- Luego: loadstring(game:HttpGet("TU_URL_RAW"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
if not player then
    warn("NovaHub Demo debe ejecutarse en un contexto de cliente.")
    return
end

local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("NovaHubDemo")
if old then
    old:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "NovaHubDemo"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(620, 390)
main.Position = UDim2.new(0.5, -310, 0.5, -195)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(75, 57, 100)
stroke.Thickness = 1
stroke.Parent = main

local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 155, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(13, 13, 17)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 10)
sideCorner.Parent = sidebar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 55)
title.Position = UDim2.fromOffset(12, 5)
title.BackgroundTransparency = 1
title.Text = "✦ NOVAHUB"
title.TextColor3 = Color3.fromRGB(170, 115, 255)
title.TextSize = 21
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = sidebar

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -20, 0, 18)
subtitle.Position = UDim2.fromOffset(12, 42)
subtitle.BackgroundTransparency = 1
subtitle.Text = "DEMO • UI HUB"
subtitle.TextColor3 = Color3.fromRGB(115, 110, 130)
subtitle.TextSize = 9
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = sidebar

local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.fromOffset(170, 15)
content.Size = UDim2.new(1, -185, 1, -30)
content.BackgroundTransparency = 1
content.Parent = main

local pages = {}
local selected = nil

local function createPage(name)
    local page = Instance.new("Frame")
    page.Name = name:gsub("%W", "")
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = content
    pages[name] = page

    local heading = Instance.new("TextLabel")
    heading.Size = UDim2.new(1, 0, 0, 40)
    heading.BackgroundTransparency = 1
    heading.Text = name
    heading.TextColor3 = Color3.new(1, 1, 1)
    heading.TextSize = 23
    heading.Font = Enum.Font.GothamBold
    heading.TextXAlignment = Enum.TextXAlignment.Left
    heading.Parent = page

    return page
end

local function addLabel(page, text, y)
    local label = Instance.new("TextLabel")
    label.Position = UDim2.fromOffset(0, y)
    label.Size = UDim2.new(1, -10, 0, 45)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(185, 185, 198)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.Parent = page
    return label
end

local function addButton(page, text, y, callback)
    local button = Instance.new("TextButton")
    button.Position = UDim2.fromOffset(0, y)
    button.Size = UDim2.new(1, -10, 0, 38)
    button.BackgroundColor3 = Color3.fromRGB(42, 34, 57)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = text
    button.TextSize = 14
    button.Font = Enum.Font.GothamMedium
    button.AutoButtonColor = true
    button.Parent = page

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.Activated:Connect(callback)
    return button
end

local home = createPage("Inicio")
addLabel(home, "Bienvenido a NovaHub Demo. Selecciona una pestaña para explorar el menú.", 55)
addLabel(home, "Estado: interfaz cargada correctamente.", 110)

local aim = createPage("Aimbot")
addLabel(aim, "Panel demostrativo. No realiza apuntado automático ni modifica la partida.", 55)
addButton(aim, "Mostrar estado de ejemplo", 110, function()
    addLabel(aim, "Demo activa: ninguna acción de apuntado está habilitada.", 160)
end)

local silent = createPage("Silent Aim")
addLabel(silent, "Panel visual de muestra; no modifica disparos ni objetivos.", 55)

local visuals = createPage("Visuals")
addLabel(visuals, "Cambia el color de acento del menú.", 55)
addButton(visuals, "Acento morado", 110, function()
    title.TextColor3 = Color3.fromRGB(170, 115, 255)
end)
addButton(visuals, "Acento azul", 158, function()
    title.TextColor3 = Color3.fromRGB(90, 170, 255)
end)
addButton(visuals, "Acento verde", 206, function()
    title.TextColor3 = Color3.fromRGB(90, 220, 160)
end)

local hitbox = createPage("Hitbox Expander")
addLabel(hitbox, "Panel demostrativo. No cambia el tamaño de personajes ni sus hitboxes.", 55)

local automation = createPage("Automatización")
addLabel(automation, "Prueba una acción local de la interfaz.", 55)
addButton(automation, "Probar notificación", 110, function()
    local toast = Instance.new("TextLabel")
    toast.Name = "NovaHubToast"
    toast.Size = UDim2.fromOffset(280, 44)
    toast.Position = UDim2.new(0.5, -140, 0.82, 0)
    toast.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
    toast.TextColor3 = Color3.new(1, 1, 1)
    toast.Text = "NovaHub: botón funcionando"
    toast.Font = Enum.Font.GothamMedium
    toast.TextSize = 14
    toast.Parent = gui

    local toastCorner = Instance.new("UICorner")
    toastCorner.CornerRadius = UDim.new(0, 8)
    toastCorner.Parent = toast

    task.delay(2.5, function()
        if toast.Parent then
            toast:Destroy()
        end
    end)
end)

local settings = createPage("Ajustes")
addLabel(settings, "Controla la visibilidad del menú.", 55)
addButton(settings, "Ocultar NovaHub", 110, function()
    main.Visible = false
end)
addButton(settings, "Mostrar NovaHub", 158, function()
    main.Visible = true
end)
addButton(settings, "Cerrar NovaHub", 206, function()
    gui:Destroy()
end)

local names = {
    "Inicio", "Aimbot", "Silent Aim", "Visuals",
    "Hitbox Expander", "Automatización", "Ajustes"
}

local function showPage(name)
    if selected and pages[selected] then
        pages[selected].Visible = false
    end
    pages[name].Visible = true
    selected = name
end

for i, name in ipairs(names) do
    local button = Instance.new("TextButton")
    button.Name = "Tab" .. i
    button.Position = UDim2.fromOffset(10, 68 + (i - 1) * 43)
    button.Size = UDim2.new(1, -20, 0, 36)
    button.BackgroundColor3 = Color3.fromRGB(29, 27, 35)
    button.TextColor3 = Color3.fromRGB(225, 225, 235)
    button.Text = name
    button.TextSize = 13
    button.Font = Enum.Font.GothamMedium
    button.AutoButtonColor = true
    button.Parent = sidebar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.Activated:Connect(function()
        showPage(name)
    end)
end

-- Permite arrastrar la ventana usando la barra lateral.
local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragInput
local dragStart
local startPosition

sidebar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

sidebar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

showPage("Inicio")
