{"slots":{"0":{"name":"slot1","type":{"events":[],"methods":[]}},"1":{"name":"slot2","type":{"events":[],"methods":[]}},"2":{"name":"slot3","type":{"events":[],"methods":[]}},"3":{"name":"slot4","type":{"events":[],"methods":[]}},"4":{"name":"slot5","type":{"events":[],"methods":[]}},"5":{"name":"slot6","type":{"events":[],"methods":[]}},"6":{"name":"slot7","type":{"events":[],"methods":[]}},"7":{"name":"slot8","type":{"events":[],"methods":[]}},"8":{"name":"slot9","type":{"events":[],"methods":[]}},"9":{"name":"slot10","type":{"events":[],"methods":[]}},"-1":{"name":"unit","type":{"events":[],"methods":[]}},"-3":{"name":"player","type":{"events":[],"methods":[]}},"-2":{"name":"construct","type":{"events":[],"methods":[]}},"-4":{"name":"system","type":{"events":[],"methods":[]}},"-5":{"name":"library","type":{"events":[],"methods":[]}}},"handlers":[{"code":"if message == \"1\" then unit.setTimer(\"softstop\") end\nif message == \"2\" then unit.setTimer(\"hardstop\") end\nif message == \"3\" then unit.setTimer(\"run\") end\nif message == \"4\" then unit.setTimer(\"batch\") end\nif message == \"5\" then unit.setTimer(\"maintain\") end\nif message == \"6\" then\n    unit.setTimer(\"softstop\")\n    unit.setTimer(\"update\",0.6)\nend","filter":{"args":[{"value":"ch2"},{"variable":"*"}],"signature":"onReceived(channel,message)","slotKey":"0"},"key":"0"},{"code":"for i, machine in ipairs(g_slots) do\n            machine.stop(0,0)    \nend\nunit.stopTimer(\"softstop\")","filter":{"args":[{"value":"softstop"}],"signature":"onTimer(tag)","slotKey":"-1"},"key":"1"},{"code":"for i, machine in ipairs(g_slots) do\n            machine.stop(1,0)    \nend\nunit.stopTimer(\"hardstop\")","filter":{"args":[{"value":"hardstop"}],"signature":"onTimer(tag)","slotKey":"-1"},"key":"2"},{"code":"if db.getStringValue(1 .. \"TF\") == \"True\" then\nsystem.print(\"started\")\nfor i, machine in ipairs(g_slots) do\nmachine.setOutput(db.getStringValue(1 .. \"A\"))\nmachine.startRun()  \nend    \nelseif db.getStringValue(1 .. \"TF\") == \"False\" then\n    for i, machine in ipairs(g_slots) do\n    if i == 1 then g_slots[1].setOutput(db.getStringValue(1 .. \"S\")) end\n    if i == 2 then g_slots[2].setOutput(db.getStringValue(1 .. \"S\")) end \n    if i == 3 then g_slots[3].setOutput(db.getStringValue(1 .. \"S\")) end \n    if i == 4 then g_slots[4].setOutput(db.getStringValue(1 .. \"S\")) end \n    if i == 5 then g_slots[5].setOutput(db.getStringValue(1 .. \"S\")) end\n        machine.startRun()    \n    end\nend\nunit.stopTimer(\"update\") ","filter":{"args":[{"value":"update"}],"signature":"onTimer(tag)","slotKey":"-1"},"key":"3"},{"code":"system.print(\"started batch\")\nfor i, machine in ipairs(g_slots) do\nmachine.startFor(db.getStringValue(1 .. \"B\"))  \nend    \nunit.stopTimer(\"batch\") ","filter":{"args":[{"value":"batch"}],"signature":"onTimer(tag)","slotKey":"-1"},"key":"4"},{"code":"--Receiver.onReceived(SendChannelID,message)\nsystem.print(\"started\")\nfor i, machine in ipairs(g_slots) do\nmachine.startRun()  \nend    \nunit.stopTimer(\"run\") ","filter":{"args":[{"value":"run"}],"signature":"onTimer(tag)","slotKey":"-1"},"key":"5"},{"code":"system.print(\"started maintain\")\nfor i, machine in ipairs(g_slots) do\nmachine.startMaintain(db.getStringValue(1 .. \"M\"))  \nend    \nunit.stopTimer(\"maintain\")","filter":{"args":[{"value":"maintain"}],"signature":"onTimer(tag)","slotKey":"-1"},"key":"6"},{"code":"displayStatus(g_slots)","filter":{"args":[{"value":"dbupdate"}],"signature":"onTimer(tag)","slotKey":"-1"},"key":"7"},{"code":"system.print(\"----------------------------------\")\nsystem.print(\"Machine Update Control v0.1\")\nsystem.print(\"----------------------------------\")\n\n-------------------------------------------------------------------------------------\n\nlocal Color = \"50,100,255\" --export: Main color RGB value\nlocal FontColor = \"255,255,255\" --export Font color RGB value\n\n-------------------------------------------------------------------------------------\n--db.clear()\nfor slot_name, slot in pairs(unit) do\n    if type(slot) == \"table\"\n        and type(slot.export) == \"table\"\n        and slot.getClass\n        then\n        if slot.getClass() == 'ScreenUnit' then\n            Screen = slot\n            slot.activate()\n   --     elseif slot.getClass() == 'EmitterUnit' then\n   --         Emitter = slot\n        elseif slot.getClass() == 'ReceiverUnit' then\n            Receiver = slot\n        elseif slot.getClass() == 'DataBankUnit' then\n            db = slot \n        end\n    end \nend\n\nall_slots = { slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10,}\ng_slots = {}\nfor i, machine in ipairs(all_slots) do\nif machine.getClass() == 'Industry1' then\n table.insert(g_slots, machine)\nelseif machine.getClass() == 'Industry2' then\n table.insert(g_slots, machine)\nelseif machine.getClass() == 'Industry3' then\n table.insert(g_slots, machine)\nelseif machine.getClass() == 'Industry4' then\n table.insert(g_slots, machine)\nelseif machine.getClass() == 'Industry5' then\n table.insert(g_slots, machine)\nend\nend\n\nChannelID = \"ch2\" --export\nSendChannelID = \"ch1\" --export\nunit.setTimer(\"dbupdate\",1)\n\n\n\n","filter":{"args":[],"signature":"onStart()","slotKey":"-1"},"key":"8"},{"code":"\nfunction displayStatus(slots)\n    local arr = {}\n    for i, machine in ipairs(slots) do\n        machinestatus = machine.getState()\n\nif machinestatus == 1 then arr[i] = \"Stopped\"\nelseif machinestatus == 2 then arr[i] = \"Running\"\nelseif machinestatus == 3 then arr[i] = \"Missing Ingredients\"\nelseif machinestatus == 4 then arr[i] = \"Output Full\"\nelseif machinestatus == 5 then arr[i] = \"No Output Container\"\nelseif machinestatus == 6 then arr[i] = \"Pending\"\nelseif machinestatus == 7 then arr[i] = \"Missing Schematics\"\nend\n\ndb.setStringValue(i,arr[i])\ninfo = machine.getInfo()\nitem = system.getItem(info.currentProducts[1].id)\nitem2 = item.locDisplayNameWithSize\ndb.setStringValue(i .. \"P\",item2)\n    end\nend\n","filter":{"args":[],"signature":"onStart()","slotKey":"-5"},"key":"9"}],"methods":[],"events":[]}