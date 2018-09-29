unit online;

interface
uses windows,mysql,sysutils;

type int=integer;



implementation

var
    conn : PMYSQL;
    Time_out:integer;


function inttochar(val:int):pchar;
begin
  result:=stralloc(255)  ;
  strcopy(result,Pchar(inttostr(val)));
end;


// initialise la connexion au serveur
function start_conn():integer;
const
   host='localhost';
   user='root';
   password='';
   database='gssv2008';
begin
    Conn := mysql_init(nil);
    Time_out:=10;
   Mysql_options(conn,Mysql_Opt_Connect_Timeout, Pchar(inttostr(Time_out)))  ;
      // showmessage(mysql_error(mySQLConnection));
    if mysql_real_connect(conn, host, user, password,database,0, nil, 0) <> nil then
     begin
        // Connection réussie   showmessage('hjhjh');
        messagebox(0,'Connection failed','Error',0);
    end;
end;

// envoie une commande à un joueur externe via le net
function send_cmd(pseudoID,destID:int;cmd,arg1,arg2:string):integer;
var
  sql:string;
  str:string;
  myRES : PMYSQL_RES;
  myROW : PMYSQL_ROW;
  r:integer;
begin
  str:='`'+inttostr(pseudoID)+ '`,`'+inttostr(destID)+'`,`'+cmd+'`,`'+arg1+'`,`'+arg2+'`';
  sql:='INSERT INTO  cmd_board (`pseudoID`,`destID`,`cmd`,`arg1`,`arg2`) VALUES('+str+')';
  r:=mysql_real_query(conn,pchar(sql), length(sql));
  if (not(r=0)) then
  begin
  messagebox(0,mysql_error(conn),'Error',0);
  end;

end;

end.
