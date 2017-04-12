display.setStatusBar(display.HiddenStatusBar)

local widget = require('widget')
local qrscanner = require('plugin.qrscanner')

local rect = display.newRect(display.contentCenterX, display.contentCenterY, 200, 300)
rect:setFillColor(0.75)

local function listener(event)
	if not event.isError then
		-- event.message contains the value of a scanned QR Code or a barcode.
		print('Scanned message:', event.message)
		native.showAlert('QR Code Scanner', event.message, {'OK'})
	else
		print('Error occured:', event.errorCode, event.errorMessage)
		native.showAlert('Error: ' .. event.errorCode, event.errorMessage, {'OK'})
	end
end

widget.newButton {
	x = rect.x, y = rect.y - 60,
	width = 150, height = 50,
	label = 'Scan QR',
	onRelease = function()
		print('Showing scanner')
		qrscanner.show{listener = listener}
	end}

widget.newButton {
	x = rect.x, y = rect.y,
	width = 150, height = 50,
	label = 'Scan Barcode',
	onRelease = function()
		print('Showing scanner')
		qrscanner.show{
			topbar = {
				text = 'Barcode Scanner',
			},
			--[[symbols = {
				'aztec', 'code39', 'code39mod43', 'code93', 'code128', 'codabar',
				'databar', 'databar_exp', 'datamatrix', 'ean8', 'ean13', 'interleaved2of5',
				'itf14', 'i25', 'isbn10', 'isbn13', 'partial', 'pdf417', 'upca', 'upce'
			},]]
			symbols = {'ean8', 'ean13'}, -- Most common barcodes.
			overlays = {
				searching = {
					filename = 'images/searching.png',
					baseDir = system.ResourceDirectory
				},
				found = {
					filename = 'images/found.png',
					baseDir = system.ResourceDirectory
				}
			},
			listener = listener
		}
	end}

widget.newButton {
	x = rect.x, y = rect.y + 60,
	width = 150, height = 50,
	label = 'Scan customized',
	onRelease = function()
		print('Showing scanner')
		qrscanner.show{
			topbar = {
				text = 'Super long barcode scanner topbar title text!!!!',
				fontSize = 0.5,
				color = {0.5, 0.8, 0},
				backgroundColor = {0.2, 0.2, 0.8},
			},
			--useFrontCamera = true,
			filter = '^https?://.*', -- Match an URL
			mask = {
				x = 0.2, y = 0.25,
				width = 0.6, height = 0.25,
				color = {1, 0, 1, 0.25}
			},
			overlays = {
				searching = {
					filename = 'images/searching.png'
				},
				mismatch = {
					filename = 'images/mismatch.png'
				},
				found = {
					filename = 'images/found.png'
				}
			},
			listener = listener
		}
	end}
