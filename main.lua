display.setStatusBar(display.HiddenStatusBar)

local widget = require('widget')
local qrscanner = require('plugin.qrscanner')

--[[
qrscanner.show(listner, [options])

Opens the scanner view.

options.strings - key-value table of string-string values for customization/localization.

Example:

qrscanner.show(listener, {strings = {title = 'My Custom Title'}})

All default values:

options.strings = {
    title = 'QR Code Scanner'
    no_permission_err = 'This app does not have permission to use the camera.'
    no_camera_err = 'This device does not have a camera.'
    unknown_error_err = 'An unknown error occurred.'
    error_dialog_title = 'Scanning Unavailable'
    error_dialog_button = 'OK'
}

On Android only title and no_camera_err are used.

]]

local rect = display.newRect(display.contentCenterX, display.contentCenterY, 100, 100)
rect:setFillColor(0.75)

local function listener(message)
    -- message variable contains the value of a scanned QR Code or a barcode.
    native.showAlert('QR Code Scanner', message, {'OK'})
end

local scanButton = widget.newButton {
    x = rect.x, y = rect.y,
    width = 75, height = 50,
    label = 'Scan',
    onRelease = function()
        print('Showing QR')
        qrscanner.show(listener)
    end}
