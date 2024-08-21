local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function createGuiElement(class, properties)
    local element = Instance.new(class)
    for k, v in pairs(properties) do
        element[k] = v
    end
    return element
end

local mainGui = createGuiElement("ScreenGui", {
    Name = "CustomEGOGiftGUI",
    ResetOnSpawn = false,
    Parent = playerGui
})

local mainFrame = createGuiElement("Frame", {
    Size = UDim2.new(0.4, 0, 0.8, 0),
    Position = UDim2.new(0.3, 0, 0.1, 0),
    BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
    BorderSizePixel = 0,
    Active = true,
    Parent = mainGui
})

createGuiElement("UICorner", {
    CornerRadius = UDim.new(0.02, 0),
    Parent = mainFrame
})

local titleBar = createGuiElement("Frame", {
    Size = UDim2.new(1, 0, 0.08, 0),
    BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
    Parent = mainFrame
})

createGuiElement("UICorner", {
    CornerRadius = UDim.new(0.2, 0),
    Parent = titleBar
})

createGuiElement("TextLabel", {
    Size = UDim2.new(0.7, 0, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundTransparency = 1,
    Text = "饰品选择器",
    TextColor3 = Color3.new(1, 1, 1),
    TextScaled = true,
    Parent = titleBar
})

local minimizeButton = createGuiElement("TextButton", {
    Size = UDim2.new(0.15, 0, 1, 0),
    Position = UDim2.new(0.7, 0, 0, 0),
    BackgroundColor3 = Color3.new(0.3, 0.3, 0.3),
    Text = "-",
    TextColor3 = Color3.new(1, 1, 1),
    TextScaled = true,
    Parent = titleBar
})

local closeButton = createGuiElement("TextButton", {
    Size = UDim2.new(0.15, 0, 1, 0),
    Position = UDim2.new(0.85, 0, 0, 0),
    BackgroundColor3 = Color3.new(0.8, 0.2, 0.2),
    Text = "X",
    TextColor3 = Color3.new(1, 1, 1),
    TextScaled = true,
    Parent = titleBar
})

local contentFrame = createGuiElement("Frame", {
    Size = UDim2.new(1, 0, 0.92, 0),
    Position = UDim2.new(0, 0, 0.08, 0),
    BackgroundTransparency = 1,
    Parent = mainFrame
})

local items = {}
for _, item in pairs(ReplicatedStorage.EGOGear.EGOGift:GetChildren()) do
    table.insert(items, item.Name)
end
table.sort(items)

local positions = {"Eyes", "Brooch", "Mouth", "Back", "Cheek", "RightBack", "Helmet", "Hat2", "Hat"}

local selectedItem = ""
local selectedPosition = ""

local function createDropdown(parent, items, yOffset, onSelect)
    local dropdown = createGuiElement("ScrollingFrame", {
        Size = UDim2.new(0.9, 0, 0.4, 0),
        Position = UDim2.new(0.05, 0, yOffset, 0),
        BackgroundColor3 = Color3.new(0.25, 0.25, 0.25),
        Visible = false,
        ScrollBarThickness = 6,
        Parent = parent
    })
    
    createGuiElement("UICorner", {
        CornerRadius = UDim.new(0.05, 0),
        Parent = dropdown
    })
    
    local UIListLayout = createGuiElement("UIListLayout", {
        Parent = dropdown,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5)
    })

    for i, item in ipairs(items) do
        local button = createGuiElement("TextButton", {
            Size = UDim2.new(1, -10, 0, 40),
            BackgroundColor3 = Color3.new(0.3, 0.3, 0.3),
            Text = item,
            TextColor3 = Color3.new(1, 1, 1),
            TextScaled = true,
            LayoutOrder = i,
            Parent = dropdown
        })
        
        createGuiElement("UICorner", {
            CornerRadius = UDim.new(0.1, 0),
            Parent = button
        })
        
        button.MouseButton1Click:Connect(function()
            onSelect(item)
            dropdown.Visible = false
        end)
    end
    
    dropdown.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    
    return dropdown
end

