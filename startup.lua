local websocketUrl = "ws://marble-almond-cleft.glitch.me:80"

-- Open a WebSocket connection
local ws, err = http.websocket(websocketUrl)
if not ws then
    print("Error connecting to WebSocket: " .. err)
    return
end

print("Connected to WebSocket server.")

while true do
    -- Wait for a message from the WebSocket server
    local msg, err = ws.receive()
    if msg then
        print("Received code: " .. msg)
        local func, loadErr = load(msg)
        if func then
            local success, runErr = pcall(func)
            if not success then
                print("Error running code: " .. runErr)
            end
        else
            print("Error loading code: " .. loadErr)
        end
    else
        print("Error receiving message: " .. err)
        break
    end
end

-- Close the WebSocket connection
ws.close()
print("Disconnected from WebSocket server.")
