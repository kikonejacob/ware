unit CpuGame;

interface
uses sysutils,main,forms;
function ComputerPlay:integer;


implementation

{fonction qui permet à l'ordinteur de jouer}
function ComputerPlay:integer;
var
   i,a,iNum,Importance:integer;
   tours,rest,j:integer;

begin
    Importance:=0;
   {Tactic 1: cherche une case au hasard pour jouer}

   randomize;
   

   For i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
   if (gw.Cases[i]>0) then
   begin
     iNum:=i;
     j:=random(2);
     if j=0 then
     begin
     importance:=0;
     //msgbox('tactic1');
     form1.label1.Caption:='tactic1';
     break;
     end;
   end;

   {Tactic 2: rechercher si on ne peut pas avoir de 4 magic en jouant une case}
   For i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
   begin
     GetCaseInfo(i,@tours,@rest);
     j:=0;
     for a:= i+1 to (i+gw.Cases[i]) do
     begin
       //showmessage(inttostr(a));

       If ((gw.Cases[_cnv(a)]+tours+1)=4)and(
          (_cnv(a)>=gw.Players[0].caseBegin) and
           (_cnv(a)<=gw.Players[0].caseEnd)) then
       begin
       inc(j);
       iNum:=i;
      
       if importance<j then
       begin
       iNum:=i;
       Importance:=j;
       //msgbox('tactic2')
       form1.label1.Caption:='tactic2';
       end;
       end;
      end;
   end;
   //msgbox('Jacob');
   {Tactic 3: recherche si la case ne tombe sur quatre magic}
   For i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
   begin
     GetCaseInfo(i,@tours,@rest);
     if (gw.Cases[_cnv(i+gw.cases[i])]+tours+1)=4 then
     if importance=0 then
     begin
     Importance:=1;
     inum:=i;
     //msgbox('tactic3');
     form1.label1.Caption:='tactic3';
     break;
     end;
   end;

   {Tactic 4: recherche si one ne peut pas avoir une case de 3 points en jouant une case}
    For i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
    begin
       j:=0;
       for a:= i+1 to (gw.Cases[i]+i) do
       begin

         If ((gw.Cases[_cnv(a)]+tours+1)=3) and (
            (_cnv(a)>=gw.Players[0].caseBegin) and
           (_cnv(a)<=gw.Players[0].caseEnd)) then
         begin
         inc(j);
         if (importance=0) and (j>=1) then
         begin
         iNum:=i;
         Importance:=j;
         ///msgbox('tactic4');
         form1.label1.Caption:='tactic4';
         end;
         end;

       end;
    end;

   //msgbox(inttostr(iNum));
   Shortmsg('l''ordi joue la case'+inttostr(iNum),0);
   AffSelInfo(iNum,0);
   Application.ProcessMessages;
   sleep(1000);

   PlayCaseEx(iNum,0,true);
   

end;


end.
