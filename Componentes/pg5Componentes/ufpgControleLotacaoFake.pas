unit ufpgControleLotacaoFake;

interface

uses
  ufpgControleLotacao;

type
  TfpgControleLotacaoFake = class(TfpgControleLotacao)
  private
    FfpgAutorizarBase: boolean;

  protected
    procedure AlternarLotacaoPorEscolha(poData: olevariant); override;
    procedure ConfigurarConexaoDeAcordoComAlias(psNmAlias: string); override;
    function VerificarLotacaoAutorizadaBase(poData: olevariant): boolean; override;
    procedure AlternarLotacaoInterno(const pnNuSeqLotacao: integer); override;
    function PegarLotacoesUsuario(psSpUsuario: string): olevariant; override;
    function FecharFormsAbertos(pbExecutaCloseQuery: boolean): boolean; override;
    function TestarSeUsuarioLotacaoTemAlgumaFuncaoAutorizada(const psSpUsuario: string;
      const pnNuSeqLotacao: integer): boolean; override;
  public
    FbUsuarioPossuiFuncaoAutorizada: boolean;
    property fpgAutorizarBase: boolean read FfpgAutorizarBase write FfpgAutorizarBase;
  end;

implementation

uses
  DBClient, DB, SysUtils;

{ TfpgControleLotacaoFake }

procedure TfpgControleLotacaoFake.AlternarLotacaoInterno(const pnNuSeqLotacao: integer);
begin
  Exit;
end;

procedure TfpgControleLotacaoFake.AlternarLotacaoPorEscolha(poData: olevariant);
begin
  Exit;
end;

procedure TfpgControleLotacaoFake.ConfigurarConexaoDeAcordoComAlias(psNmAlias: string);
begin
  Exit;
end;

function TfpgControleLotacaoFake.FecharFormsAbertos(pbExecutaCloseQuery: boolean): boolean;
begin
  result := True;
end;

function TfpgControleLotacaoFake.PegarLotacoesUsuario(psSpUsuario: string): olevariant;
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

function TfpgControleLotacaoFake.TestarSeUsuarioLotacaoTemAlgumaFuncaoAutorizada(
  const psSpUsuario: string; const pnNuSeqLotacao: integer): boolean;
begin
  result := FbUsuarioPossuiFuncaoAutorizada;
end;

function TfpgControleLotacaoFake.VerificarLotacaoAutorizadaBase(poData: olevariant): boolean;
begin
  result := FfpgAutorizarBase;
end;

end.

