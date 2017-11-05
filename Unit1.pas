unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB,
  Data.Win.ADODB,
  unit2;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    Adapter: TInterfaceAdapter;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Adapter := TAdapter.Create;
  Adapter.connect;
  Label1.Caption := Adapter.GetDataSource
    ('SELECT name FROM market.info;', 'name');
  self.Caption := Adapter.GetDataSource('SELECT caption FROM market.info;',
    'caption');
end;

end.
