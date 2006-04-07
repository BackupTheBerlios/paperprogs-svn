%brdraw, draw shitty looking bohr-rutherford diagrams
import GUI
var winID1 : int
var picID : int
winID1 := Window.Open ("graphics:640;480;nobuttonbar;position:top;right")
View.Set ("graphics")
const midx := maxx div 2
const midy := maxy div 2
put "Crappy Bohr-Rutherford Drawer 2006 Pro :D"
delay (1000)
cls
put "How many neutrons?"
var neutronnum : string
var protonnum : string
var electronnum : int
get neutronnum
put "Protons?"
get protonnum
var protonnum2 : string
protonnum2 := protonnum + 'p'
var neutronnum2 : string
neutronnum2 := neutronnum + 'n'
put "Electrons?"
get electronnum
cls
% all variables are defined. To an extent :-)

var center : int := GUI.CreateLabelFull (0, +7, protonnum2, maxx, maxy,
    GUI.MIDDLE + GUI.CENTER, 0)
var center2 : int := GUI.CreateLabelFull (0, -7, neutronnum2, maxx, maxy,
    GUI.MIDDLE + GUI.CENTER, 0)

%commented out annoying label
%var center2 : int := GUI.CreateLabelFull (0, 180, "Carbon (most common isotope)", maxx, maxy,
%    GUI.MIDDLE + GUI.CENTER, 0)

%midx = 320 :D
%Draw paths for electrons
Draw.Oval (midx, midy, 50, 50, black)
Draw.Oval (midx, midy, 70, 70, black)
%Draw Electrons
for counter : 1 .. electronnum
    if counter = 1 then
	Draw.Oval (midx, midy + 70, 5, 5, black)
    elsif counter = 2 then
	Draw.Oval (midx, midy - 70, 5, 5, black)
    elsif counter = 3 then
	Draw.Oval (midx, midy, 90, 90, black)
	Draw.Oval (midx, midy + 90, 5, 5, black)
    elsif counter = 4 then
	Draw.Oval (midx, midy - 90, 5, 5, black)
    elsif counter = 5 then
	Draw.Oval (midx - 90, midy, 5, 5, black)
    elsif counter = 6 then
	Draw.Oval (midx + 90, midy, 5, 5, black)
    elsif counter = 7 then
	Draw.Oval (midx + 15, midy + 89, 5, 5, black)
    elsif counter = 8 then
	Draw.Oval (midx - 15, midy - 89, 5, 5, black)
    elsif counter = 9 then
	Draw.Oval (midx + 89, midy + 15, 5, 5, black)
    elsif counter = 10 then
	Draw.Oval (midx - 89, midy - 15, 5, 5, black)
    elsif counter = 11 then
	Draw.Oval (midx, midy, 110, 110, black)
	Draw.Oval (midx, midy + 110, 5, 5, black)
    elsif counter = 12 then
	Draw.Oval (midx, midy - 110, 5, 5, black)
    elsif counter = 13 then
	Draw.Oval (midx + 110, midy, 5, 5, black)
    elsif counter = 14 then
	Draw.Oval (midx - 110, midy, 5, 5, black)
    end if
end for

Pic.ScreenSave (50, 50, 150, 150, "BMP:draw.bmp")
