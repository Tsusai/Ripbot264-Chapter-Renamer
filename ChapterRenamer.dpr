(*
2019-2020 "Tsusai": Printer Installer: Uses windows scripts to deploy multiple printers.
Just drag/drop a chapter file onto the program or use as a %1 sorta deal
*)

program ChapterRenamer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
	System.SysUtils,
	System.StrUtils,
  Classes;

var
	AFile : TStringList;
	i, ii : byte;
	tmp : string;
begin
	try
		tmp := '';
		AFile := TStringList.Create;
		writeln('Processing ' + ParamStr(1));
		AFile.LoadFromFile(ParamStr(1));
		ii := 1;
		for i := 0 to AFile.Count - 1 do
		begin
			if i = 0 then
			begin
        //Set any miliseconds to 0
				if ContainsText(AFile.Strings[i],'CHAPTER01=00:00:00.') then
					AFile.Strings[i] := 'CHAPTER01=00:00:00.000';
			end;
			if Odd(i) then
			begin
				tmp := Format('CHAPTER%.2dNAME=Chapter %.2d',[ii,ii]);
				//tmp := 'CHAPTER0' + IntToStr(ii) + 'NAME=Chapter ' + IntToStr(ii);
				Writeln(AFile.Strings[i] + ' => ' +tmp);
				AFile.Strings[i] := tmp;
				inc(ii);
			end;
		end;
		AFile.SaveToFile(ParamStr(1));
		AFile.Free;

		{ TODO -oUser -cConsole Main : Insert code here }
	except
		on E: Exception do
			Writeln(E.ClassName, ': ', E.Message);
  end;
end.
