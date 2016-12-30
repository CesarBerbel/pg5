unit ufrmUsuario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ADODB, Db;

type
  TfrmUsuario = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    txtNome: TDBEdit;
    txtCliente: TDBEdit;
    btnCriar: TButton;
    btnCancelar: TButton;
    btnDeletar: TButton;
    cmDeleta: TADOCommand;
    procedure btnDeletarClick(Sender: TObject);
    procedure qryUsuarioAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnCriarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuario: TfrmUsuario;

implementation

uses
  ufrmManipula;

{$R *.DFM}

procedure TfrmUsuario.btnDeletarClick(Sender: TObject);
begin
  if (txtNome.Text = '') or (txtCliente.Text = '') then
  begin
    showMessage('Favor digitar o nome e o cliente do usuário para ser deletado');
    exit;
  end;

  cmDeleta.Parameters.ParamByName('NOME').Value := txtNome.Text;
  cmDeleta.Parameters.ParamByName('CLIENTE').Value := txtCliente.Text;

  if mrYes = messagedlg('Você tem certeza em excluir o Usuário ' + txtNome.Text + ' do cliente ' + txtCliente.Text + '?', mtConfirmation, mbYesNoCancel, 0) then
  begin
    frmManipulaDados.qryUsuario.close;
    cmDeleta.Execute;
    frmManipulaDados.qryUsuario.open;
    frmManipulaDados.qryUsuario.Append;
  end;
end;

procedure TfrmUsuario.qryUsuarioAfterOpen(DataSet: TDataSet);
begin
  txtNome.Enabled := not frmManipulaDados.qryUsuario.IsEmpty;
end;

procedure TfrmUsuario.FormShow(Sender: TObject);
begin
  if not frmManipulaDados.qryUsuario.Active then
    frmManipulaDados.qryUsuario.Open;

  btnDeletar.Enabled := not frmManipulaDados.qryUsuario.IsEmpty;
  frmManipulaDados.qryUsuario.Append;
end;

procedure TfrmUsuario.btnCriarClick(Sender: TObject);
begin
  if (txtNome.Text = '') or (txtNome.Text = '') then
  begin
    showMessage('Favor digitar o nome e o cliente do usuário para ser deletado');
    exit;
  end
  else
  begin
    try
      frmManipulaDados.qryUsuario.Post;

      ModalResult := mrOK;
    except
      on E: Exception do
        if pos('UNIQUE constraint', e.Message) > 0 then
          ShowMessage('Já existe um Usuário com esse nome para o mesmo Cliente');
    end;
  end;
end;

procedure TfrmUsuario.btnCancelarClick(Sender: TObject);
begin
  modalResult := mrCancel;
end;

end.
