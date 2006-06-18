/*
 * Copyright (c) 2006 ultramancool <ultramancool@gmail.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
var blobyname : string

get blobyname
 
% backround
setscreen ("nocursor,offscreenonly, graphics:800, 600")
colorback (black)
color (brightgreen)
cls

Pic.ScreenLoad ("mine.bmp", 0, 0, picCopy)
Input.Pause

%intro

var x, y, s, laserx, lasery, shoot, allowshot, gobullet, gobulletr : int
gobullet := 0
gobulletr := 0
lasery := 0
laserx := 0
allowshot := 1
x := 100
y := 100
s := 25
shoot := 0
var chars : array char of boolean

procedure coldethed (xh : int, yh : int)
    if x + s > xh - s and x - s < xh + s and y + s > yh - s and y - s < yh + s then
	if x > xh + s then
	    x := x + 5
	end if
	if y > yh + s then
	    y := y + 5
	end if
	if y < yh + s then
	    y := y - 5
	end if
	if x < xh + s then
	    x := x - 5
	end if
    end if
end coldethed

loop
    Pic.ScreenLoad ("bg.bmp", 0, 0, picCopy)
    Input.KeyDown (chars)

    if chars (KEY_UP_ARROW) then
	y := y + 10
	gobullet := 1
    end if
    if chars (KEY_RIGHT_ARROW) then
	x := x + 10
	gobullet := 2
    end if
    if chars (KEY_LEFT_ARROW) then
	x := x - 10
	gobullet := 3
    end if
    if chars (KEY_DOWN_ARROW) then
	y := y - 10
	gobullet := 4
    end if
    if chars (' ') and allowshot = 1 then
	shoot := 1
	laserx := x
	lasery := y
	gobulletr := gobullet
    end if
    if shoot = 1 then
    if gobulletr = 1 or gobulletr = 4 then
    drawline (laserx + 20, lasery + 30, laserx + 20, lasery + 55, red)
    end if
    if gobulletr = 2 or gobulletr = 3 then
    drawline (laserx + 20, lasery + 20, laserx + 55, lasery + 20, red)
    end if
	%        drawline (laserx + 21, lasery + 30, laserx + 21, lasery + 55, red)
	% drawline (laserx + 19, lasery + 30, laserx + 19, lasery + 55, red)
	allowshot := 0
    end if
    if lasery < 600 then
	if gobulletr = 1 then
	    lasery := lasery + 10
	end if
	if gobulletr = 2 then
	    laserx := laserx + 10
	end if
	if gobulletr = 3 then
	    laserx := laserx - 10
	end if
	if gobulletr = 4 then
	    lasery := lasery - 10
	end if
    else
	allowshot := 1
    end if

    if laserx > 800 or lasery < 0 or laserx < 0 then
	allowshot := 1
    end if
    if y < 0 then
	y := 0
    end if
    if x > 800 - 46 then
	x := 800 - 46
    end if
    if y > 600 - 49 then
	y := 600 - 49
    end if
    if x < 0 then
	x := 0
    end if

    for p : 1 .. 5
	for i : 1 .. 5
	    Pic.ScreenLoad ("hedge.bmp", 130 * p, 50 * i, picMerge)

	    coldethed (130 * p, 50 * i)
	end for
    end for
    Pic.ScreenLoad (blobyname, x, y, picMerge)
    colorback (black)
    View.Update
end loop