local itemDropdown = createGuiElement("TextButton", {
    Size = UDim2.new(0.9, 0, 0.1, 0),
    Position = UDim2.new(0.05, 0, 0.05, 0),
    BackgroundColor3 = Color3.new(0.3, 0.3, 0.3),
    Text = "选择饰品",
    TextColor3 = Color3.new(1, 1, 1),
    TextScaled = true,
    Parent = contentFrame
})

createGuiElement("UICorner", {
    CornerRadius = UDim.new(0.1, 0),
    Parent = itemDropdown
})

local positionDropdown = createGuiElement("TextButton", {
    Size = UDim2.new(0.9, 0, 0.1, 0),
    Position = UDim2.new(0.05, 0, 0.2, 0),
    BackgroundColor3 = Color3.new(0.3, 0.3, 0.3),
    Text = "选择位置",
    TextColor3 = Color3.new(1, 1, 1),
    TextScaled = true,
    Parent = contentFrame
})

createGuiElement("UICorner", {
    CornerRadius = UDim.new(0.1, 0),
    Parent = positionDropdown
})

local confirmButton = createGuiElement("TextButton", {
    Size = UDim2.new(0.6, 0, 0.1, 0),
    Position = UDim2.new(0.2, 0, 0.35, 0),
    BackgroundColor3 = Color3.new(0, 0.7, 0),
    Text = "确认",
    TextColor3 = Color3.new(1, 1, 1),
    TextScaled = true,
    Parent = contentFrame
})

createGuiElement("UICorner", {
    CornerRadius = UDim.new(0.2, 0),
    Parent = confirmButton
})

local minimizedButton = createGuiElement("TextButton", {
    Size = UDim2.new(0, 50, 0, 50),
    Position = UDim2.new(1, -60, 1, -60),
    AnchorPoint = Vector2.new(1, 1),
    BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
    Text = "+",
    TextColor3 = Color3.new(1, 1, 1),
    TextScaled = true,
    Visible = false,
    Parent = mainGui
})

createGuiElement("UICorner", {
    CornerRadius = UDim.new(0.5, 0),
    Parent = minimizedButton
})

local itemsDropdown = createDropdown(contentFrame, items, 0.15, function(item)
    selectedItem = item
    itemDropdown.Text = item
end)

local positionsDropdown = createDropdown(contentFrame, positions, 0.3, function(position)
    selectedPosition = position
    positionDropdown.Text = position
end)

itemDropdown.MouseButton1Click:Connect(function()
    itemsDropdown.Visible = not itemsDropdown.Visible
    positionsDropdown.Visible = false
end)

positionDropdown.MouseButton1Click:Connect(function()
    positionsDropdown.Visible = not positionsDropdown.Visible
    itemsDropdown.Visible = false
end)

confirmButton.MouseButton1Click:Connect(function()
    if selectedItem ~= "" and selectedPosition ~= "" then
        local args = {selectedItem, selectedPosition}
        ReplicatedStorage.Events.ObtainGift:FireServer(unpack(args))
        StarterGui:SetCore("SendNotification", {
            Title = "成功",
            Text = "已装备 " .. selectedItem .. " 到 " .. selectedPosition,
            Duration = 3
        })
    else
        StarterGui:SetCore("SendNotification", {
            Title = "错误",
            Text = "请选择饰品和位置",
            Duration = 3
        })
    end
end)

local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizedButton.Visible = true
    isMinimized = true
end)

minimizedButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    minimizedButton.Visible = false
    isMinimized = false
end)

closeButton.MouseButton1Click:Connect(function()
    mainGui:Destroy()
end)

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        local position = input.Position
        local guiObjects = playerGui:GetGuiObjectsAtPosition(position.X, position.Y)
        for _, obj in ipairs(guiObjects) do
            if obj.Parent == mainFrame then
                return
            end
        end
        itemsDropdown.Visible = false
        positionsDropdown.Visible = false
    end
end)

local function enableDragging(frame)
    local dragToggle = nil
    local dragSpeed = 0 -- 设置为0以去除动画
    local dragStart = nil
    local startPos = nil

    local function updateInput(input)
        local delta = input.Position - dragStart
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        frame.Position = position
    end

    frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragToggle then
                updateInput(input)
            end
        end
    end)
end

enableDragging(mainFrame)
enableDragging(minimizedButton)
