unit ufpgUsuarioValidacaoCPFFake;

interface

uses
  ufpgUsuarioValidacaoCPF, Windows, Forms, SysUtils, DB, DBClient, uspClientDataSet;

type
  TfpgUsuarioValidacaoCPFFake = class(TfpgUsuarioValidacaoCPF)
  private
    FcdsDadosUsuario: TspClientDataSet;
    FsRespostaMensagem: string;
  protected
    function PegarDadosUsuario(const psCdUsuario, psNuCPF: string): olevariant; override;

    procedure ExibirMensagemUsuario(const pnCodErro: integer; const psMsgErro: string); override;

    function PegarRespostaMensagem: string; override;
  public
    destructor Destroy; override;

    property fpgDadosUsuario: TspClientDataSet read FcdsDadosUsuario write FcdsDadosUsuario;
    property fpgRespostaMensagem: string read FsRespostaMensagem write FsRespostaMensagem;
  end;

implementation

uses
  usajConstante, uspExcecao, uspMensagem, ufpgMensagem;

{ TfpgUsuarioValidacaoCPFFake }

destructor TfpgUsuarioValidacaoCPFFake.Destroy;
begin
  FreeAndNil(FcdsDadosUsuario); //PC_OK

  inherited;
end;

procedure TfpgUsuarioValidacaoCPFFake.ExibirMensagemUsuario(const pnCodErro: integer;
  const psMsgErro: string);
begin
  Exit;
end;

function TfpgUsuarioValidacaoCPFFake.PegarDadosUsuario(
  const psCdUsuario, psNuCPF: string): olevariant;
begin
  FcdsDadosUsuario.filtered := False;
  FcdsDadosUsuario.filter := 'CDUSUARIO <> ' + QuotedStr(psCdUsuario) + ' AND NUCPF = ' +
    QuotedStr(psNuCPF);
  FcdsDadosUsuario.filtered := True;

  result := FcdsDadosUsuario.spDadosFiltrados;
end;

function TfpgUsuarioValidacaoCPFFake.PegarRespostaMensagem: string;
begin
  result := FsRespostaMensagem;
end;

end.

