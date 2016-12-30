//28/04/2016 - Shirleano.Junior - Task: 43059
//Refatorado.
unit ufpgRecebimentoTests;

interface

uses
  ufpgRecebimento, ufpgGUITestCase, ufpgRecebimentoModelTests, ufpgDataModelTests;

type
  TffpgRecebimentoTests = class(TfpgGUITestCase)
  private
    procedure ReceberRemessa;
    procedure PreencherDados;
    procedure ConfirmarRecebimento;
    procedure ConsultarLoteParaReceber;
  public
    FoTela: TffpgRecebimento;
    FoDados: TffpgRecebimentoModelTests;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarReceberRemessa;
    procedure TestarConsultarLoteParaReceber;
  end;

implementation

uses
  TestFrameWork, SysUtils, uspInterface, usajConstante, ufpgVariaveisTestesGUI,
  FutureWindows, ucgoConfirmacao, Forms, ufpgFuncoesGUITestes, ucgoConsLoteCarga;

{ TffpgRecebimentoTests }

function TffpgRecebimentoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRecebimentoModelTests;
end;

procedure TffpgRecebimentoTests.PreencherDados;
begin
  if FoDados.fpgNuLoteRecebimento then
  begin
    if FoDados.fpgNuLote = STRING_INDEFINIDO then
      FoDados.fpgNuLote := copy(gsNuLote, 5, Length(gsNuLote));

    EnterTextInto(FoTela.csLote.dfnuLote, FoDados.fpgNuLote, False);
    checkFalse(FoTela.csLote.dfnuLote.EstaNulo, 'O lote ' + FoDados.fpgNuLote +
      ' não foi encontrado em carga para recebimento');
  end
  else
  begin
    TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;

    if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
      FoDados.fpgNuProcesso := UsarProcessoArray;
    Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

    EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
    checkFalse(FoTela.dfnuProcesso.FdfNumeroProcessoExterno.EstaNulo, 'Processo ' +
      FoDados.fpgNuProcesso + ' não foi encontrado em carga para recebimento');
  end;
  EnterTextInto(FoTela.cgoLocalizacao.csTipoLocalOrigem.dfCdTipoLocal, FoDados.fpgTipoLocalOrigem);
  EnterTextInto(FoTela.cbTipoCarga, FoDados.fpgTipoCarga);
  EnterTextInto(FoTela.cgoLocalizacao.csLocalOrigem.dfcdLocal, FoDados.fpgLocalOrigem);
end;

procedure TffpgRecebimentoTests.ConfirmarRecebimento;
var
  oTelaConfirmacao: TfcgoConfirmacao;
begin
  spVerificadorTelas.RegistrarMensagem('A carga foi recebida com sucesso.', 'OK');
  oTelaConfirmacao := PegarTela('fcgoConfirmacao') as TfcgoConfirmacao;
  EnterTextInto(oTelaConfirmacao.dfedSenha, spSenha);
  oTelaConfirmacao.ccCadastro.Execute(acSelecionar);
end;

procedure TffpgRecebimentoTests.ReceberRemessa;
begin
  AbrirTela;
  FoTela := TffpgRecebimento(spTela);
  FoDados := TffpgRecebimentoModelTests(spDataModelTests);
  if FoDados.fpgReceberRemessa then
  begin
    PreencherDados;
    FoTela.pbReceber.Click;
    ConfirmarRecebimento;
    check(FoDados.VerificaRecebimentoNuLote(gsNuLote, FoDados.fpgForo), 'O lote ' +
      gsNuLote + ' não foi recebido');
  end
  else
    ConsultarLoteParaReceber;
end;

procedure TffpgRecebimentoTests.TestarReceberRemessa;
begin
  ExecutarRoteiroTestes(ReceberRemessa);
end;

procedure TffpgRecebimentoTests.TestarConsultarLoteParaReceber;
begin
  ExecutarRoteiroTestes(ReceberRemessa);
end;

procedure TffpgRecebimentoTests.ConsultarLoteParaReceber;
var
  oTelaConsultaLote: TfcgoConsLoteCarga;
  bEncontrou: boolean;
begin
  FoTela.csLote.pbConsulta.Click;
  oTelaConsultaLote := TfcgoConsLoteCarga(PegarTela('fcgoConsLoteCarga'));

  bEncontrou := False;
  oTelaConsultaLote.grDados.DataSource.DataSet.First;
  while not oTelaConsultaLote.grDados.DataSource.DataSet.EOF do
  begin
    if oTelaConsultaLote.grDados.DataSource.DataSet.FieldByName('CC_NULOTEALTERADO').AsString =
      gsNuLote then
    begin
      bEncontrou := True;
      break;
    end;
    oTelaConsultaLote.grDados.DataSource.DataSet.Next;
  end;

  check(bEncontrou, 'o lote ' + gsNuLote + ' não esta para ser recebido');
end;

end.

