display.setStatusBar(display.HiddenStatusBar)

local widget = require('widget')
local qrscanner = require('plugin.qrscanner')

--[[
qrscanner.show(listner, [options])

Opens the scanner view.

options.symbols - array of strings, a list of all types of visual codes to search. Default is 'qr'.
options.strings - key-value table of string-string values for customization/localization.
options.overlays - key-value table of key-value tables that define custom image overlays.

Example:

qrscanner.show(listener, {strings = {title = 'My Custom Title'}})

Symbols possible values:
Android:
'code39', 'code93', 'code128', 'codabar', 'databar', 'databar_exp', 'ean8', 'ean13',
'i25', 'isbn10', 'isbn13', 'partial', 'pdf417', 'qr', 'upca', 'upce'
iOS:
'aztec', 'code39', 'code39mod43', 'code93', 'code128', 'datamatrix', 'ean8', 'ean13',
'interleaved2of5', 'itf14', 'pdf417', 'qr', 'upce'

'interleaved2of5', 'itf14' and 'datamatrix' require iOS 8.0+.

All default values for strings:

options.strings = {
    title = 'QR Code Scanner'
    no_permission_err = 'This app does not have permission to use the camera.'
    no_camera_err = 'This device does not have a camera.'
    unknown_error_err = 'An unknown error occurred.'
    error_dialog_title = 'Scanning Unavailable'
    error_dialog_button = 'OK'
}

On Android only title and no_camera_err are used.

Format for custom overlays:

options.overlays = {
    searching = {
        filename = 'images/searching.png',
        baseDir = system.ResourceDirectory
    },
    found = {
        filename = 'images/found.png',
        baseDir = system.DocumentsDirectory
    }
}

options.overlays.searching is shown when the scanner has opened.
options.overlays.found is shown for a short period of time when a scan result is ready.

baseDir is optional, default is system.ResourceDirectory.

]]

local rect = display.newRect(display.contentCenterX, display.contentCenterY, 200, 200)
rect:setFillColor(0.75)

local function listener(message)
    -- message variable contains the value of a scanned QR Code or a barcode.
    print('Scanned message:', message)
    native.showAlert('QR Code Scanner', message, {'OK'})
end

widget.newButton {
    x = rect.x, y = rect.y - 40,
    width = 150, height = 50,
    label = 'Scan QR',
    onRelease = function()
        print('Showing scanner')
        qrscanner.show(listener)
    end}

widget.newButton {
    x = rect.x, y = rect.y + 40,
    width = 150, height = 50,
    label = 'Scan Bar',
    onRelease = function()
        print('Showing scanner')
        qrscanner.show(listener, {
            symbols = {
                'aztec', 'code39', 'code39mod43', 'code93', 'code128', 'codabar',
                'databar', 'databar_exp', 'datamatrix', 'ean8', 'ean13', 'interleaved2of5',
                'itf14', 'i25', 'isbn10', 'isbn13', 'partial', 'pdf417', 'upca', 'upce'
            },
            strings = {
                title = 'Barcode Scanner'
            },
            overlays = {
                searching = {
                    filename = 'images/searching.png'
                },
                found = {
                    filename = 'images/found.png'
                }
            }
        })
    end}
