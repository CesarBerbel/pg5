unit ufpgConfigIntimaAdvTests;

interface

uses
  TestFrameWork, ufpgConfigIntimaAdv, ufpgGUITestCase, ufpgConfigIntimaAdvModelTests,
  ufpgDataModelTests, SysUtils, Windows, FutureWindows, DB;

type
  TffpgConfigIntimaAdvTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgConfigIntimaAdv;
    FoDados: TffpgConfigIntimaAdvModelTests;
    procedure ConfigIntimaAdv;
    procedure PreencherDados;
    procedure SelecionarAgente;
    procedure Certificar;
    procedure LiberarDocumento(const poWindow: IWindow);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarConfigIntimaAdv;
  end;

implementation

{ TffpgConfigIntimaAdvTests }

uses
  usajConstante, ufpgFuncoesGUITestes, Forms, usajConsAgente, uspInterface,
  ufpgCertEmiIntimaAdv, udigSelecaoCertificadoDigital, ufpgVariaveisTestesGUI,
  uspEntidade, usajLotacao;

procedure TffpgConfigIntimaAdvTests.TestarConfigIntimaAdv;
begin
  ExecutarRoteiroTestes(ConfigIntimaAdv);
end;

procedure TffpgConfigIntimaAdvTests.ConfigIntimaAdv;
begin
  FoDados := TffpgConfigIntimaAdvModelTests(spDataModelTests);

  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgConfigIntimaAdv');

  FoTela := TffpgConfigIntimaAdv(spTela);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
  begin
    FoDados.fpgNuProcesso := UsarProcessoArray;
    FoDados.fpgCdProcesso := gsCDProcesso;
    FoDados.fpgCdForo := IntToStr(sajLotacaoUsuario.FnCdForo);
  end;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado.');

  PreencherDados;

  if FoDados.fpgFecharTela then
    FecharTela;

  Check(FoDados.VerificarGeraIntimacao(FoDados.fpgCdForo, FoDados.fpgCdProcesso,
    FoDados.fpgCdVara, FoDados.fpgPessoa, gsNuRelacao), 'Intimacao não foi gerada.');
end;

function TffpgConfigIntimaAdvTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgConfigIntimaAdvModelTests;
end;

procedure TffpgConfigIntimaAdvTests.PreencherDados;
begin

  EnterTextInto(FoTela.csVara.dfcdVara, FoDados.fpgCdVara);

  if FoDados.fpgNovaRelacao then
  begin
    FoTela.pbNovaRelacao.click;
    gsNuRelacao := FoTela.nuRelacao.dfnuRelacao.PegaTexto;
    gsSeqRelacao := Copy(gsNuRelacao, 5, Length(gsNuRelacao));
  end;

  if FoDados.fpgConsultaProcPublicar then
  begin
    EnterTextInto(FoTela.spPeriodoPesq.FdfDataInicial, DateToStr(Now));
    EnterTextInto(FoTela.spPeriodoPesq.FdfDataFinal, DateToStr(Now));
    FoTela.pbPesquisar.click;
    sleep(1000);
    Application.ProcessMessages;
    FoTela.grProc.DataSource.DataSet.Locate('CC_NUPROCESSO', FoDados.fpgNuProcesso, []);
  end;

  FoTela.pcPastaCadastro.ActivePage := FoTela.tsConfig;
  FoTela.pcPastaCadastroChange(FoTela);

  if FoTela.dfnuProcesso.FdfNumeroProcessoExterno.EstaNulo then
  begin
    EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
    FoTela.ccpai.Execute(acSalvar);
  end;


  if FoTela.grAdv.DataSource.DataSet.RecordCount = 0 then
  begin
    //    TODO: Cadastrar Advogado;
  end
  else
  if FoTela.grAdv.DataSource.DataSet.RecordCount > 0 then
  begin
    FoTela.grAdv.DataSource.DataSet.First;
    FoDados.fpgPessoa := FoTela.grAdv.DataSource.DataSet.FieldByName('CC_NMPESSOA').AsString;
  end;

  FoTela.pcPastaCadastro.ActivePage := FoTela.tsFinaliza;
  FoTela.pcPastaCadastroChange(FoTela);
  SelecionarAgente;

  if FoDados.fpgFinalizar then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'Após finalizar a relação nenhuma alteração será permitida. Deseja finalizar?', 'Sim');
    FoTela.pbFinalizar.Click;
    Certificar;
  end;
end;

procedure TffpgConfigIntimaAdvTests.SelecionarAgente;
var
  oTelaAgente: TfsajConsAgente;
  sAgente: string;
begin
  repeat
    if FoTela.csJuiz.EstaNulo then
    begin
      FoTela.csJuiz.pbConsulta.click;
      sAgente := FoDados.fpgJuiz;
    end
    else
    if FoTela.csEscrivao.EstaNulo then
    begin
      FoTela.csEscrivao.pbConsulta.click;
      sAgente := FoDados.fpgEscrivao;
    end;

    oTelaAgente := PegarTela('fsajConsAgente') as TfsajConsAgente;
    EnterTextGrid(oTelaAgente.grFiltro, sAgente, 1);
    EnterTextGrid(oTelaAgente.grDados, sAgente, 1);
    oTelaAgente.ccCadastro.Execute(acSelecionar);
    application.ProcessMessages;
  until (not FoTela.csJuiz.EstaNulo) and (not FoTela.csEscrivao.EstaNulo);
end;

procedure TffpgConfigIntimaAdvTests.Certificar;
var
  oTelaCert: TffpgCertEmiIntimaAdv;
  sNuProcesso: string;
begin
  oTelaCert := PegarTela('ffpgCertEmiIntimaAdv') as TffpgCertEmiIntimaAdv;
  sNuProcesso := SomenteNumeros(oTelaCert.grDados.DataSource.DataSet.FieldByName(
    'CC_NUPROCESSOFMT').AsString);

  if FoDados.fpgCertifica then
  begin
    if sNuProcesso <> FoDados.fpgNuProcesso then
    begin
      oTelaCert.grDados.DataSource.DataSet.First;
      while not oTelaCert.grDados.DataSource.DataSet.EOF do
      begin
        sNuProcesso := SomenteNumeros(oTelaCert.grDados.DataSource.DataSet.FieldByName(
          'CC_NUPROCESSOFMT').AsString);
        if sNuProcesso = FoDados.fpgNuProcesso then
        begin
          oTelaCert.grDados.DataSource.DataSet.Edit;
          oTelaCert.grDados.DataSource.DataSet.FieldByName('CC_FLIMPRIMIR').AsString := sFLAG_SIM;
          oTelaCert.grDados.DataSource.DataSet.Post;
          Break;
        end
        else
          oTelaCert.grDados.DataSource.DataSet.Next;
      end;
    end;

    TFutureWindows.Expect('TfdigSelecaoCeritificadoDigital', 1000).ExecProc(LiberarDocumento);
    oTelaCert.ccCadastro.Execute(acImprimir);
  end
  else
    oTelaCert.ccCadastro.Execute(acFecharForm);
end;


procedure TffpgConfigIntimaAdvTests.LiberarDocumento(const poWindow: IWindow);
var
  oTelaFinalizar: TfdigSelecaoCeritificadoDigital;
begin
  oTelaFinalizar := poWindow.asControl as TfdigSelecaoCeritificadoDigital;
  EnterTextInto(oTelaFinalizar.cbCertificados, FoDados.fpgCertificado);
  spVerificadorTelas.RegistrarMensagem(
    'As certidões foram geradas com sucesso para os processos selecionados.', 'OK');
  oTelaFinalizar.dxbbBotoesSelecionar.Click;
end;

end.

