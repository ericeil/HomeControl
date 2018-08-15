sub init()
    m.top.functionName = "executeTask"
end sub

function executeTask() as void
    print m.top.triggerUrl
    
    transfer = CreateObject("roUrlTransfer")
    transfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    transfer.SetUrl(m.top.triggerUrl)
    
    print "GET " + transfer.GetUrl()
    response = transfer.GetToString()
    print "done"
    
    print response
end function
