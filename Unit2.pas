unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB,
  Data.Win.ADODB;

type

  TMyADOConnection = class(TADOConnection)

  end;

  TInterfaceAdapter = interface
    procedure connect;
    function GetDataSource(sql: string; field: string): string;
  end;

  TAdapter = class(TInterfacedObject, TInterfaceAdapter)
  private
    ADOConnection1: TMyADOConnection;
    ADOQuery1: TADOQuery;
  public
    procedure connect;
    function GetDataSource(sql: string; field: string): string;
  end;

implementation

{ TAdapter }

procedure TAdapter.connect;
begin
  if not Assigned(ADOConnection1) then
    ADOConnection1 := TMyADOConnection.Create(nil);
  ADOConnection1.ConnectionString :=
    'Provider=MSDASQL.1;Password=2307;Persist Security Info=True;User ID=root;Extended Properties="DRIVER={MySQL ODBC 5.3 Unicode Driver};UID=root;PWD=2307;SERVER=localhost;DATABASE=market;PORT=3306;COLUMN_SIZE_S32=1;";Initial Catalog=store';
  ADOConnection1.LoginPrompt := false;
  ADOConnection1.Connected := true;
end;

function TAdapter.GetDataSource(sql: string; field: string): string;
begin
  if not Assigned(ADOQuery1) then
    ADOQuery1 := TADOQuery.Create(ADOConnection1);

  ADOQuery1.Connection := ADOConnection1;
  ADOQuery1.Close;
  ADOQuery1.sql.Clear;
  ADOQuery1.sql.Add(sql);
  ADOQuery1.Open;
  ADOQuery1.Active := true;

  result := ADOQuery1.FieldByName(field).Text;
end;

end.
