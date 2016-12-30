unit ufrmBuild;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, ADODB, DBCtrls, Mask;

type
  TfrmBuild = class(TForm)
    btCriar: TButton;
    btCancelar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    txtBuild: TDBEdit;
    txtCliente: TDBEdit;
    mmDescricao: TDBMemo;
    procedure btCriarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    function verificaCamposObrigatorios: boolean;
    { Private declarations }
  public
    FsNomeArquivo: string;
    { Public declarations }
  end;


var
  frmBuild: TfrmBuild;

implementation

uses
  ufrmAutomatizador;

{$R *.DFM}

procedure TfrmBuild.btCriarClick(Sender: TObject);
begin
  if not verificaCamposObrigatorios then
    exit;

  frmPrincipal.qryBuild.Post;
  modalresult := mrOk;
end;

function TfrmBuild.verificaCamposObrigatorios: boolean;
begin
  result := False;
  if trim(txtBuild.text) = '' then
    showMessage('O campo Build é de preenchimento obrigatório')
  else if trim(txtCliente.text) = '' then
    showMessage('O campo Cliente é de preenchimento obrigatório')
  else
    result := True;
end;

procedure TfrmBuild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmPrincipal.qryBuild.Cancel;
end;

procedure TfrmBuild.FormShow(Sender: TObject);
begin
  frmPrincipal.CriarBuild(FsNomeArquivo);
end;

end.
