# DU-MachineControl
- Dual Universe Machine Control Unit Script still in development.
- Note: Script to manage up to 10 machine units per screen.

# MachineControl Instructions:
- 1.Paste MachineControl.lua script to a programming board. 
- 2.Link receiver note:"must be assigned to slot1."
- 3.Link screen, tile pad, and emitter to the programming board. 

# MachineUpdateControl Instructions:
- 1.Paste MachineControl.lua script to a programming board. 
- 2.Link receiver note:"must be assigned to slot1."
- 3.Link Databank
- 4.Link up to 5 Machines to the programming board. 
- 5.Repeat steps 1-3 if you want to manage 5 more machines.
# First Use
- 1.Right click on MachineControl programming board > Advanced > Edit LUA parameters
- 2.Update Schematics for each slot S1-S10ProductID if you want to assign a separate product per machine otherwise just update SAllProductID which will be used on each machine.
- 3.Toggle Set1ForAll checkbox if you want to use Schematics per assigned slots or just 1 schematic for all.
- 4.Update SendChannel to any name you want to use specifically for that industry set.
- 5.Run the programming board once before use to update the ChannelID to the DB.
- 6.Setup is complete and you can now update your industry units without having to touch each unit.

# HotKeys:
- Alt+1 = softstop
- Alt+2 = hardstop
- Alt+3 = start
- Alt+4 = batch "WIP"
- Alt+5 = maintain "WIP"
- Alt+6 = Update Schematics & start
