unit Live;

interface
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     StdCtrls, ExtCtrls, Menus, QCCom32;

procedure Live_update;
procedure panel_update;
procedure Live_Abruf;
procedure Bankschalter;
Procedure RNDADJ;

implementation
uses Lasersoftware,image,ausgabe,shortcuts;

procedure Live_update;
var ini,hauptverzeichnis:string;
begin
  getdir(0,hauptverzeichnis);
  ini:=hauptverzeichnis+'\Live.ldt';

  if fileexists(ini) then
    begin
      form1.memo3.lines.loadfromfile(ini);
      panel_update;
      Faderupdate;
    end;


end;

// Geladene Tastaturbelegung anzeigen
procedure panel_update;
begin
      form1.panel17.caption:=ExtractFileName(form1.memo3.lines[1]);
      form1.panel18.caption:=ExtractFileName(form1.memo3.lines[2]);
      form1.panel19.caption:=ExtractFileName(form1.memo3.lines[3]);
      form1.panel20.caption:=ExtractFileName(form1.memo3.lines[4]);
      form1.panel21.caption:=ExtractFileName(form1.memo3.lines[5]);
      form1.panel22.caption:=ExtractFileName(form1.memo3.lines[6]);
      form1.panel23.caption:=ExtractFileName(form1.memo3.lines[7]);
      form1.panel24.caption:=ExtractFileName(form1.memo3.lines[8]);
      form1.panel25.caption:=ExtractFileName(form1.memo3.lines[9]);
      form1.panel26.caption:=ExtractFileName(form1.memo3.lines[10]);
      form1.panel35.caption:=ExtractFileName(form1.memo3.lines[11]);
      form1.panel36.caption:=ExtractFileName(form1.memo3.lines[12]);
      form1.panel37.caption:=ExtractFileName(form1.memo3.lines[13]);
      form1.panel38.caption:=ExtractFileName(form1.memo3.lines[14]);
      form1.panel39.caption:=ExtractFileName(form1.memo3.lines[15]);
      form1.panel40.caption:=ExtractFileName(form1.memo3.lines[16]);
      form1.panel41.caption:=ExtractFileName(form1.memo3.lines[17]);
      form1.panel42.caption:=ExtractFileName(form1.memo3.lines[18]);
      form1.panel43.caption:=ExtractFileName(form1.memo3.lines[19]);
      form1.panel44.caption:=ExtractFileName(form1.memo3.lines[20]);
      form1.panel45.caption:=ExtractFileName(form1.memo3.lines[21]);
      form1.panel46.caption:=ExtractFileName(form1.memo3.lines[22]);
      form1.panel47.caption:=ExtractFileName(form1.memo3.lines[23]);
      form1.panel48.caption:=ExtractFileName(form1.memo3.lines[24]);
      form1.panel49.caption:=ExtractFileName(form1.memo3.lines[25]);
      form1.panel50.caption:=ExtractFileName(form1.memo3.lines[26]);

end;

// Taste wurde gedr�ckt
Procedure Live_Abruf;
var filename:string;a,sk:integer;
begin
// Bankschalter ?? (Taste 1-8 )
if (taste<=56) and (Taste>=48) then Bankschalter;
if (taste=114) or (taste=33) or (Taste=34) then RNDADJ;

// Je nach Taste in Routine unter "Shortcuts" Springen
if taste=13 then start;
if taste=27 then stop;
if taste=113 then motfilespeichern;
if taste=116 then form1.button10.click; //Play
if taste=117 then form1.button15.click; // Cue -50
if taste=118 then form1.button14.click; // Cue +50
if taste=119 then form1.button16.click; // JMP Cue


// Taste irgendeine der LIVE Abruf Tasten ?
IF (Taste>=65) and (Taste<=90) then
 begin
if status=1 then
  begin
   form1.pg2.setfocus;
   Application.ProcessMessages;
   form1.button2.click; a:=1;
   Application.ProcessMessages;
  end;
  repeat sleep(10) until status=0;

  if taste=81 then filename:=form1.memo3.lines[1];
  if taste=87 then filename:=form1.memo3.lines[2];
  if taste=69 then filename:=form1.memo3.lines[3];
  if taste=82 then filename:=form1.memo3.lines[4];
  if taste=84 then filename:=form1.memo3.lines[5];
  if taste=90 then filename:=form1.memo3.lines[6];
  if taste=85 then filename:=form1.memo3.lines[7];
  if taste=73 then filename:=form1.memo3.lines[8];
  if taste=79 then filename:=form1.memo3.lines[9];
  if taste=80 then filename:=form1.memo3.lines[10];
  if taste=65 then filename:=form1.memo3.lines[11];
  if taste=83 then filename:=form1.memo3.lines[12];
  if taste=68 then filename:=form1.memo3.lines[13];
  if taste=70 then filename:=form1.memo3.lines[14];
  if taste=71 then filename:=form1.memo3.lines[15];
  if taste=72 then filename:=form1.memo3.lines[16];
  if taste=74 then filename:=form1.memo3.lines[17];
  if taste=75 then filename:=form1.memo3.lines[18];
  if taste=76 then filename:=form1.memo3.lines[19];
  if taste=89 then filename:=form1.memo3.lines[20];
  if taste=88 then filename:=form1.memo3.lines[21];
  if taste=67 then filename:=form1.memo3.lines[22];
  if taste=86 then filename:=form1.memo3.lines[23];
  if taste=66 then filename:=form1.memo3.lines[24];
  if taste=78 then filename:=form1.memo3.lines[25];
  if taste=77 then filename:=form1.memo3.lines[26];

  // File von Liveaufruf laden Wenn File da Namen da
  if fileexists(filename) then
   begin
     winkel:=180;winkhor:=180;winkver:=180;
     winkel1:=180;winkhor1:=180;winkver1:=180;
     form1.lb1.items.loadfromfile(filename);form1.lb1.refresh;
     form1.sb1.position:=1;punkte:=0;neuzeichnen; image_loeschen; redraw;
     faderupdate;form1.sb4.position:=strtoint(form1.lb1.items[5]);
       if a=1 then
          begin
           form1.button1.click; Application.ProcessMessages;
           a:=0; Application.ProcessMessages;
          end;
   end;
   // Ende File laden
end; // Ende Live Abruf

end;


// Manueller Abruf der Bankschalter
procedure Bankschalter;
begin
 if taste=49 then form1.bs1.checked:=true;if taste=50 then form1.bs2.checked:=true;
 if taste=51 then form1.bs3.checked:=true;if taste=52 then form1.bs4.checked:=true;
 if taste=53 then form1.bs5.checked:=true;if taste=54 then form1.bs6.checked:=true;
 if taste=55 then form1.bs7.checked:=true;if taste=56 then form1.bs8.checked:=true;
 if taste=48 then form1.bs9.checked:=true;
end;

// Random Adjust �ber Tastatur
Procedure RNDADJ;
begin
if Taste=114 then
  begin
   if form1.cb13.checked=false then form1.cb13.checked:=true else
      form1.cb13.checked:=false;
  end;
if taste=33 then form1.sb14.position:=form1.sb14.position+1;
if taste=34 then form1.sb14.position:=form1.sb14.position-1;


end;



end.