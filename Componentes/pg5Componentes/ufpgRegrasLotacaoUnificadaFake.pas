unit ufpgRegrasLotacaoUnificadaFake;

interface

uses
  ufpgRegrasLotacaoUnificada, Forms;

type
  TfpgRegrasLotacaoUnificadaFake = class(TfpgRegrasLotacaoUnificada)
  private
    FfpgAutorizarBase: boolean;
    FnNuSeqLotacao: integer;
  protected
    procedure AlternarLotacaoPorEscolha(poData: olevariant); override;
    procedure ConfigurarConexaoDeAcordoComAlias(psNmAlias: string); override;
    function VerificarLotacaoAutorizadaBase(poData: olevariant): boolean; override;
    procedure AlternarLotacaoInterno(const pnNuSeqLotacao: integer); override;
    function PegarLotacoesUsuario(psSpUsuario: string): olevariant; override;
    function FecharFormsAbertos(pbExecutaCloseQuery: boolean): boolean; override;
    function TestarSeFormEhFundoMenu(poForm: TForm): boolean; override;
    function TestarSeUsuarioLotacaoTemAlgumaFuncaoAutorizada(const psSpUsuario: string;
      const pnNuSeqLotacao: integer): boolean; override;
    function PegarNomeFormFluxo: string; override;
  public
    FbUsuarioPossuiFuncaoAutorizada: boolean;
    FoFundoMenu: TForm;
    property fpgAutorizarBase: boolean read FfpgAutorizarBase write FfpgAutorizarBase;
    property fpgNuSeqLotacao: integer read FnNuSeqLotacao write FnNuSeqLotacao;
  end;

implementation

uses
  DBClient, DB, SysUtils;


{ TfpgRegrasLotacaoUnificadaFake }

procedure TfpgRegrasLotacaoUnificadaFake.AlternarLotacaoInterno(const pnNuSeqLotacao: integer);
begin
  FnNuSeqLotacao := pnNuSeqLotacao;
  Exit;
end;

procedure TfpgRegrasLotacaoUnificadaFake.AlternarLotacaoPorEscolha(poData: olevariant);
begin
  Exit;
end;

procedure TfpgRegrasLotacaoUnificadaFake.ConfigurarConexaoDeAcordoComAlias(psNmAlias: string);
begin
  Exit;
end;

function TfpgRegrasLotacaoUnificadaFake.FecharFormsAbertos(pbExecutaCloseQuery: boolean): boolean;
begin
  result := True;
end;

function TfpgRegrasLotacaoUnificadaFake.PegarLotacoesUsuario(psSpUsuario: string): olevariant;
var
  cdsDados: TClientDataSet;
begin
  cdsDados := TClientDataSet.Create(nil);
  try
    cdsDados.FieldDefs.Add('CDFORO', ftInteger);
    cdsDados.FieldDefs.Add('NUSEQLOTACAO', ftInteger);
    cdsDados.FieldDefs.Add('CC_NMALIAS', ftString, 18);
    cdsDados.CreateDataSet;

    if (psSpUsuario = 'USUARIO1') then
    begin
      cdsDados.Append;
      cdsDados.FieldByName('CDFORO').AsInteger := 23;
      cdsDados.FieldByName('NUSEQLOTACAO').AsInteger := 1;
      cdsDados.FieldByName('CC_NMALIAS').AsString := 'PG5ISC';
      cdsDados.Post;
    end
    else
    if (psSpUsuario = 'USUARIO2') then
    begin

      cdsDados.Append;
      cdsDados.FieldByName('CDFORO').AsInteger := 23;
      cdsDados.FieldByName('NUSEQLOTACAO').AsInteger := 1;
      cdsDados.FieldByName('CC_NMALIAS').AsString := 'PG5ISC';
      cdsDados.Post;

      cdsDados.Append;
      cdsDados.FieldByName('CDFORO').AsInteger := 113;
      cdsDados.FieldByName('NUSEQLOTACAO').AsInteger := 2;
      cdsDados.FieldByName('CC_NMALIAS').AsString := 'PG5ISC';
      cdsDados.Post;

    end
    else
    if (psSpUsuario = 'USUARIO3') then
    begin

      cdsDados.Append;
      cdsDados.FieldByName('CDFORO').AsInteger := 23;
      cdsDados.FieldByName('NUSEQLOTACAO').AsInteger := 1;
      cdsDados.FieldByName('CC_NMALIAS').AsString := 'PG5ISC';
      cdsDados.Post;

      cdsDados.Append;
      cdsDados.FieldByName('CDFORO').AsInteger := 113;
      cdsDados.FieldByName('NUSEQLOTACAO').AsInteger := 2;
      cdsDados.FieldByName('CC_NMALIAS').AsString := 'PG5ISC';
      cdsDados.Post;

      cdsDados.Append;
      cdsDados.FieldByName('CDFORO').AsInteger := 666;
      cdsDados.FieldByName('NUSEQLOTACAO').AsInteger := 3;
      cdsDados.FieldByName('CC_NMALIAS').AsString := 'PG5ISC';
      cdsDados.Post;

    end;

    result := cdsDados.Data;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TfpgRegrasLotacaoUnificadaFake.TestarSeUsuarioLotacaoTemAlgumaFuncaoAutorizada(
  const psSpUsuario: string; const pnNuSeqLotacao: integer): boolean;
begin
  result := FbUsuarioPossuiFuncaoAutorizada;
end;

function TfpgRegrasLotacaoUnificadaFake.VerificarLotacaoAutorizadaBase(poData: olevariant): boolean;
begin
  result := FfpgAutorizarBase;
end;

function TfpgRegrasLotacaoUnificadaFake.TestarSeFormEhFundoMenu(poForm: TForm): boolean;
begin
  result := poForm = FoFundoMenu;
end;

function TfpgRegrasLotacaoUnificadaFake.PegarNomeFormFluxo: string;
begin
  result := 'ffpgVisualizaFluxoTrabalho';
end;

end.
