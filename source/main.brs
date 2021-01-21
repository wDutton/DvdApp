' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 

Sub Main()
    m.W = 1280
    m.H = 720
    screen=CreateObject("roScreen", true, m.W, m.H)
    if type(screen) <> "roScreen"
        print "Unable to open screen"
        return
    endif
    msgport = CreateObject("roMessagePort")
    m.dvdLogo = CreateObject("roBitMap", "pkg:/images/dvdLogo.jpg")
    m.xVal = 10
    m.yVal = 10
    m.xSpeed = 1
    m.ySpeed = 1
    background=&h000000ff
    screen.SetPort(msgport)
    screen.Clear(background)
    screen.SetAlphaEnable(true)
    DrawImg(screen)
End Sub

Sub DrawImg(scr as object)
    port = scr.GetPort()
    cw = int(scr.getwidth()/2)
    ch = int(scr.getheight()/2)
    
    
    while true
        
        
        msg = wait(11, port)
        if type(msg) = "roUniversalControlEvent" then
                print "button pressed: " msg.GetInt()           
        end if
        'print "xValue: "  m.xVal "    -     yValue: " m.yVal
        
        checkForBorderCollision()
        DrawNewRectangle(scr)
        
        
    end while
end sub


Sub DrawNewRectangle(scr as Object)
    m.xVal = m.xVal + m.xSpeed
    m.yVal = m.yVal + m.ySpeed       
    'scr.DrawRect(m.xVal, m.yVal, 100, 100, &h44ff00ff) 
    scr.DrawObject(m.xVal, m.yVal, m.dvdLogo)
    scr.SwapBuffers()
    
End Sub


function checkForBorderCollision()
  if m.xVal <= 0 OR m.xVal + m.dvdLogo.GetWidth() >=m.W
    m.xSpeed*= -1
  endif
  if m.yVal <= 0 OR m.yVal + m.dvdLogo.GetHeight() >= m.H
    m.ySpeed*= -1
  endif
endfunction



