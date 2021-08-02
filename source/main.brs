'Update: copyright 2021 Running Stream LLC.  All Rights Reserved.
'Original file: copyright 2016 Roku Corp.  All Rights Reserved.

sub Main()
  showChannelSGScreen()
end sub

sub showChannelSGScreen()
  screen = CreateObject("roSGScreen")
  roinput = CreateObject("roInput")
  m.port = CreateObject("roMessagePort")
  screen.setMessagePort(m.port)
  roinput.setMessagePort(m.port)
  scene = screen.CreateScene("MainScene")
  screen.show()

  scene.observeField("closescreen", m.port)

  while(true)

    msg = wait(0, m.port)
    msgType = type(msg)

    if msgType = "roSGScreenEvent"
      if msg.isScreenClosed() then
          return
      end if
    else if msgType = "roSGNodeEvent"
      field = msg.getField()
      if field = "closescreen" then
        return
      end if
    else if msgType = "roInputEvent"
      if msg.isInput()
        info = msg.getInfo()
        print "Received input: "; FormatJSON(info)
      end if
    end if

  end while

end sub
