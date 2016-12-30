unit ufpgValidadorLocalizacaoFisicaProcessoApensoTests;

interface

uses
  ufpgValidadorLocalizacaoFisicaProcessoApenso, TestFrameWork, uspMensagem,
  uspClientDataSet, SysUtils, Classes, DB, usajConstante;

type
  TfpgValidadorLocalizacaoFisicaProcessoApensoFake = class(
    TfpgValidadorLocalizacaoFisicaProcessoApenso)
  protected
    function MostraMensagemInterno(poObjetoDetalhe: TspObjetoDetalhe): boolean; override;

    function TestarSeLocalFisicoDiferenteDoProcesso(psCdProcesso: string;
      pnCdLocalFisico: integer): boolean; override;

    function PegarProcessoApensos(psCdProcesso: string): olevariant; override;
  end;

type
  TfpgValidadorLocalizacaoFisicaProcessoApensoTests = class(TTestCase)
  private
    FoValidadorLocalizacaoFisicaProcessoApenso: TfpgValidadorLocalizacaoFisicaProcessoApenso;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestTestarProcessoPossuiApensoSemLocalFisico;
    procedure TestTestarProcessoPossuiApensoMesmoLocalFisico;
    procedure TestTestarProcessoPossuiApensoLocalFisicoDiferente;
    procedure TestTestarProcessoPossuiApensoComApenso;
    procedure TestTestarProcessoPossuiApensoSemApenso;

  end;

const
  sCODIGO_PROCESSO_COM_APENSO = '123456789';
  sCODIGO_PROCESSO_SEM_APENSO = '987654321';
  nCODIGO_LOCAL_FISICO_1 = 1;
  nCODIGO_LOCAL_FISICO_2 = 2;


implementation

{ TfpgValidadorLocalizacaoFisicaProcessoApensoFake }

function TfpgValidadorLocalizacaoFisicaProcessoApensoFake.MostraMensagemInterno(
  poObjetoDetalhe: TspObjetoDetalhe): boolean;
var
  cdsDadosApenso: TspClientDataSet;
begin
  cdsDadosApenso := TspClientDataSet.Create(nil);
  try
    cdsDadosApenso := poObjetoDetalhe.spCdsDadosExibicao;
    result := not cdsDadosApenso.IsEmpty;
  finally
    FreeAndNil(cdsDadosApenso);
  end;
end;

function TfpgValidadorLocalizacaoFisicaProcessoApensoFake.PegarProcessoApensos(
  psCdProcesso: string): olevariant;
var
  cdsDados: TspClientDataSet;
begin
  cdsDados := TspClientDataSet.Create(nil); //PC_OK
  cdsDados.FieldDefs.Clear;
  cdsDados.FieldDefs.Add('nuProcesso', ftString, 30);
  cdsDados.CreateDataSet;
  cdsDados.LogChanges := False;
  if psCdProcesso = sCODIGO_PROCESSO_COM_APENSO then
  begin
    cdsDados.Insert;
    cdsDados.FieldByName('nuProcesso').AsString := '00000560420128240023';
    cdsDados.Post;
    cdsDados.Insert;
    cdsDados.FieldByName('nuProcesso').AsString := '07001387320118240008';
    cdsDados.Post;
    result := cdsDados.Data;
  end
  else
  begin
    result := null;
  end;
end;

function TfpgValidadorLocalizacaoFisicaProcessoApensoFake.TestarSeLocalFisicoDiferenteDoProcesso(
  psCdProcesso: string; pnCdLocalFisico: integer): boolean;
begin
  result := False;

  if pnCdLocalFisico = NUMERO_INDEFINIDO then
    Exit;
  result := pnCdLocalFisico <> nCODIGO_LOCAL_FISICO_2;
end;

{ TfpgValidadorLocalizacaoFisicaProcessoApensoTests }

procedure TfpgValidadorLocalizacaoFisicaProcessoApensoTests.SetUp;
begin
  inherited;
  FoValidadorLocalizacaoFisicaProcessoApenso := TfpgValidadorLocalizacaoFisicaProcessoApensoFake.Create(); //PC_OK
end;

procedure TfpgValidadorLocalizacaoFisicaProcessoApensoTests.TearDown;
begin
  inherited;
  FreeAndNil(FoValidadorLocalizacaoFisicaProcessoApenso); //PC_OK
end;

procedure TfpgValidadorLocalizacaoFisicaProcessoApensoTests.
TestTestarProcessoPossuiApensoSemLocalFisico;
begin
  CheckFalse(FoValidadorLocalizacaoFisicaProcessoApenso.TestarProcessoPossuiApenso(
    sCODIGO_PROCESSO_COM_APENSO, NUMERO_INDEFINIDO));
end;

procedure TfpgValidadorLocalizacaoFisicaProcessoApensoTests.
TestTestarProcessoPossuiApensoMesmoLocalFisico;
begin
  CheckFalse(FoValidadorLocalizacaoFisicaProcessoApenso.TestarProcessoPossuiApenso(
    sCODIGO_PROCESSO_COM_APENSO, nCODIGO_LOCAL_FISICO_2));
end;

procedure TfpgValidadorLocalizacaoFisicaProcessoApensoTests.
TestTestarProcessoPossuiApensoLocalFisicoDiferente;
begin
  CheckTrue(FoValidadorLocalizacaoFisicaProcessoApenso.TestarProcessoPossuiApenso(
    sCODIGO_PROCESSO_COM_APENSO, nCODIGO_LOCAL_FISICO_1));
end;

procedure TfpgValidadorLocalizacaoFisicaProcessoApensoTests.
TestTestarProcessoPossuiApensoComApenso;
begin
  CheckTrue(FoValidadorLocalizacaoFisicaProcessoApenso.TestarProcessoPossuiApenso(
    sCODIGO_PROCESSO_COM_APENSO, nCODIGO_LOCAL_FISICO_1));
end;

procedure TfpgValidadorLocalizacaoFisicaProcessoApensoTests.
TestTestarProcessoPossuiApensoSemApenso;
begin
  CheckFalse(FoValidadorLocalizacaoFisicaProcessoApenso.TestarProcessoPossuiApenso(
    sCODIGO_PROCESSO_SEM_APENSO, nCODIGO_LOCAL_FISICO_1));
end;

initialization

  TestFramework.RegisterTest(
    'Unitário\PG5\Componentes\ValidadorLocalizacaoFisicaProcessoApensoTests',
    TfpgValidadorLocalizacaoFisicaProcessoApensoTests.Suite);

end.

