--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Carpet Cleaning - By Sqilss",
   LoadingTitle = "Carpet Cleaning Sqilss",
   LoadingSubtitle = "Auto Perfect Job + Auto Complete",
   ConfigurationSaving = { Enabled = true, FolderName = "CarpetCleaning", FileName = "Config" }
})

local Tab = Window:CreateTab("Main Farm", 4483362458)

Tab:CreateSection("Auto Job Complete (Unchanged)")

local autoComplete = false
local perfectMode = true

Tab:CreateToggle({
   Name = "Auto Request Job Complete",
   CurrentValue = false,
   Callback = function(Value)
      autoComplete = Value
      if Value then
         spawn(function()
            while autoComplete do
               pcall(function()
                  if perfectMode then
                     game.ReplicatedStorage.Remotes.RequestJobComplete:FireServer(1.0, 9999)
                     game.ReplicatedStorage.Remotes.RequestJobComplete:FireServer(0.9999, 9999)
                  else
                     game.ReplicatedStorage.Remotes.RequestJobComplete:FireServer(1.0, 0)
                     game.ReplicatedStorage.Remotes.RequestJobComplete:FireServer(0.999, 999)
                  end
                  game.ReplicatedStorage.Remotes.JobComplete:FireServer()
               end)
               task.wait(0.4)
            end
         end)
      end
   end,
})

Tab:CreateToggle({
   Name = "Perfect Clean Mode (100%)",
   CurrentValue = true,
   Callback = function(Value)
      perfectMode = Value
   end,
})

Tab:CreateButton({
   Name = "One-Time Perfect Complete",
   Callback = function()
      game.ReplicatedStorage.Remotes.RequestJobComplete:FireServer(1.0, 9999)
      game.ReplicatedStorage.Remotes.JobComplete:FireServer()
   end,
})

Tab:CreateSection("Job Selector - Perfect Mode")

local selectedRoom = "Office"

Tab:CreateDropdown({
   Name = "Select Room",
   Options = {"Bedroom", "LivingRoom", "Office", "Dining Room", "Hotel Room", "Restaurant Floor", "Mansion Hall", "Cottage","Hotel Floor","Hanger" },
   CurrentOption = {"Office"},
   Callback = function(CurrentOption)
      selectedRoom = CurrentOption[1]
   end,
})

-- Contract Type now includes "Perfect"
local selectedContract = "Perfect"
Tab:CreateDropdown({
   Name = "Contract Type",
   Options = {"Normal", "Speed", "Perfect"},
   CurrentOption = {"Perfect"},
   Callback = function(CurrentOption)
      selectedContract = CurrentOption[1]
   end,
})

local autoJobLoop = false
Tab:CreateToggle({
   Name = "Auto Loop Selected Job",
   CurrentValue = false,
   Callback = function(Value)
      autoJobLoop = Value
      if Value then
         spawn(function()
            while autoJobLoop do
               pcall(function()
                  game.ReplicatedStorage.Remotes.AbandonJob:FireServer()
                  task.wait(0.8)
                  game.ReplicatedStorage.Remotes.SelectJob:FireServer(selectedRoom, selectedContract)
               end)
               task.wait(3.5)   -- slightly longer delay for Perfect jobs
            end
         end)
      end
   end,
})

Tab:CreateButton({
   Name = "Select Job Once (Perfect)",
   Callback = function()
      game.ReplicatedStorage.Remotes.AbandonJob:FireServer()
      task.wait(0.5)
      game.ReplicatedStorage.Remotes.SelectJob:FireServer(selectedRoom, selectedContract)
      Rayfield:Notify("Selected", selectedRoom .. " (Perfect)", 4483362458)
   end,
})

Tab:CreateSection("Extras")

Tab:CreateButton({
   Name = "Abandon Current Job",
   Callback = function()
      game.ReplicatedStorage.Remotes.AbandonJob:FireServer()
   end,
})
