unit ufrmSuit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Mask, DB, ADODB;

type
  TfrmSuit = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    btnCriar: TButton;
    btnCancelar: TButton;
    txtNome: TDBEdit;
    mmDescricao: TDBMemo;
    procedure btnCriarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    fbInserindo: boolean;
    { Public declarations }
  end;

var
  frmSuit: TfrmSuit;
  pbFechar: boolean;

implementation

uses
  ufrmAutomatizador;

{$R *.DFM}

procedure TfrmSuit.btnCriarClick(Sender: TObject);
begin
  if txtNome.Text = '' then
  begin
    ShowMessage('Campo Nome é obrigatório');
    exit;
  end;

  pbFechar := True;

  modalresult := mrOk;
end;

procedure TfrmSuit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not pbFechar then
    modalResult := mrCancel;
end;

end.

