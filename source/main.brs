' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 

Sub Main()

    'Create Remote object to then send a remote button click in the sendButtonCLick() method
    'This will ensure that a screensaver will not be displayed after inactive time on roku device
    ipaddrs = CreateObject("roDeviceInfo").GetIPAddrs()
    if ipaddrs.eth0 <> invalid then
        ipaddr = ipaddrs.eth0
    end if
    if ipaddrs.eth1 <> invalid then
        ipaddr = ipaddrs.eth1
    end if
    m.xfer = CreateObject("roURLTransfer")
    url = "http://"+ipaddr+":8060/keypress/Backspace"
    m.xfer.SetUrl(url)




    m.W = 1280
    m.H = 720
    screen=CreateObject("roScreen", true, m.W, m.H)
    if type(screen) <> "roScreen"
        print "Unable to open screen"
        return
    endif
    msgport = CreateObject("roMessagePort")
    m.dvdLogo = CreateObject("roBitMap", "pkg:/images/dvdLogo.jpg")
    m.xVal = RND(1280-m.dvdLogo.GetWidth()) 'Calculate random start x value
    m.yVal = RND(720-m.dvdLogo.GetHeight()) 'Calculate random start y value
    m.xSpeed = 1
    m.ySpeed = 1
    background=&h000000ff
    screen.SetPort(msgport)
    screen.Clear(background)   
    screen.SetAlphaEnable(true)
    DrawImg(screen)
End Sub

'Loop 
Sub DrawImg(scr as object)
    port = scr.GetPort()
    while true    
        msg = wait(11, port)
        if type(msg) = "roUniversalControlEvent" then
                'print "button pressed: " msg.GetInt()           
        end if
        checkForBorderCollision()
        DrawNewRectangle(scr)
    end while
end sub


Sub DrawNewRectangle(scr as Object)
    m.xVal = m.xVal + m.xSpeed
    m.yVal = m.yVal + m.ySpeed 
    scr.DrawObject(m.xVal, m.yVal, m.dvdLogo)
    scr.SwapBuffers()    
End Sub


function checkForBorderCollision()
  if m.xVal <= 0 OR m.xVal + m.dvdLogo.GetWidth() >=m.W
    m.xSpeed*= -1
    sendButtonClick()
  endif
  if m.yVal <= 0 OR m.yVal + m.dvdLogo.GetHeight() >= m.H
    m.ySpeed*= -1
    sendButtonClick()
  endif
endfunction


function sendButtonClick()
    m.xfer.PostFromString("")
endfunction



