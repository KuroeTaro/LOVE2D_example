local i = love.thread.getChannel( 'inputChannel' ):demand()
if i then
    i = i + 1
end
love.thread.getChannel( 'outputChannel' ):supply(i)
