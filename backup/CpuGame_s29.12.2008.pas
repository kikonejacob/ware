unit CpuGame;

interface
uses sysutils,main,forms,dialogs;

type
  CaseArray=array[1..12] of integer;
function ComputerPlay:integer;
function TestPlay(num,PlayerId:integer;Cases:CaseArray):integer;


implementation

{Teste toutes les cases}
function GetCaseFrom_Tactic3:integer;
var
  i,Inum,aNum:integer;
  P0_p,P1_p:integer; {point obtenu par P0,P1 pour Inum}
  M0_C,M1_C:integer;{point obtenu par P0,P1 pour i}


begin
  M0_C:=0;
  M1_C:=0;
  iNum:=0;
  aNum:=0;
  for i:= gw.Players[0].caseBegin to gw.Players[0].caseEnd  do
  begin
    P0_p:=TestPlay(i,0,CaseArray(gw.cases));
    P1_p:=TestPlay(i,1,CaseArray(gw.cases));

    if (P0_P>=P1_P) and (P0_P>=M0_C) and (P0_P>0) then
    begin
        M0_C:=P0_P;
        M1_C:=P1_P;
        iNum:=i;
    end
    else
    If (P0_P=M0_C) and (P1_P<M1_C) then
    begin
        M0_C:=P0_P;
        M1_C:=P1_P;
        iNum:=i;
    end
    else
    If (P0_P>M0_C) and (P1_P<M1_C) then
    begin
        M0_C:=P0_P;
        M1_C:=P1_P;
        iNum:=i;
    end;
    If (P0_P>M0_C)  then
    begin
    aNum:=i ;
    end;

    //Showmessage(inttostr(TestPlay(i,1,CaseArray(gw.cases)))+'result case'+inttostr(i));

  end;
  If (iNum=0) and (aNum>0) then
  begin
    if (gw.Players[0].points-gw.Players[1].points)<0 then
    begin
    iNum:=aNum;
    end

  end;

  //Showmessage('result'+inttostr(M0_C)+' case'+inttostr(iNum));
  result:=iNum;
end;


{fonction qui permet à l'ordinteur de jouer}
function ComputerPlay:integer;
var
   i,a,iNum,Importance:integer;
   tours,rest,j,j2:integer;


begin
    Importance:=0;
   {Tactic 1: cherche une case au hasard pour jouer}

   randomize;
   
   iNum:=0;
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
   {Tactic 1.2}
   For i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
   begin
   if (gw.Cases[i]>0) and (gw.Cases[i]<>3) then
   begin
     iNum:=i;
     j:=random(2);
     if j=0 then
     begin
     importance:=0;
     //msgbox('tactic1');
     form1.label1.Caption:='tactic1.2';
     break;
     end;
   end;
   end;
  
   {Tactic 1.4}
   if  (gw.Cases[gw.Players[0].caseBegin]=3) and ((gw.Players[0].caseBegin-1)>0) then
   begin
     iNum:=gw.Players[0].caseBegin;
     //msgbox('tactic1');
     form1.label1.Caption:='tactic1.3';
   end;
   {Tactic 1.5}
   j:=0;j2:=0;
   For i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
   begin
     if (gw.Cases[i]=2) or (gw.Cases[i]=3) then
     inc(j);
     if (j2<gw.Cases[i]) then
     j2:=gw.Cases[i];
     if importance>j then
     begin
     importance:=0;
     //msgbox('tactic1');
     form1.label1.Caption:='tactic1.5';
     end;
   end;
    {Tactic 1.6}
   
   For i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
   begin
     If IsPlayerCase(i-1,0) then
     if (gw.Cases[i]=2) and (gw.Cases[i-1]=2) then
     begin
     iNum:=i-1;
     form1.label1.Caption:='tactic1.6';
     break;
     end;
     If IsPlayerCase(i+1,0) then
     if (gw.Cases[i]=2) and (gw.Cases[i+1]=2) then
     begin
     iNum:=i;
     form1.label1.Caption:='tactic1.6';
     break
     end;
     if IsPlayerCase(i-1,0) and  IsPlayerCase(i-2,0) then
     if (gw.Cases[i-1]=1) and (gw.Cases[i-2]=1) and (gw.Cases[i]=2) then
     begin
     iNum:=i;
     form1.label1.Caption:='tactic1.6';
     break
     end;

     //msgbox('tactic1');


   end;






   {Tactic 2: rechercher si on ne peut pas avoir de 4 magic en jouant une case}
   j2:=0;
   For i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
   begin
     GetCaseInfo(i,@tours,@rest);
     j:=0;
     for a:= i+1 to (i+gw.Cases[i]) do
     begin
       //showmessage(inttostr(a));
       If ((gw.Cases[_cnv(a)]+tours+1)=4)and IsPlayerCase(_cnv(a),0)then
       begin
       inc(j);
       end;
     end;
     if (importance<j)  and (j>0)  and (j>j2) then
     begin
       Importance:=j;
       iNum:=i;
       j2:=j;
       //msgbox('tactic2')
       form1.label1.Caption:='tactic2';
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
       for a:= i+1 to (gw.Cases[i]+i-1) do
       begin
         If ((gw.Cases[_cnv(a)]+tours+1)=3) and IsPlayerCase(_cnv(a),0) then
         begin
         inc(j);
         end;
       end;
       if (importance=0) and (j>100) then
       begin
         iNum:=i;
         Importance:=j;
         ///msgbox('tactic4');
         form1.label1.Caption:='tactic4';
       end;

    end;
   {Tactic 5}
   j:=GetCaseFrom_Tactic3;
   If j>0 then
   begin
   iNum:=j;
   form1.label1.Caption:='tactic5';
   end;


   //msgbox(inttostr(iNum));
   If iNum<>0 then
   begin
   Shortmsg('l''ordi joue la case'+inttostr(iNum),0);
   AffSelInfo(iNum,0);
   Application.ProcessMessages;
   sleep(1000);

   PlayCaseEx(iNum,0,true);
   end
   else
   Shortmsg('l''ordi n''a aucune case à jouer',0);

end;

function TestPlay(num,PlayerId:integer;Cases:CaseArray):integer;
var
  Cases2:CaseArray;
  i,j,j3:integer;
  cend:integer;
begin
  for i:=1 to 12 do
  Cases2[i]:=Cases[i];
  j:=0;
  cend:=num+cases2[num];
  Cases2[num]:=0;
  For i:=num+1 to  cend do
  begin
    Cases2[_cnv(i)]:=Cases2[_cnv(i)]+1;
    If (Cases2[_cnv(i)]=4) then
    begin
    Cases2[_cnv(i)]:=0;
    if IsPlayerCase(_cnv(i),PlayerId) or (i=cend) then
    Inc(j);
    end;
    //showmessage(inttostr(Cases2[_cnv(i)])+ '+++'+inttostr(_cnv(i)));
  end;
  if (Cases2[_cnv(cend)]>1) and (Cases2[_cnv(cend)]<>4)then
  begin
  //showmessage(inttostr(Cases2[_cnv(cend)])+ 'dfdf');
  j:=j+TestPlay(_cnv(cend),PlayerId,Cases2);
  end;
 

  result:=J;
end;


end.
