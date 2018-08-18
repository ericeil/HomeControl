sub init()
  m.top.backgroundURI = "pkg:/images/Fireplace_1920x1080_black.jpg"
  
  m.example = m.top.findNode("exampleLabelList")

  'm.example.font = "font:MediumSystemFont"
  'm.example.focusedFont = "font:MediumSystemFont"
  m.example.focusedFont.size = m.example.font.size+20
  'm.example.translation = [ 675, 400 ]

  m.example.observeField("itemSelected", "onItemSelected")

  m.top.setFocus(true)
end sub

sub onItemSelected()
    print "item selected"
    itemSelected = m.example.itemSelected
    print itemSelected
    print m.example.content.getChild(itemSelected).id
    
    selectedEvent = m.example.content.getChild(itemSelected).id
    
    key = GetKey()
    requestUrl = "https://maker.ifttt.com/trigger/"+ selectedEvent + "/with/key/" + key
    print requestUrl
    
    task = CreateObject("roSGNode", "triggerTask")
    task.triggerUrl = requestUrl
    task.control = "RUN"
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then
        if key = "options" then
            showKeyEntryDialog()
            return true
        end if
    endif
    return false
end function

sub showKeyEntryDialog()
    print "Showing key entry dialog"
    d = CreateObject("roSGNode", "KeyboardDialog")
    d.title = "IFTTT WebHooks Key"
    d.text = GetKey()
    d.buttons = ["OK", "Cancel"]
    d.observeField("buttonSelected", "onKeyboardButtonSelected")
    m.top.dialog = d
end sub

function GetKey() as String
    registry = CreateObject("roRegistrySection", "HomeControl")
    if registry.Exists("IFTTTKey") then
        return registry.Read("IFTTTKey")
    else
        return ""
    endif
end function

sub SetKey(key as String)
    registry = CreateObject("roRegistrySection", "HomeControl")
    registry.Write("IFTTTKey",key)
    registry.Flush()
end sub

sub onKeyboardButtonSelected()
    print "button selected " m.top.dialog.buttonSelected 
    if m.top.dialog.buttonSelected = 0 then
        SetKey(m.top.dialog.text)
    end if
    m.top.dialog.close = true
end sub