unit ufpgControleBotaoCancelamentoFinalizacaoTests;

interface

uses
  SysUtils, Classes, ufpgControleBotaoCancelamentoFinalizacao, uspTestCase,
  ufpgControleBotaoCancelamentoFinalizacaoFake, TestFrameWork;

type
  TfpgControleBotaoCancelamentoFinalizacaoTests = class(TspTestCase)
  private
    FoCtrlBotaoCancelamentoFinalizacao: TfpgControleBotaoCancelamentoFinalizacaoFake;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarBotaoHabilitadoParametrosVazio;
    procedure TestarBotaoHabilitadoParametrosComportamentoProcDigital;
    procedure TestarBotaoHabilitadoParametrosComportamentoProcFisico;
    procedure TestarBotaoHabilitadoParametrosProcForaFluxoComportamentoProcDigital;
    procedure TestarBotaoHabilitadoParametrosForaFluxoComportamentroProcFisico;
  end;

implementation

uses
  usajConstante, uedtConstantes;

procedure TfpgControleBotaoCancelamentoFinalizacaoTests.SetUp;
begin
  FoCtrlBotaoCancelamentoFinalizacao := TfpgControleBotaoCancelamentoFinalizacaoFake.Create(nil); //PC_OK
end;

procedure TfpgControleBotaoCancelamentoFinalizacaoTests.TearDown;
begin
  FreeAndNil(FoCtrlBotaoCancelamentoFinalizacao); //PC_OK
end;

procedure TfpgControleBotaoCancelamentoFinalizacaoTests.TestarBotaoHabilitadoParametrosVazio;
begin
  FoCtrlBotaoCancelamentoFinalizacao.fpgParametroDocumentoControladoFluxo := STRING_INDEFINIDO;
  CheckFalse(FoCtrlBotaoCancelamentoFinalizacao.TestarDeveHabilitarBotao(False));
end;

procedure TfpgControleBotaoCancelamentoFinalizacaoTests.
TestarBotaoHabilitadoParametrosComportamentoProcDigital;
begin
  FoCtrlBotaoCancelamentoFinalizacao.fpgParametroDocumentoControladoFluxo :=
    s_DOC_FLUXO_COMPORTAMENTO_PROC_DIGITAL;
  CheckTrue(FoCtrlBotaoCancelamentoFinalizacao.TestarDeveHabilitarBotao(False));
end;

procedure TfpgControleBotaoCancelamentoFinalizacaoTests.
TestarBotaoHabilitadoParametrosComportamentoProcFisico;
begin
  FoCtrlBotaoCancelamentoFinalizacao.fpgParametroDocumentoControladoFluxo :=
    s_DOC_FLUXO_COMPORTAMENTO_PROC_FISICO;
  CheckTrue(FoCtrlBotaoCancelamentoFinalizacao.TestarDeveHabilitarBotao(True));
end;

procedure TfpgControleBotaoCancelamentoFinalizacaoTests.
TestarBotaoHabilitadoParametrosProcForaFluxoComportamentoProcDigital;
begin
  FoCtrlBotaoCancelamentoFinalizacao.fpgParametroDocumentoControladoFluxo :=
    s_DOC_FLUXO_PROC_FORA_FLUXO_COMPORTAMENTO_PROC_DIGITAL;
  CheckTrue(FoCtrlBotaoCancelamentoFinalizacao.TestarDeveHabilitarBotao(False));
end;

procedure TfpgControleBotaoCancelamentoFinalizacaoTests.
TestarBotaoHabilitadoParametrosForaFluxoComportamentroProcFisico;
begin
  FoCtrlBotaoCancelamentoFinalizacao.fpgParametroDocumentoControladoFluxo :=
    s_DOC_FORA_FLUXO_COMPORTAMENTRO_PROC_FISICO;
  CheckFalse(FoCtrlBotaoCancelamentoFinalizacao.TestarDeveHabilitarBotao(False));
end;

initialization
  TestFrameWork.RegisterTest(
    'Unitário\PG5\Componentes\ufpgControleBotaoCancelamentoFinalizacaoTests',
    TfpgControleBotaoCancelamentoFinalizacaoTests.Suite);

end.
