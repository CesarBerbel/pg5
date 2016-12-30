// 22/12/2015 - cesar.almeida - SALT: 186660/23/2
// Refatoração da classe
unit ufpgCadPautaAudienciaTests;

interface

uses
  ufpgCadPautaAudiencia, ufpgGUITestCase, ufpgCadPautaAudienciaModelTests, ufpgDataModelTests;

type
  TffpgCadPautaAudienciaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadPautaAudiencia;
    FoDados: TffpgCadPautaAudienciaModelTests;
    procedure CadPautaAudiencia;
    procedure PreencherDadosPautaAudiencia;
    procedure LocalizarHorario;
    procedure Agendar;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadPautaAudiencia;
    procedure TestarModificarAudiencia;
  end;

implementation

uses
  TestFrameWork, usajConstante, ufpgCadProcessoTests, FutureWindows, Forms,
  ufpgEdicaoDocumentoTests, ufpgEdicaoDocumentoModelTests, ufpgConstanteGUITests,
  SysUtils, ufpgFuncoesGUITestes, ufpgVariaveisTestesGUI;

{ TffpgCadPautaAudienciaTests }

function TffpgCadPautaAudienciaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadPautaAudienciaModelTests;
end;

procedure TffpgCadPautaAudienciaTests.Agendar;
begin
  FoTela.TBXItem2.Click;
end;

procedure TffpgCadPautaAudienciaTests.LocalizarHorario;
begin
  FoTela.tbxiLocalizarHorario.Click;
end;

procedure TffpgCadPautaAudienciaTests.PreencherDadosPautaAudiencia;
var
  dDataAudiencia: TDateTime;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.fsajVaraConsCadastro.dfcdVara, FoDados.fpgCdVara, False);

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  EnterTextInto(FoTela.sajNumeroProcessoCadastro.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcesso, False);

  EnterTextInto(FoTela.ggpTipoAudienciaCons.dfCodigo, FoDados.fpgCdTipoAudiencia, False);

  if FoDados.fpgNuDias = STRING_INDEFINIDO then
    FoDados.fpgNuDias := '1';

  if FoDados.fpgDtPeriodoInicial = STRING_INDEFINIDO then
    dDataAudiencia := Now + StrToInt(FoDados.fpgNuDias)
  else
    dDataAudiencia := strToDateTime(FoDados.fpgDtPeriodoInicial);

  // 01/11/16 - cesar.almeida - Inserir Complemento da movimentação
  // Foi colocado a verificação porque dependendo do tipo da audiência o sistema sugere a melhor data inicial
  if FoTela.dxdePeriodoInicial.EstaNulo and (FoDados.fpgDtPeriodoInicial = STRING_INDEFINIDO) then
    FoTela.dxdePeriodoInicial.Value := dDataAudiencia;
end;

procedure TffpgCadPautaAudienciaTests.TestarCadPautaAudiencia;
begin
  ExecutarRoteiroTestes(CadPautaAudiencia);
end;

procedure TffpgCadPautaAudienciaTests.TestarModificarAudiencia;
begin
  ExecutarRoteiroTestes(CadPautaAudiencia);
end;

procedure TffpgCadPautaAudienciaTests.CadPautaAudiencia;
begin
  AbrirTela;
  FoTela := TffpgCadPautaAudiencia(spTela);
  FoDados := TffpgCadPautaAudienciaModelTests(spDataModelTests);

  if FoDados.fpgAudienciaBloco then
    spVerificadorTelas.RegistrarMensagem('A configuração para este tipo de*', 'Sim', 1000);

  //Pauta Audiencia
  PreencherDadosPautaAudiencia;
  LocalizarHorario;
  Agendar;
  Application.ProcessMessages;
  gsDataAudiencia := FormatDateTime(CS_MASCARA_DATA_CURTA,
    FoTela.eggpAudiencia.FieldByName('CC_DATAINICIO').AsDateTime);
  FecharTela;
end;

end.

